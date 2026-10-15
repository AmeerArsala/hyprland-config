-- See https://wiki.hypr.land/Nvidia/

hl.env("LIBVA_DRIVER_NAME", "nvidia")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("GBM_BACKEND", "nvidia-drm") -- remove this if you encounter crashes in firefox
hl.env("__GLX_VENDOR_LIBRARY_NAME", "nvidia")

hl.env("NVD_BACKEND", "direct")

hl.config({
    cursor = {
        no_hardware_cursors = true,
    },
})
