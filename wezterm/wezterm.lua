local wezterm = require 'wezterm';

return {
    color_scheme = "Gruvbox Dark",
    font = wezterm.font("Fira Code"),
    font_size = 12.0,
    enable_tab_bar = false,
    window_padding = { left = 0, right = 0, top = 0, bottom = 0, },
    skip_close_confirmation_for_processes_named = {
        "bash", "sh", "zsh", "fish", "tmux", 
    },
}
