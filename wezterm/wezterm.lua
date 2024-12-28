local wezterm = require 'wezterm'

local config = {}
config.disable_default_key_bindings = true

config.leader = {key = "w", mods = "ALT"}

if wezterm.target_triple == "x86_64-pc-windows-msvc" then
  -- config.default_prog = {"C:/Program Files/PowerShell/7/pwsh.exe"}
  config.default_prog = {"nu"}
else
  -- config.default_prog = {"/usr/bin/bash"}
  config.default_prog = {"/home/linuxbrew/.linuxbrew/bin/nu"}
end

config.font = wezterm.font("JetBrains Mono") -- Altere para a fonte que você prefere
config.font_size = 12.0 -- Tamanho da fonte
-- config.color_scheme = "Gruvbox Dark (Gogh)" -- Esquema de cores (instale o que quiser)
config.enable_tab_bar = true -- Exibir barra de abas
config.hide_tab_bar_if_only_one_tab = true -- Esconde a barra de abas se só houver uma aba
config.keys = {
  -- Alterar para teclas alternativas, como CTRL + ALT + D
  {
    key = "+",
    mods = "ALT|SHIFT",
    action = wezterm.action.SplitHorizontal { domain = "CurrentPaneDomain" },
  },
  {
    key = "_",
    mods = "ALT|SHIFT",
    action = wezterm.action.SplitVertical { domain = "CurrentPaneDomain" },
  },
  {
    key = "q", -- Tecla para fechar a divisão
    mods = "ALT|SHIFT",
    action = wezterm.action.CloseCurrentPane { confirm = true }, -- Confirmação antes de fechar
  },
  {
    key = 'z',
    mods = 'ALT',
    action = wezterm.action.TogglePaneZoomState,
  },  -- Navegar para a esquerda
  {
    key = "LeftArrow",
    mods = "ALT",
    action = wezterm.action.ActivatePaneDirection("Left"),
  },
  -- Navegar para a direita
  {
    key = "RightArrow",
    mods = "ALT",
    action = wezterm.action.ActivatePaneDirection("Right"),
  },
  -- Navegar para cima
  {
    key = "UpArrow",
    mods = "ALT",
    action = wezterm.action.ActivatePaneDirection("Up"),
  },
  -- Navegar para baixo
  {
    key = "DownArrow",
    mods = "ALT",
    action = wezterm.action.ActivatePaneDirection("Down"),
  },
  -- Ajustar tamnho dos paineis
  {
    key = "UpArrow",
    mods = "LEADER",
    action = wezterm.action.AdjustPaneSize {"Up", 1},
  },
  {
    key = "DownArrow",
    mods = "LEADER",
    action = wezterm.action.AdjustPaneSize {"Down", 1},
  },
  {
    key = "RightArrow",
    mods = "LEADER",
    action = wezterm.action.AdjustPaneSize {"Right", 1},
  },
  {
    key = "LeftArrow",
    mods = "LEADER",
    action = wezterm.action.AdjustPaneSize {"Left", 1},
  },
}
config.window_padding = {
  left = 10,
  right = 10,
  top = 10,
  bottom = 10,
}

return config
