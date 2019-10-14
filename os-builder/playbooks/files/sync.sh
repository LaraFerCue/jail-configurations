#!/bin/sh -eu

if [ ${#} -eq 2 ] ; then
    REMOTE_USER="${1}"
    MACHINE="${2}"
else
    MACHINE="${1}"
    REMOTE_USER="${USER}"
fi

if ! [ -r "${HOME}/.ssh/id_rsa" ] ; then
    mkdir -p "${HOME}/.ssh"
    ssh-keygen -N "" -b 4096 -t rsa -f "${HOME}/.ssh/id_rsa"
fi

REAL_HOME=$(realpath "${HOME}")
cat "${REAL_HOME}/.ssh/id_rsa.pub" | ssh "${REMOTE_USER}@${MACHINE}" \
    "mkdir -p ~/.ssh ; cat > ~/.ssh/authorized_keys"
rsync -va --exclude .svn --exclude .git --delete \
    "${REAL_HOME}/" "${REMOTE_USER}@${MACHINE}:${REAL_HOME}/"
