function prompt {
    $p = $executionContext.SessionState.Path.CurrentLocation
    $osc7 = ""
    if ($p.Provider.Name -eq "FileSystem") {
        $ansi_escape = [char]27
        $provider_path = $p.ProviderPath -Replace "\\", "/"
        $osc7 = "$ansi_escape]7;file://${env:COMPUTERNAME}/${provider_path}${ansi_escape}\"
    }
    "${osc7}PS $p$('>' * ($nestedPromptLevel + 1)) ";
}

function y {
    $tmp = [System.IO.Path]::GetTempFileName()
    yazi $args --cwd-file="$tmp"
    $cwd = Get-Content -Path $tmp
    if (-not [String]::IsNullOrEmpty($cwd) -and $cwd -ne $PWD.Path) {
        Set-Location -LiteralPath $cwd
    }
    Remove-Item -Path $tmp
}

$env:DV_PATH = "$HOME\dvlopment"
$env:JAVA_VERSION = "jdk-21.0.2"
$env:JAVA_HOME = "$env:DV_PATH\apps\openjdk\$env:JAVA_VERSION"
$env:KOTLIN_VERSION = "kotlinc-2.3.0"
$env:KOTLIN_HOME = "$env:DV_PATH\apps\kotlin\$env:KOTLIN_VERSION"
$env:DV_GO_VERSION = "go1.23"
$env:DV_GO_PATH = "$env:DV_PATH\apps\golang\$env:DV_GO_VERSION"
$env:GOPATH="$HOME\go"
$env:PATH = "$env:DV_GO_PATH\bin;" + $env:PATH
$env:PATH = "$env:GOPATH\bin;" + $env:PATH
$env:YAZI_FILE_ONE = "C:\Program Files\Git\usr\bin\file.exe"
$env:EDITOR = "helix"
$PSStyle.FileInfo.Directory = ""

Invoke-Expression (&starship init powershell)

