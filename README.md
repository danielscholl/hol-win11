# Windows 11 Developer Machine

A Windows 11 Developer Machine to use for Software Development fully configured in under 1 hour.

1. Git
1. Visual Studio Code
1. Docker
1. Windows Subsystem Linux
1. Windows Terminal _(Ready to Install)_
1. Ubuntu _(Ready to Install)_

__Create the Workstation:__ _(30 Minutes)_


<a href="https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fdanielscholl%2Fhol-win11%2Fmaster%2Fazuredeploy.json" target="_blank">
    <img src="http://azuredeploy.net/deploybutton.png"/>
</a>


Open an RDP Session to the Virtual Machine to perform the remaining setup and configuration.

__Configure the Workstation:__ _(30 Minutes)_

- Start Docker-Desktop

   - If the default user was changed add the user to the group

        `Add-LocalGroupMember -Group "docker-users" -Member $env:UserName`

   - In Docker Settings enable the following settings.

        1. Start Docker Desktop when you login

- Set Cascadia Font as the VSCode default.

  ```bash
    # VSCode settings.json
    {
      "editor.fontFamily": "'Cascadia Code', Consolas, 'Courier New', monospace",
      "editor.fontLigatures": true,
    }
  ```

- Configure Windows Terminal

    - Start Windows Terminal and Edit Settings to add the follogin

      ```json
        {
          "profiles": {
            "list": [
              {
                "colorScheme": "PowerShellTom",
                "commandline": "pwsh -nologo",
                "font": 
                {
                    "face": "CaskaydiaCove NF"
                },
                "guid": "{574e775e-4f2a-5b96-ac1e-a2962a402336}",
                "hidden": false,
                "name": "PowerShell",
                "source": "Windows.Terminal.PowershellCore",
                "startingDirectory": "C:\\Users\\azureuser\\source"
              }
            ]
          },
          "schemes": [
            {
                "background": "#012456",
                "black": "#000000",
                "blue": "#0000FF",
                "brightBlack": "#AAAAAA",
                "brightBlue": "#44B4CC",
                "brightCyan": "#19D1D8",
                "brightGreen": "#81EC0D",
                "brightPurple": "#FF00FF",
                "brightRed": "#FF0000",
                "brightWhite": "#E5E5E5",
                "brightYellow": "#FFD93D",
                "cursorColor": "#FFFFFF",
                "cyan": "#19D1D8",
                "foreground": "#FFFFFF",
                "green": "#00FF00",
                "name": "PowerShellTom",
                "purple": "#9933CC",
                "red": "#FF6600",
                "selectionBackground": "#FFFFFF",
                "white": "#F5F5F5",
                "yellow": "#FFD93D"
            }
          ]
        }
      ```

    - Configure Powershell Prompt to use Posh Git with a paradox theme.

        ```powershell
        Install-Module posh-git -Scope CurrentUser -Force
        Install-Module oh-my-posh -Scope CurrentUser -Force
        Install-Module Terminal-Icons -Scope CurrentUser -Force

        # Set Execution Policy to allow Profile
        Set-ExecutionPolicy -ExecutionPolicy Unrestricted

        notepad $PROFILE

        # Add the following to the profile
        Import-Module -Name Terminal-Icons
        Import-Module posh-git
        Import-Module oh-my-posh
        Set-PoshPrompt -Theme Agnoster
        ```


- Install and configure WSL

  - Using the Shortcut on the Desktop Install Ubuntu

  - Configure Windows Terminal for Ubuntu

    ```json
      {
        "profiles": {
          "list": [
            {
              "guid": "{c6eaf9f4-32a7-5fdc-b5cf-066e8a4b1e40}",
              "hidden": false,
              "name": "Ubuntu-18.04",
              "source": "Windows.Terminal.Wsl",
              "colorScheme": "UbuntuLegit",
              "fontFace": "Cascadia Code PL",
              "startingDirectory" : "//wsl$/Ubuntu-18.04/home/azureuser"
            }
          ]
        },
        "schemes": [
          {
            "name" : "UbuntuLegit",
            "background" : "#2C001E",
            "black" : "#4E9A06",
            "blue" : "#3465A4",
            "brightBlack" : "#555753",
            "brightBlue" : "#729FCF",
            "brightCyan" : "#34E2E2",
            "brightGreen" : "#8AE234",
            "brightPurple" : "#AD7FA8",
            "brightRed" : "#EF2929",
            "brightWhite" : "#EEEEEE",
            "brightYellow" : "#FCE94F",
            "cyan" : "#06989A",
            "foreground" : "#EEEEEE",
            "green" : "#300A24",
            "purple" : "#75507B",
            "red" : "#CC0000",
            "white" : "#D3D7CF",
            "yellow" : "#C4A000"
          }
        ]
      }
    ```

  - Configure Ubuntu with default tools.

    ```bash
    sudo apt update
    sudo apt install curl
    curl https://raw.githubusercontent.com/danielscholl/hol-win10/master/setup.sh | sudo bash
    ```

  - Install terraform using tfenv

    ```bash
    git clone https://github.com/tfutils/tfenv.git ~/.tfenv
    ln -s ~/.tfenv/bin/* ~/.local/bin

    tfenv install 0.12.24
    tfenv use 0.12.24
    ```

  - Install golang using g
    > Do not install the latest version of golang

    ```bash
    curl -sSL https://git.io/g-install | sh -s

    g install 1.12.5
    ```

  - Setup a Powerline go Prompt

    ```bash
    go get -u github.com/justjanne/powerline-go

    # Add the following to .bashrc to modify prompt
    function _update_ps1() {
        PS1="$($GOPATH/bin/powerline-go -error $?)"
    }
    if [ "$TERM" != "linux" ] && [ -f "$GOPATH/bin/powerline-go" ]; then
        PROMPT_COMMAND="_update_ps1; $PROMPT_COMMAND"
    fi
    ```
