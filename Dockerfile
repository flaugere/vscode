FROM ghcr.io/coder/code-server:4.10.0

USER root

ARG DEBIAN_FRONTEND=noninteractive
RUN curl -fsSL https://deb.nodesource.com/setup_16.x | sudo -E bash -
RUN apt-get update && apt-get install -y \
	php7.4-cli composer php7.4-xml php7.4-gd php7.4-zip \
	nodejs \
	vim \
	ca-certificates \
	curl \
	gnupg 
RUN mkdir -m 0755 -p /etc/apt/keyrings && curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
RUN echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
RUN apt-get update && apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
RUN composer global require friendsofphp/php-cs-fixer sebastian/phpcpd phpmd/phpmd squizlabs/php_codesniffer
RUN echo 'export PATH="$PATH:$HOME/.composer/vendor/bin"' >> /root/.bashrc
COPY *.vsix .

RUN chsh -s $(which zsh) 
RUn sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
RUN npm install -g pnpm
RUN code-server --install-extension junstyle.php-cs-fixer
RUN code-server --install-extension eamodio.gitlens
RUN code-server --install-extension neilbrayfield.php-docblocker
RUN code-server --install-extension bmewburn.vscode-intelephense-client
RUN code-server --install-extension dbaeumer.vscode-eslint
RUN code-server --install-extension octref.vetur 
RUN code-server --install-extension mechatroner.rainbow-csv
RUN code-server --install-extension mblode.twig-language-2
RUN code-server --install-extension GitHub.copilot-1.65.7705.vsix

COPY ./settings.json /root/.local/share/code-server/User/settings.json
