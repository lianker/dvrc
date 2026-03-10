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



$env.STARSHIP_SHELL = "nu"

def create_left_prompt [] {
    starship prompt --cmd-duration $env.CMD_DURATION_MS $'--status=($env.LAST_EXIT_CODE)'
}

# Use nushell functions to define your right and left prompt
$env.PROMPT_COMMAND = { || create_left_prompt }
$env.PROMPT_COMMAND_RIGHT = ""

# The prompt indicators are environmental variables that represent
# the state of the prompt
$env.PROMPT_INDICATOR = ""
$env.PROMPT_INDICATOR_VI_INSERT = ": "
$env.PROMPT_INDICATOR_VI_NORMAL = "〉"
$env.PROMPT_MULTILINE_INDICATOR = "::: "


# Define Hellix as default editor
$env.config.buffer_editor = "hx"

# TODO: Check if theme file exists before source
# source themes/solarized-light.nu
$env.LS_COLORS = (vivid generate tokyonight-night | str trim)

