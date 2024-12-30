# General Configurations
$env.EDITOR = "helix"
$env.DV_PATH = $"($nu.home-path)/dvlopment"

# Tools COnfigurations
# -> # YAZI
$env.YAZI_FILE_ONE = "C:/Program Files/Git/usr/bin/file.exe"

# Language Configurations
# -> # Go Lang
$env.DV_GO_VERSION = "go1.23"
$env.DV_GO_PATH = $"($env.DV_PATH)/apps/golang/($env.DV_GO_VERSION)"
$env.GOPATH = $"($nu.home-path)/go"

# -> ## Add GO to Path
$env.Path = ($env.Path | prepend $"($env.DV_GO_PATH)/bin")
$env.Path = ($env.Path | prepend $"($env.DV_GO_PATH)/bin")