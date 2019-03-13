#!/bin/bash
#~/.bashrc
export BASHRC_PATH_WORK="${HOME}/.bashrc_work"

init_bashrc() {
  BASHRC_URL="https://gist.githubusercontent.com/n8io/543209c3e6b77fb700a8dc7bf7c1482b/raw?&cache-buster=$(date +%s)"
  BASHRC_PATH="${HOME}/.bashrc"

  update() {
    echo "Updating session defaults..." && \
    BASHRC_PATH_WORK_TMP="$(mktemp /tmp/.bashrc_work.XXXXXX)"; \
    curl -m 1 -sL "${BASHRC_URL}" > "${BASHRC_PATH_WORK_TMP}" && \
    cp -fr "${BASHRC_PATH_WORK_TMP}" "${BASHRC_PATH_WORK}" && \
    chmod +x "${BASHRC_PATH_WORK}" && \
    rm -f "${BASHRC_PATH_WORK_TMP}"
  }

  ([ ! -f "${BASHRC_PATH_WORK}" ] || [ ! -z $(find ${BASHRC_PATH_WORK} -mtime +30d) ]) && update
}

init_bashrc

source "$BASHRC_PATH_WORK" >/dev/null

# Alias overrides
alias gkd="git checkout development"

# Add Visual Studio Code (code)
export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
