set -e SSH_AGENT_PID
if set -q gnupg_SSH_AUTH_SOCK_by
    if test $gnupg_SSH_AUTH_SOCK_by -ne %self
        set -gx SSH_AUTH_SOCK (gpgconf --list-dirs agent-ssh-socket | string trim)
    end
else
    set -gx SSH_AUTH_SOCK (gpgconf --list-dirs agent-ssh-socket | string trim)
end
set -gx GPG_TTY $(tty)
gpg-connect-agent updatestartuptty /bye >/dev/null