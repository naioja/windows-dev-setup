# Adrian's dev setup on Windows

I've tried to replicate my mac setup on Windows.

### Highlights

- WSL2 running Ubuntu 18.04
  - az-cli
  - ansible
  - docker
  - git
  - ssh-agent
  - terraform
  - z
  - zsh
    - oh my zsh
    - themes
    - fonts
    - prompt
- Chocolaty
- Windows Terminal
- PowerToys
- Docker Desktop
- VScode 
  - plugins

![](./pic/cover.png)

## Setting up Linux on Windows

1. WSL 2 is only available on Windows 10 builds 18917 or higher. In order to check your current Windows version run the following in PowerShell:
   ```
    PS C:\WINDOWS\system32> systeminfo | Select-String "^OS Name","^OS Version"
    OS Name:                   Microsoft Windows 10 Enterprise
    OS Version:                10.0.19041 N/A Build 19041   
   ```
   You can also join the [Windows Insider Program]((https://insider.windows.com/en-us/)) and select the 'Fast' ring or the 'Slow' ring.

1. Enable the feature by opening an Admin Powershell and typing:
    ```
    dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
    dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart
    ```
    Please restart your machine to finish the installation of both components.

1. My linux distribution of choice is Ubuntu 18.04 and it can installed also using and Admin PowerShell commands:
    ```
    cd ~/Desktop
    curl.exe -L -o ubuntu-1804.appx https://aka.ms/wsl-ubuntu-1804
    Add-AppxPackage .\ubuntu-1804.appx
    ```
    alternatively if you already have Chocolaty installed you can run:
    ```
    choco install wsl-ubuntu-1804
    ```

2. In case you already had a Linux distribution installed you can set it to be backed by WSL 2 using the command:
    ```
    wsl --set-version "Ubuntu-18.04" 2
    ```
    >:warning: Please be aware that this will take some time.

## Installing Chocolatey

1. First, ensure that you are using an administrative PowerShell and check the **ExecutionPolicy** it's not set to restricted.
   - Run `Get-ExecutionPolicy`. If it returns `Restricted` execute:
        ```
        Set-ExecutionPolicy AllSigned
        ```
    - Now run the following command
        ```
        Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
        ```

## Windows Terminal

1. It's time to install the preview version of Windows Terminal:
    ```
    choco install -f microsoft-windows-terminal
    ```
    Accept all script execution and wait for the installer to finish, or use the `update` verb to get the latest version.

2. In this repository I've added my modified config file `profiles.json` that will set a couple of things:
    - default terminal to Ubuntu
    - new columns/rows size
    - theme
    - font and font size
    - a couple of new shortcuts

## PowerToys

1. Simply install with:
    ```
    choco install -f powertoys  
    ```
    I'm mainly using it on my multi display setup to have a better split of the windows. Although it has other [interesting features]((https://github.com/microsoft/PowerToys)).
    ![](./pic/powertoys-fancyzone.png)

## Docker Desktop

1. Again using choco within an admin PowerShell and accept all script execution:
    ```
    choco install -f docker-desktop
    ```
2. To integrate with WSL2 the following two settings are necessary:

    Enable WSL2 and make sure the Docker daemon is not anymore exposed on localhost port 2375.
    ![](./pic/docker-1.png)

    And choose your distro
    ![](./pic/docker-2.png)

3. In my case I had already installed docker-desktop while running WSL1 and then WSL2 integration only started to work after runnin within ubuntu the commands:
    ```
    sudo find /usr -name "*docker*" -type l -exec rm {} +
    sudo find /usr -name "*Docker*" -type l -exec rm {} +
    sudo find /usr -name "*kube*" -type l -exec rm {} +
    ```

    >:warning: Another thing I had to removed from my `.zshrc` was the export of `DOCKER_HOST`
    ```
    export DOCKER_HOST=tcp://localhost:2375
    ```
## Visual Studio Code

1. Installing it is as simple as running:
    ```
    choco install -f vscode
    ```
2. And for extensions management from a PowerShell:
    ```
     code --list-extensions
     code --install-extension ms-vscode-remote.remote-wsl
     code --install-extension ms-vscode.azurecli
     code --install-extension davidanson.vscode-markdownlint
     code --install-extension ms-azuretools.vscode-docker
    ```
