# sample hyprlock.conf
# for more configuration options, refer https://wiki.hyprland.org/Hypr-Ecosystem/hyprlock
#
# rendered text in all widgets supports pango markup (e.g. <b> or <i> tags)
# ref. https://wiki.hyprland.org/Hypr-Ecosystem/hyprlock/#general-remarks
#
# shortcuts to clear password buffer: ESC, Ctrl+U, Ctrl+Backspace
#
# you can get started by copying this config to ~/.config/hypr/hyprlock.conf
#

$font = GohuFont 14 NerdFont

general {
    hide_cursor = false
    ignore_empty_input = false
    immediate_render = false
    text_trim = true
    fractional_scaling = 2
    screencopy_mode = 0 # 0-GPU accelerated 1-cpu based
    fail_timeout = 2000
}

# uncomment to enable fingerprint authentication
# auth {
#     pam {
#         enabled = true
#         module = hyprlock
#     }
#     fingerprint {
#         enabled = true
#         ready_message = Scan fingerprint to unlock
#         present_message = Scanning...
#         retry_delay = 250 # in milliseconds
#     }
# }

animations {
    enabled = true
    bezier = linear, 1, 1, 0, 0
    animation = fadeIn, 1, 5, linear
    animation = fadeOut, 1, 5, linear
    animation = inputFieldDots, 1, 2, linear
}

# BACKGROUND
background {
    monitor =
    path = <%PATH_TO_WALLPAPER%>
    color = rgba(17, 17, 17, 1.0)
    blur_passes = 2
    blur_size = 7
    noise = 0.0117
    contrast = 0.8916
    brightness = 0.8172
    vibrancy = 0.1696
    vibrancy_darkness = 0.0
    reload_time = -1
    #reload_cmd = ''
    crossfade_time = -1.0
    zindex = -1
}

# Profile-Photo
# image {
#     monitor =
#     path = <%PATH_TO_PROFILE_IMG%> 
#     size = 120
#     rounding = -1
#     border_size = 0
#     border_color = 0xffdddddd
#     rotate = 0
#     reload_time = -1
#     reload_cmd = 
#     position = 0, -20
#     halign = center
#     valign = center
#     zindex = 0
# }

shape {
    monitor =
    size = 360, 60
    color = rgba(0, 0, 0, 0.0) # no fill
    rounding = -1 # circle
    rotate = 0
    border_size = 4
    border_color = rgba(0, 207, 230, 1.0)
    xray  = false

    position = 0, -225
    halign = center
    valign = center
    zindex = 0
}

# INPUT FIELD
input-field {
    monitor =
    size = 360, 60
    outline_thickness = 2
    dots_size = 0.2 # Scale of input-field height, 0.2 - 0.8
    dots_spacing = 0.2 # Scale of dots' absolute size, 0.0 - 1.0
    dots_center = true
    dots_rounding = -1
    dots_text_format = 
    outer_color = rgba(0, 0, 0, 0)
    inner_color = rgba(100, 114, 125, 0.4)
    font_color = rgb(200, 200, 200)
    font_family = $font
    fade_on_empty = false
    fade_timeout = 2000
    placeholder_text = <i><span foreground="##ffffff99">Password</span></i>
    hide_input = false
    #hide_input_base_color = 
    rounding = -1
    check_color = rgba(204, 136, 34, 1.0)
    fail_color = rgba(204, 34, 34, 1.0)
    fail_text = <i>$FAIL <b>($ATTEMPTS)</b></i>
    capslock_color = 
    numlock_color =
    bothlock_color =
    invert_numlock = false
    swap_font_color = false
    position = 0, -225
    halign = center
    valign = center
    zindex = 0
}

# Time
label {
    monitor =
    text = cmd[update:1000] echo "<span>$(date +"%H:%M")</span>"
    color = rgba(216, 222, 233, 0.70)
    font_size = 130
    font_family = $font
    position = 0, 240
    halign = center
    valign = center
}

# Day-Month-Date
label {
    monitor =
    text = cmd[update:1000] echo -e "$(date +"%A, %d %B")"
    color = rgba(216, 222, 233, 0.70)
    font_size = 30
    font_family = $font
    position = 0, 105
    halign = center
    valign = center
}


# USER
label {
    monitor =
    text = $USER
    color = rgba(216, 222, 233, 0.70)
    font_size = 25
    font_family = $font
    position = 0, -130
    halign = center
    valign = center
}
