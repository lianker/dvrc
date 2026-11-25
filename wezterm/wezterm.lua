-- # General Setup
local wezterm = require 'wezterm'
local os = require 'os'
local color_schemes = require 'color-schemes'

local act = wezterm.action
local config = wezterm.config_builder()

-- Use CMD on macOS, ALT elsewhere
local is_macos = (wezterm.target_triple or ""):find("darwin") ~= nil
local KALT = is_macos and "CMD" or "ALT"
local KALTSHIFT = KALT .. "|SHIFT"

-- Disable All Preconfigs to set exaclly what I want
-- config.disable_default_key_bindings = true

-- Define A-w as LEADER command
config.leader = {key = "w", mods = KALT}
config.keys = {}

config.initial_cols = 90
config.initial_rows = 35

-- # Apearence and Colors
-- config.font = wezterm.font("JetBrains Mono") 
-- config.font = wezterm.font("Courier Prime Code") 
config.font_size = 13.0
config.color_schemes = color_schemes
config.color_scheme = "spacebones-light"

table.insert(config.keys, 
    {
      key = 'I',
      mods = 'CTRL|SHIFT',
      action = wezterm.action_callback(
        function(win, pane)
          -- https://github.com/wezterm/wezterm/issues/4429
          local overrides = win:get_config_overrides() or {}
          if not overrides.color_scheme then
            overrides.color_scheme =  'spacebones-dark'
          else
            overrides.color_scheme = nil
          end
          win:set_config_overrides(overrides)
        end),
    }
)
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
    mods = KALTSHIFT,
    action = act.SplitHorizontal { domain = "CurrentPaneDomain" },
  }
)

-- Split Horizontal
table.insert(config.keys,
  {
    key = "_",
    mods = KALTSHIFT,
    action = act.SplitVertical { domain = "CurrentPaneDomain" },
  }
)

-- Close Current panel
table.insert(config.keys,
  {
    key = "K", 
    mods = KALTSHIFT,
    action = act.CloseCurrentPane { confirm = true }, 
  }
)

-- Toggle current panel zoom
table.insert(config.keys,
  {
    key = 'z',
    mods = KALT,
    action = act.TogglePaneZoomState,
  }  
)

-- ## Jump between panels

-- Jump to panel left
table.insert(config.keys, {
    key = "LeftArrow",
    mods = KALT,
    action = act.ActivatePaneDirection("Left"),
  }
)

-- Jump to panel right
table.insert(config.keys, {
    key = "RightArrow",
    mods = KALT,
    action = act.ActivatePaneDirection("Right"),
  }
)

-- Jumb to panel Up
table.insert(config.keys, {
    key = "UpArrow",
    mods = KALT,
    action = act.ActivatePaneDirection("Up"),
  }
)

-- Jump to panel Down
table.insert(config.keys, {
    key = "DownArrow",
    mods = KALT,
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
if wezterm.target_triple:find("windows") then
  -- config.default_prog = {"C:/Program Files/PowerShell/7/pwsh.exe"}
  config.default_prog = {"nu"}
elseif wezterm.target_triple:find("linux") then
  config.xcursor_theme = "Adwaita" 
  config.xcursor_size = 24

  config.window_frame = {
    border_left_width = "2px",
    border_right_width = "2px",
    border_bottom_height = "2px",
    border_top_height = "2px",
    border_left_color = "#444444",
    border_right_color = "#444444",
    border_top_color = "#444444",
    border_bottom_color = "#444444"
  }
else
  -- config.default_prog = {"/usr/bin/bash"}
  -- config.default_prog = {"/home/linuxbrew/.linuxbrew/bin/nu"}
end

return config
