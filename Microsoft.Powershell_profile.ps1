function cd.. { cd .. }

# Enable command line prompt for git branch and status
Import-Module posh-git

# Enable git aliases if so inclined
Import-Module git-aliases -DisableNameChecking
# https://github.com/gluons/powershell-git-aliases/blob/master/src/aliases.ps1

# e.g.
# gco "foo-feature"
# gcb "bar-new-feature"
# ga .
# gcmsg "this is my commit message"
# gp
# gl

# Tab auto-completion for kubectl command
Import-Module PSKubectlCompletion
Register-KubectlCompletion

# kubectl aliases for some of the most-used commands?
New-Alias -Name "kc" -Value "kubectl"

function kcg { kubectl get }
function kcgd { kubectl get deployments }
function kcgs { kubectl get services }
function kcgp { kubectl get pods }

function kcgd* { kubectl get deployments --all-namespaces }
function kcgs* { kubectl get services --all-namespaces }
function kcgp* { kubectl get pods --all-namespaces}

function kcl { kubectl logs}

# terraform aliases for the main command loop
New-Alias -Name "tf" -Value "terraform"

function tfi { terraform init }
function tfp { terraform plan }
function tfa { terraform apply --auto-approve }

# Powershell, give me grep!
function grep {
    $input | out-string -stream | select-string $args
}
# Powershell, give me export!
function export {
    $pos = $args[0].IndexOf("=")
    $leftPart  = $args[0].Substring(0, $pos)
    $rightPart = $args[0].Substring($pos+1)
    [System.Environment]::SetEnvironmentVariable($leftPart, $rightPart, [System.EnvironmentVariableTarget]::User)
}

# Powershell, give me touch!
function touch {
    New-Item -ItemType File -Name ($args[0])
}

function focus {
    start 'https://open.spotify.com/user/spotify/playlist/37i9dQZF1DWX9ZIH7jslKG?si=I4EcN0cnQFy0tdyk_meqqA'
}

function relax {
    start 'https://open.spotify.com/user/calmingmusicacademy/playlist/5ePKan7UdZQYLda19zLx2L?si=gUyqCHaPScqtm8uE9CkY7A'
}

Set-Location ~/Workspace
Clear-Host