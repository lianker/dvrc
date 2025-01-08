# -- Buf Fix for this issues: -- #############################################
# -- -> https://github.com/microsoft/terminal/issues/13710
# -- -> https://github.com/nushell/nushell/issues/10671
# -- -> https://github.com/microsoft/terminal/issues/16769
# Configuration to workaround a bug where a new line is added for each key 
# pressed

if $env.OS? == "Windows_NT" {
  $env.config = {
    shell_integration: {
      osc133: false
    }  
  }  
}

# Define Hellix as default editor
$env.config.buffer_editor = "hx"

# TODO: Check if theme file exists before source
source themes/solarized-light.nu
$env.LS_COLORS = (vivid generate solarized-light | str trim)

$env.ASDF_DIR = ($env.HOME | path join '.asdf')
 source /home/deztro/.asdf/asdf.nu