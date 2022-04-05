FROM codercom/code-server:4.2.0

USER root

ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y php7.4-cli composer php7.4-xml php7.4-gd php7.4-zip
RUN composer global require friendsofphp/php-cs-fixer sebastian/phpcpd phpmd/phpmd squizlabs/php_codesniffer
RUN echo 'export PATH="$PATH:$HOME/.composer/vendor/bin"' >> /root/.bashrc

RUN code-server --install-extension junstyle.php-cs-fixer
RUN code-server --install-extension eamodio.gitlens
RUN code-server --install-extension neilbrayfield.php-docblocker
RUN code-server --install-extension bmewburn.vscode-intelephense-client
RUN code-server --install-extension nhoizey.gremlins
RUN code-server --install-extension dbaeumer.vscode-eslint
RUN code-server --install-extension octref.vetur 
RUN code-server --install-extension mechatroner.rainbow-csv
RUN code-server --install-extension mblode.twig-language-2

COPY ./settings.json /root/.local/share/code-server/User/settings.json
