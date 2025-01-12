-- # General Setup
local wezterm = require 'wezterm'
local act = wezterm.action

local config = wezterm.config_builder()

-- Disable All Preconfigs to set exaclly what I want
config.disable_default_key_bindings = true

-- Define A-w as LEADER command
config.leader = {key = "w", mods = "ALT"}
config.keys = {}

-- Copy and Paste keybindings
-- Activate Copy mode: C-S-X
table.insert(config.keys,
  { key = 'X', mods = 'CTRL', action = wezterm.action.ActivateCopyMode }
)
-- paste from the clipboard
table.insert(config.keys,
  { key = "V", mods = "CTRL", action = act.PasteFrom "Clipboard" }
)

table.insert(config.keys,
  -- paste from the primary selection
  { key = "V", mods = "CTRL", action = act.PasteFrom "PrimarySelection" }
)

-- # Apearence and Colors
config.font = wezterm.font("JetBrains Mono") 
config.font_size = 12.0
config.color_scheme = "Solarized Light (Gogh)"

-- Keybindings to "Zoom" in and Out
table.insert(config.keys,
  { key = '=', mods = 'CTRL', action = wezterm.action.IncreaseFontSize }
)

table.insert(config.keys, 
  { key = '-', mods = 'CTRL', action = wezterm.action.DecreaseFontSize }
)

table.insert(config.keys,
  { key = '0', mods = 'CTRL', action = wezterm.action.ResetFontSize }
)

-- Reload Configurations
table.insert(config.keys,
  {
    key = 'r',
    mods = 'LEADER',
    action = wezterm.action.ReloadConfiguration,
  }
)

-- # Window configurations
config.window_padding = {
  left = 10,
  right = 10,
  top = 10,
  bottom = 10,
}

-- # Tab Configs
config.enable_tab_bar = true
config.hide_tab_bar_if_only_one_tab = true

-- ## Tab Keybinding

table.insert(config.keys, 
  {
    key = 't',
    mods = 'CTRL|SHIFT',
    action = act.SpawnTab 'CurrentPaneDomain',
  }
)

table.insert(config.keys, 
  {
    key = 'w',
    mods = 'CTRL|SHIFT',
    action = act.CloseCurrentTab { confirm = true },
  }
)

-- # Panels
-- ## Panel Spliting

-- Split Vertical
table.insert(config.keys,
  {
    key = "+",
    mods = "ALT|SHIFT",
    action = act.SplitHorizontal { domain = "CurrentPaneDomain" },
  }
)

-- Split Horizontal
table.insert(config.keys,
  {
    key = "_",
    mods = "ALT|SHIFT",
    action = act.SplitVertical { domain = "CurrentPaneDomain" },
  }
)

-- Close Current panel
table.insert(config.keys,
  {
    key = "q", 
    mods = "ALT|SHIFT",
    action = act.CloseCurrentPane { confirm = true }, 
  }
)

-- Toggle current panel zoom
table.insert(config.keys,
  {
    key = 'z',
    mods = 'ALT',
    action = act.TogglePaneZoomState,
  }  
)

-- ## Jump between panels

-- Jump to panel left
table.insert(config.keys, {
    key = "LeftArrow",
    mods = "ALT",
    action = act.ActivatePaneDirection("Left"),
  }
)

-- Jump to panel right
table.insert(config.keys, {
    key = "RightArrow",
    mods = "ALT",
    action = act.ActivatePaneDirection("Right"),
  }
)

-- Jumb to panel Up
table.insert(config.keys, {
    key = "UpArrow",
    mods = "ALT",
    action = act.ActivatePaneDirection("Up"),
  }
)

-- Jump to panel Down
table.insert(config.keys, {
    key = "DownArrow",
    mods = "ALT",
    action = act.ActivatePaneDirection("Down"),
  }
)


-- ## Adjust Pane Size
table.insert(config.keys,
  {
    key = "UpArrow",
    mods = "LEADER",
    action = act.AdjustPaneSize {"Up", 1},
  }
)

table.insert(config.keys,
  {
    key = "DownArrow",
    mods = "LEADER",
    action = act.AdjustPaneSize {"Down", 1},
  }
)

table.insert(config.keys,
    {
    key = "RightArrow",
    mods = "LEADER",
    action = act.AdjustPaneSize {"Right", 1},
  }
)

table.insert(config.keys, 
  { 
    key = "LeftArrow", 
    mods = "LEADER", 
    action = act.AdjustPaneSize {"Left", 1} 
  }
)

table.insert(config.keys,
  {
        key = "j",
        mods = "CTRL",
        action = wezterm.action_callback(function(_, pane)
            local tab = pane:tab()
            local panes = tab:panes_with_info()
            if #panes == 1 then
                pane:split({
                    direction = "Down",
                    size = 0.2,
                })
            elseif not panes[1].is_zoomed then
                panes[1].pane:activate()
                tab:set_zoomed(true)
            elseif panes[1].is_zoomed then
                tab:set_zoomed(false)
                panes[2].pane:activate()
            end
        end),
    }
)

-- # NuSHell
if wezterm.target_triple == "x86_64-pc-windows-msvc" then
  -- config.default_prog = {"C:/Program Files/PowerShell/7/pwsh.exe"}
  config.default_prog = {"nu"}
else
  -- config.default_prog = {"/usr/bin/bash"}
  config.default_prog = {"/home/linuxbrew/.linuxbrew/bin/nu"}
end

return config
