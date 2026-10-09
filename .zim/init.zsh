# FILE AUTOMATICALLY GENERATED FROM /home/gabriel/.zimrc
# EDIT THE SOURCE FILE AND THEN RUN zimfw build. DO NOT DIRECTLY EDIT THIS FILE!

if [[ -e ${ZIM_CONFIG_FILE:-${ZDOTDIR:-${HOME}}/.zimrc} ]] zimfw() { source "${HOME}/.zim/zimfw.zsh" "${@}" }
fpath=("${HOME}/.zim/modules/utility/functions" "${HOME}/.zim/modules/git-info/functions" "${HOME}/.zim/modules/prompt-pwd/functions" "${HOME}/.zim/modules/zsh-completions/src" "${HOME}/.zim/modules/completion/functions" ${fpath})
autoload -Uz -- mkcd mkpw coalesce git-action git-info prompt-pwd
source "${HOME}/.zim/modules/environment/init.zsh"
source "${HOME}/.zim/modules/input/init.zsh"
source "${HOME}/.zim/modules/utility/init.zsh"
source "${HOME}/.zim/modules/magicmace/magicmace.zsh-theme"
source "${HOME}/.zim/modules/completion/init.zsh"
source "${HOME}/.zim/modules/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
source "${HOME}/.zim/modules/zsh-history-substring-search/zsh-history-substring-search.zsh"
source "${HOME}/.zim/modules/zsh-autosuggestions/zsh-autosuggestions.zsh"
