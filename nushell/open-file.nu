def main [file] {
    let helix_pane = (wezterm cli list --format json | from json | where title =~ "helix" | get pane_id | first 1)
    if ($helix_pane | is-not-empty) {
        print $"My File: ($helix_pane)"
        # Envia ESC (representado por \e) para garantir que o Helix esteja no modo normal
        wezterm cli send-text --no-paste --pane-id ...$helix_pane "\e"

        # Envia o comando `:open <arquivo>` ao Helix
        wezterm cli send-text --no-paste --pane-id ...$helix_pane $":open ($file)\r"
    } else {
        # Abre um novo painel com o Helix e o arquivo
        wezterm cli split-pane --bottom --cwd . -- helix $file
    }
    
}
