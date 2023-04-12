# Matthew's Ubuntu VM Setup Instructions and Script

## **Steps:**

### Install an Ubuntu VM:

- [Use Multipass](https://multipass.run/docs/installing-on-linux)
- Install on host: `snap install multipass`
- Create VM: `multipass launch [OS] --name [name] [OTHER ARGS]`
  - ie: `multipass launch bionic --name ubuntu-vm --cpus 2 --mem 4G --disk 20G`
- Mount local directory: `multipass mount ~/Documents/Projects ubuntu-vm:/home/ubuntu/Projects`

### Update and Upgrade:

```
sudo apt update -y
sudo apt upgrade -y
sudo reboot
```

### Run Setup Script:

Copy the script to the VM and run it by using a mount.
Runs and installs the following:

- `snap`, `homebrew`, `gcc`, `build-essential`
- `inconsolata font`, `starship prompt`
- `python3` and sets python=python3 alias
- `git`
- `vscode`
- `docker` (CE - server version) and docker compose plugin
- `nvm`, `nodejs` (Versions 14 and 18)

```
./setup.sh
```

### Setup VSCode Tunneling:

[Link to VSCode Docs](https://code.visualstudio.com/docs/remote/tunnels)

- Run the following and follow its prompts to login

```
code tunnel --accept-server-license-terms
```
