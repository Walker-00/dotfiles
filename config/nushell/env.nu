# env.nu
#
# Installed by:
# version = "0.101.0"
#
# Previously, environment variables were typically configured in `env.nu`.
# In general, most configuration can and should be performed in `config.nu`
# or one of the autoload directories.
#
# This file is generated for backwards compatibility for now.
# It is loaded before config.nu and login.nu
#
# See https://www.nushell.sh/book/configuration.html
#
# Also see `help config env` for more options.
#
# You can remove these comments if you want or leave
# them for future reference.

# $env.CARAPACE_BRIDGES = 'zsh,fish,bash,inshellisense' # optional
mkdir ~/.cache/carapace
# carapace _carapace nushell | save --force ~/.cache/carapace/init.nu

$env.PATH = ($env.PATH | append "/home/walker/.cargo/bin")
$env.PATH = ($env.PATH | append "/home/walker/.surrealdb")
$env.PATH = ($env.PATH | append "/opt/android-sdk/tools/bin")
$env.PATH = ($env.PATH | append "/opt/android-sdk/platform-tools")
$env.PATH = ($env.PATH | append "/opt/android-sdk/tools")
$env.PATH = ($env.PATH | append "/usr/lib/jvm/java-23-openjdk/bin")
$env.JAVA_HOME = "/usr/lib/jvm/java-23-openjdk" 

source /home/walker/.config/nushell/starship.nu
cat ~/.cache/ags/user/generated/terminal/sequences.txt
zoxide init nushell | save -f ~/.zoxide.nu
fetrust
