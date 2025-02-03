# config.nu
#
# Installed by:
# version = "0.101.0"
#
# This file is used to override default Nushell settings, define
# (or import) custom commands, or run any other startup tasks.
# See https://www.nushell.sh/book/configuration.html
#
# This file is loaded after env.nu and before login.nu
#
# You can open this file in your default editor using:
# config nu
#
# See `help config nu` for more options
#
# You can remove these comments if you want or leave
# them for future reference.

$env.config.show_banner = false
$env.config.edit_mode = "vi"
$env.config.buffer_editor = "editor"

# "block", "underscore", "line", "blink_block", "blink_underscore", "blink_line", or "inherit"
$env.config.cursor_shape.vi_insert = "blink_line"       # Cursor shape in vi-insert mode
$env.config.cursor_shape.vi_normal = "blink_underscore"  # Cursor shape in normal vi mode


source ~/.atuin.nu
source ~/.zoxide.nu
source ~/.cache/carapace/init.nu

alias cd = z
