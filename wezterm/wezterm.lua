local wezterm = require 'wezterm'

local config = {}

config.default_prog = {"nu"}

-- if wezterm.target_triple == "x86_64-pc-windows-msvc" then
--   config.default_prog = {"C:/Program Files/PowerShell/7/pwsh.exe"}
-- else
--   config.default_prog = {"/bin/bash"}
-- end

config.font = wezterm.font("JetBrains Mono") -- Altere para a fonte que você prefere
config.font_size = 12.0 -- Tamanho da fonte
config.color_scheme = "Gruvbox Dark (Gogh)" -- Esquema de cores (instale o que quiser)
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
  -- Navegar para a esquerda
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
  {
    key = 'z',
    mods = 'ALT',
    action = wezterm.action.TogglePaneZoomState,
  },
}
config.window_padding = {
  left = 10,
  right = 10,
  top = 10,
  bottom = 10,
}

return config
