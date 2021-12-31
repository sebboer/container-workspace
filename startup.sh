#!/bin/bash

OS=$(grep '^ID=' /etc/os-release | awk -F= '{print $2}' | tr -d '"')
if [[ $OS == "rhel" ]];then
	echo "distribution is rhel"
	sudo dnf update && \
		sudo dnf install -y zsh jq nnn shellcheck neovim gcc rigprep curl fd-find yamllint || exit 1
		sudo dnf -y upgrade
elif [[ $OS == "ubuntu" ]]; then
	echo "distribution is Ubuntu"
	sudo apt-get update && \
	sudo apt-get -y install zsh jq nnn shellcheck neovim gcc ripgrep curl fd-find yamllint && \
	sudo apt-get -y upgrade
fi

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y && \
"$HOME/.cargo/bin/cargo" install du-dust exa hexyl && \
mkdir -p ~/.local/bin && \
ln -s "$(command -v fdfind)" ~/.local/bin/fd


# VIM PLUG
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
# OH MY ZSH
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

USERNAME="$USER"
echo "USERNAME: $USER $USERNAME"
sudo chsh -s /bin/zsh "$USERNAME"

# FZF
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install --no-bash --no-fish --key-bindings --completion --update-rc

# FZF-TAB
git clone https://github.com/Aloxaf/fzf-tab "$HOME/.oh-my-zsh/plugins/fzf-tab"

# CONFIG: ZSH, NVIM...
curl -fLo "$HOME/.config/zsh/common-aliases.zsh" --create-dirs https://raw.githubusercontent.com/sebboer/container-workspace/master/.config/zsh/common-aliases.zsh
curl -fLo "$HOME/.config/zsh/common-functions.zsh" --create-dirs https://raw.githubusercontent.com/sebboer/container-workspace/master/.config/zsh/common-functions.zsh
curl -fLo "$HOME/.config/zsh/variables.zsh" --create-dirs https://raw.githubusercontent.com/sebboer/container-workspace/master/.config/zsh/variables.zsh

curl -fLo "$HOME/.config/nvim/init.vim" --create-dirs https://raw.githubusercontent.com/sebboer/container-workspace/master/.config/nvim/init.vim

curl -fLo "$HOME/.oh-my-zsh/custom/plugins/vi-mode-custom/vi-mode-custom.plugin.zsh" --create-dirs https://raw.githubusercontent.com/sebboer/container-workspace/master/.oh-my-zsh/custom/plugins/vi-mode-custom/vi-mode-custom.plugin.zsh
curl -fLo "$HOME/.oh-my-zsh/custom/themes/bira-custom-no-git.zsh-theme" --create-dirs https://raw.githubusercontent.com/sebboer/container-workspace/master/.oh-my-zsh/custom/themes/bira-custom-no-git.zsh-theme
curl -fLo "$HOME/.zshrc" --create-dirs https://raw.githubusercontent.com/sebboer/container-workspace/master/.zshrc
curl -fLo "$HOME/.tmux.conf" --create-dirs https://raw.githubusercontent.com/sebboer/container-workspace/master/.tmux.conf

# install podman
. /etc/os-release && \
echo "deb https://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/testing/xUbuntu_${VERSION_ID}/ /" | sudo tee /etc/apt/sources.list.d/devel:kubic:libcontainers:testing.list && \
curl -L "https://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/testing/xUbuntu_${VERSION_ID}/Release.key" | sudo apt-key add - && \
sudo apt-get update -qq && \
sudo apt-get -qq -y install podman containernetworking-plugins

# install docker
if [[ $OS == "rhel" ]];then
	sudo dnf -y install dnf-plugins-core && \
	sudo dnf config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo && \
	sudo dnf install -y docker-ce docker-ce-cli containerd.io
elif [[ $OS == "ubuntu" ]]; then
	sudo apt-get -y install \
			apt-transport-https \
			ca-certificates \
			curl \
			gnupg \
			lsb-release && \
			curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

			if [[ $(uname -m) == "arm64" || $(uname -m) == "aarch64" ]]; then
				echo "deb [arch=arm64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
			else
				echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
			fi
			sudo apt-get update && \
			sudo apt-get -y install docker-ce docker-ce-cli containerd.io
fi

sudo groupadd docker
sudo usermod -aG docker "$USER"

# git aliases
git config --global alias.co checkout
git config --global alias.br branch
git config --global alias.ci commit
git config --global alias.st status

echo "installation done!"
