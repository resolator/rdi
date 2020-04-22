#!/bin/bash
set -e
if [ $(less /etc/passwd | grep $UNAME -c) == 0 ]
then
    groupadd --gid $GID $UNAME
    useradd -m --gid $GID --uid $UID -s /bin/bash $UNAME
    echo $UNAME" ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
fi
cd /home/$UNAME
su $UNAME
