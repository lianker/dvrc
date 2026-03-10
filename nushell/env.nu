use std "path add"

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
$env.Path = ($env.Path | prepend $"($env.GOPATH)/bin")


# Elixir
# Elixir LSP (elixir-ls)
$env.DV_ELIXIR_LS_PATH = $"($env.DV_PATH)/lsp/elixir/elixir-ls/rel"

path add $env.DV_ELIXIR_LS_PATH

# Gradle
$env.GRADLE_PATH = $"($env.DV_PATH)/apps/gradle/gradle-9.3.0/bin"
path add $env.GRADLE_PATH

# JAVA
$env.JAVA_HOME = $"($env.DV_PATH)/apps/openjdk/jdk-21.0.2"
path add $"($env.JAVA_HOME)/bin"
