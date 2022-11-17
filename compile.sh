#!/bin/sh
set -e 

apt-get update && \
    apt -y upgrade;
npm i -g typescript
# Step 2 : add user
adduser --disabled-password --gecos '' user && \
echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers && \
echo "user ALL=(root) NOPASSWD:ALL" > /etc/sudoers.d/user && \
chmod 0440 /etc/sudoers.d/user;
chown -R user:user /home/user;
# Step 3: Add permissions
         mkdir -p /.theia && \
         chmod g+rw /home &&  \
         mkdir -p /.npm && \
         chmod g+rw /.npm && chmod g+rw /.theia && \
         chown -R user:user /.npm;
         chgrp -R 0 /home/user && \
         chmod a+x /home/user/entrypoint && \
         chmod -R g=u /home/user && \
         chmod g=u /etc/passwd;
