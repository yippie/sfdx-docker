#!/bin/bash
ENV USER ubuntu
RUN apt-get update && apt-get install -y openssh-server
RUN mkdir /var/run/sshd
RUN adduser --gecos "" $USER
RUN adduser $USER sudo
RUN chown $USER /home/$USER/.ssh/authorized_keys

## Enable SSH
RUN rm -f /etc/service/sshd/down
# Regenerate SSH host keys. baseimage-docker does not contain any, so you
# have to do that yourself. You may also comment out this instruction; the
# init system will auto-generate one during boot.
RUN /etc/my_init.d/00_regen_ssh_host_keys.sh
#### TEMP Use insecure key for SSH Auth
RUN /usr/sbin/enable_insecure_key

apt-get clean 
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*