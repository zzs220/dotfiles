---------------------
---- KEYBINDINGS ----
---------------------
local mainMod = "SUPER"
local scripts = os.getenv("HOME") .. "/.config/hypr/scripts/master"
local programs = require("hyprconf.programs")

hl.bind(mainMod .. " + " .. "Q", hl.dsp.exec_cmd(programs.terminal))
hl.bind(mainMod .. " + " .. "C", hl.dsp.window.close())
hl.bind(mainMod .. " + " .. "E", hl.dsp.exec_cmd(programs.filemanager))
hl.bind(mainMod .. " + " .. "F", hl.dsp.window.float())
hl.bind(mainMod .. " + " .. "F", hl.dsp.window.pin())
hl.bind(mainMod .. " + " .. "SHIFT" .. " + " .. "F", hl.dsp.window.fullscreen())
hl.bind(mainMod .. " + " .. "R", hl.dsp.exec_cmd(scripts .. "/open_launcher.sh"))
hl.bind(mainMod .. " + " .. "V", hl.dsp.exec_cmd(scripts .. "/open_clipboard.sh"))

-- Submap: subsystem

hl.bind("ALT" .. " + " .. "S", hl.dsp.submap("system"))

hl.define_submap("system","reset", function()
    hl.bind("B", hl.dsp.exec_cmd(programs.terminal .. "--class=hypr-floating-terminal -e bluetui"))
    hl.bind("W", hl.dsp.exec_cmd(programs.terminal .. "--class=hypr-floating-terminal -e sh -c wlctl || nmtui"))
    hl.bind("A", hl.dsp.exec_cmd(programs.terminal .. "--class=hypr-floating-terminal -e pulsemixer"))
    hl.bind("M", hl.dsp.exec_cmd(programs.terminal .. "--class=hypr-floating-terminal -e btop"))
    hl.bind("escape", hl.dsp.submap("reset"))
end)


-- Submap: power

hl.bind("ALT" .. " + " .. "P", hl.dsp.submap("power"))

hl.define_submap("power","reset", function()
    hl.bind("S", hl.dsp.exec_cmd("poweroff"))
    hl.bind("R", hl.dsp.exec_cmd("reboot"))
    hl.bind("L", hl.dsp.exec_cmd(scripts .. "/lock_screen.sh"))
    hl.bind("H", hl.dsp.exec_cmd(scripts .. "/toggle_idle.sh"))
    hl.bind("M", hl.dsp.exec_cmd("hyprshutdown || hyprctl dispatch exit"))
    hl.bind("escape", hl.dsp.submap("reset"))
end)


-- Move focus with mainMod + vim keys
hl.bind(mainMod .. " + " .. "H", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + " .. "L", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + " .. "K", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + " .. "J", hl.dsp.focus({ direction = "down" }))


for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    hl.bind(mainMod .. " + " .. key,             hl.dsp.focus({ workspace = i}))
    hl.bind(mainMod .. " + SHIFT + " .. key,     hl.dsp.window.move({ workspace = i }))
end

hl.bind(mainMod .. " + N", hl.dsp.focus({workspace = "e+1"}))
hl.bind(mainMod .. " + P", hl.dsp.focus({workspace = "e-1"}))

-- Example special workspace (scratchpad)
hl.bind(mainMod .. " + S",         hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Laptop multimedia keys for volume and LCD brightness
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),      { locked = true, repeating = true })
hl.bind("XF86AudioMute",        hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),     { locked = true, repeating = true })
hl.bind("XF86AudioMicMute",     hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),   { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp",  hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"),                  { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown",hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"),                  { locked = true, repeating = true })

-- Requires playerctl
hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),       { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),   { locked = true })


-- bar
hl.bind(mainMod .. " + " .. "b", hl.dsp.exec_cmd(scripts .. "/toggle_bar.sh"))
-- HyprShot
hl.bind(mainMod .. " + " .. "Print", hl.dsp.exec_cmd("hyprshot -m window -o ~/Pictures/HyprShots"))
hl.bind(mainMod .. " + " .. "SHIFT" .. " + " .. "Print", hl.dsp.exec_cmd("hyprshot -m output -o ~/Pictures/HyprShots"))
hl.bind(mainMod .. " + " .. "CTRL" .. " + " .. "Print", hl.dsp.exec_cmd("hyprshot -m region -o ~/Pictures/HyprShots"))
-- media control with playerctl
hl.bind(mainMod .. " + " .. "Home", hl.dsp.exec_cmd("playerctl previous"))
hl.bind(mainMod .. " + " .. "Insert", hl.dsp.exec_cmd("playerctl --all-players play-pause"))
hl.bind(mainMod .. " + " .. "End", hl.dsp.exec_cmd("playerctl next"))
hl.bind(mainMod .. " + " .. "Delete", hl.dsp.exec_cmd("playerctl shuffle toggle && notify-send --transient --urgency=low Shuffle $(playerctl shuffle)"))
