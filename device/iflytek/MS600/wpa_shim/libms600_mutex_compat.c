/*
 * libms600_mutex_compat.so — LD_PRELOAD shim for the stock wpa_supplicant
 *
 * Problem
 * -------
 * The MS600 ships an Android 8.1 vendor blob at /vendor/bin/hw/wpa_supplicant.
 * On normal shutdown its teardown path calls pthread_mutex_destroy() on a mutex
 * that has ALREADY been destroyed:
 *
 *     #02 pthread_mutex_destroy+160   bionic
 *     #03 eap_proxy_deinit+40         wpa_supplicant
 *     #04 eapol_sm_deinit+72
 *     #05 wpa_supplicant_deinit_iface+524
 *     #06 wpa_supplicant_deinit+140
 *     #07 main+1172
 *   Abort message: 'FORTIFY: pthread_mutex_destroy called on a destroyed mutex'
 *
 * Android 8.1's bionic tolerated this silently. Android 11's bionic added a
 * FORTIFY check that calls __fortify_fatal() -> abort() (SIGABRT).
 *
 * Effect: wpa_supplicant dies at every Wi-Fi teardown/reconfigure (~21 times per
 * 8h), leaving a tombstone each time. Functionally the work is already finished
 * by then and init restarts it, so Wi-Fi keeps working -- but it is still a crash.
 *
 * Fix
 * ---
 * Intercept pthread_mutex_destroy(). If the target's bionic state word is
 * PTHREAD_MUTEX_DESTROYED (0x1), return 0 silently instead of calling the real
 * implementation. Everything else is forwarded untouched.
 *
 * bionic layout note: state lives at offset 0 of pthread_mutex_t.
 *   0x0        = unlocked
 *   0x1        = PTHREAD_MUTEX_DESTROYED
 *   >0x1 (odd) = owned (the value is the owner's tid)
 * so comparing with == 0x1 is exact and will not misfire on a locked mutex.
 */

#include <dlfcn.h>
#include <pthread.h>
#include <stdint.h>

#define MS600_MUTEX_DESTROYED 0x1u

typedef int (*ms600_destroy_fn)(pthread_mutex_t*);

static ms600_destroy_fn ms600_real_destroy = 0;

int pthread_mutex_destroy(pthread_mutex_t* mutex) {
    if (mutex != 0) {
        uint32_t state = *(volatile uint32_t*)mutex;
        if (state == MS600_MUTEX_DESTROYED) {
            /* Already destroyed (8.1 allowed this; 11 aborts). Pretend success. */
            return 0;
        }
    }

    if (ms600_real_destroy == 0) {
        ms600_real_destroy =
                (ms600_destroy_fn)dlsym(RTLD_NEXT, "pthread_mutex_destroy");
        if (ms600_real_destroy == 0) {
            return 0;  /* cannot resolve; do not crash the process */
        }
    }
    return ms600_real_destroy(mutex);
}
