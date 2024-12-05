local wezterm = require 'wezterm'

return {
  font = wezterm.font("JetBrains Mono"), -- Altere para a fonte que você prefere
  font_size = 12.0, -- Tamanho da fonte
  color_scheme = "AdventureTime", -- Esquema de cores (instale o que quiser)
  default_prog = {"powershell.exe"}, -- Defina seu shell padrão
  enable_tab_bar = true, -- Exibir barra de abas
  hide_tab_bar_if_only_one_tab = true, -- Esconde a barra de abas se só houver uma aba
  keys = {
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
      key = "a",
      mods = "ALT",
      action = wezterm.action.ActivatePaneDirection("Left"),
    },
    -- Navegar para a direita
    {
      key = "d",
      mods = "ALT",
      action = wezterm.action.ActivatePaneDirection("Right"),
    },
    -- Navegar para cima
    {
      key = "w",
      mods = "ALT",
      action = wezterm.action.ActivatePaneDirection("Up"),
    },
    -- Navegar para baixo
    {
      key = "s",
      mods = "ALT",
      action = wezterm.action.ActivatePaneDirection("Down"),
    },
    {
      key = 'z',
      mods = 'ALT',
      action = wezterm.action.TogglePaneZoomState,
    },
  },
  window_padding = {
    left = 10,
    right = 10,
    top = 10,
    bottom = 10,
  },
}
