# powershell-profile

A devops-focussed Powershell profile. You will get powershell git to see your branch and git status in the prompt, and a whole bunch of aliases and little shortcuts. It's a work in progress. Any pull requests are appreciated.

## How to get started

1. Run the following commands from an *administrative* Powershell session to install the three Powershell modules used by the profile. You might need to use `--clobber`.

```powershell
Install-Module posh-git
Install-Module git-aliases
Install-Module PSKubectlCompletion
```

2. Copy the `Microsoft.Powershell_profile.ps1` file into the directory indicated when you run the `$profile` command.
3. Restart your *normal* Powershell session to get your goodies.