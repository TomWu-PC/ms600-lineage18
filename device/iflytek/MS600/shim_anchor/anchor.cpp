// MS600: 空锚点 —— 唯一目的是让 libhidltransport / libhwbinder 的
// vendor 变体被安装到 /vendor/lib64（vendor 命名空间最保险）。
namespace { int ms600_shim_anchor_dummy; }
