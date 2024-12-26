# -- Buf Fix for this issues: -- #############################################
# -- -> https://github.com/microsoft/terminal/issues/13710
# -- -> https://github.com/nushell/nushell/issues/10671
# -- -> https://github.com/microsoft/terminal/issues/16769
# Configuration to workaround a bug where a new line is added for each key 
# pressed

$env.config = {
  shell_integration: {
    osc133: false
  }  
}

$env.config.buffer_editor = "hx"