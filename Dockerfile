FROM ghcr.io/coder/code-server:4.95.1

USER root

ARG DEBIAN_FRONTEND=noninteractive
RUN curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
RUN apt-get update && apt-get install -y \
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
RUN echo 'export PATH="$PATH:$HOME/.composer/vendor/bin"' >> /root/.bashrc
COPY *.vsix .

RUN chsh -s $(which zsh) 
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
RUN npm install -g pnpm
RUN code-server --install-extension junstyle.php-cs-fixer
RUN code-server --install-extension eamodio.gitlens
RUN code-server --install-extension neilbrayfield.php-docblocker
RUN code-server --install-extension bmewburn.vscode-intelephense-client
RUN code-server --install-extension dbaeumer.vscode-eslint
RUN code-server --install-extension octref.vetur 
RUN code-server --install-extension mechatroner.rainbow-csv
RUN code-server --install-extension mblode.twig-language-2
RUN code-server --install-extension Continue.continue 

COPY ./settings.json /root/.local/share/code-server/User/settings.json
