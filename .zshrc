# customizations

# DISPLAY variable for X11 session forwarding
export DISPLAY=$(cat /etc/resolv.conf | grep nameserver | awk '{print $2; exit;}'):0.0
[[ -n $SSH_CLIENT ]] && export DISPLAY=$(echo -n $SSH_CLIENT | awk '{print $1; exit;}'):0.0

# start tmux on login
[ -z "$TMUX" ] && { tmux attach || tmux } && exit

echo; fortune | lolcat; echo
