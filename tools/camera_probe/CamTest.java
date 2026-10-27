import android.content.Context;
import android.hardware.camera2.CameraCharacteristics;
import android.hardware.camera2.CameraManager;

public class CamTest {
    public static void main(String[] args) {
        try {
            android.os.Looper.prepare();
            Class<?> at = Class.forName("android.app.ActivityThread");
            Object thread = at.getMethod("systemMain").invoke(null);
            Context ctx = (Context) at.getMethod("getSystemContext").invoke(thread);
            CameraManager cm = (CameraManager) ctx.getSystemService(Context.CAMERA_SERVICE);
            String[] ids = cm.getCameraIdList();
            System.out.println("camera count = " + ids.length);
            for (String id : ids) {
                CameraCharacteristics c = cm.getCameraCharacteristics(id);
                Object facing = c.get(CameraCharacteristics.LENS_FACING);
                Object orient = c.get(CameraCharacteristics.SENSOR_ORIENTATION);
                Object level = c.get(CameraCharacteristics.INFO_SUPPORTED_HARDWARE_LEVEL);
                System.out.println("id=" + id);
                System.out.println("  LENS_FACING          = " + facing);
                System.out.println("  SENSOR_ORIENTATION   = " + orient);
                System.out.println("  HW_LEVEL             = " + level);
                System.out.println("  keys contains facing = " + c.getKeys().contains(CameraCharacteristics.LENS_FACING));
                System.out.println("  total keys           = " + c.getKeys().size());
            }
        } catch (Throwable t) {
            t.printStackTrace();
        }
    }
}
