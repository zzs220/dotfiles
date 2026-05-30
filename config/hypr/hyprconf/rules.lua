--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------

-- See https://wiki.hypr.land/Configuring/Basics/Window-Rules/
-- and https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/

local suppressMaximizeRule = hl.window_rule({
    -- Ignore maximize requests from all apps. You'll probably like this.
    name  = "suppress-maximize-events",
    match = { class = ".*" },

    suppress_event = "maximize",
})
-- suppressMaximizeRule:set_enabled(false)

hl.window_rule({
    -- Fix some dragging issues with XWayland
    name  = "fix-xwayland-drags",
    match = {
        class      = "^$",
        title      = "^$",
        xwayland   = true,
        float      = true,
        fullscreen = false,
        pin        = false,
    },

    no_focus = true,
})

-- Layer rules also return a handle.
-- local overlayLayerRule = hl.layer_rule({
--     name  = "no-anim-overlay",
--     match = { namespace = "^my-overlay$" },
--     no_anim = true,
-- })
-- overlayLayerRule:set_enabled(false)

-- Hyprland-run windowrule
hl.window_rule({
    name  = "move-hyprland-run",
    match = { class = "hyprland-run" },
    move  = "20 monitor_h-120",
    float = true,
})

hl.window_rule({
  name = "floating-terminal",
  match = {class = ".*(hypr-floating-terminal).*"},
  size =  {"(monitor_w*0.5)", "(monitor_h*0.5)"},
  float = true,
  pin =  true,
})

hl.window_rule({
  name = "Picture-in-Picture",
  match =  {title = "^Picture-in-Picture$"},
  float =  true,
  pin =  true,
  size =  {"(monitor_w*0.5)", "(monitor_h*0.5)"},
  no_dim = true,
  opacity =  "0.9",
  keep_aspect_ratio = true,
})

hl.window_rule({
  name = "translucency",
  match =  {class = ".*"},
  opacity =  "0.9",
})

hl.window_rule({
  name = "mpv",
  match =  {class = "^(mpv)$"},
  idle_inhibit = "focus",
  opacity =  "1",
})
hl.window_rule({
  name = "browser",
  match =  {class = ".*(firefox|chromium|brave|zen).*"},
  opacity =  "1",
})
