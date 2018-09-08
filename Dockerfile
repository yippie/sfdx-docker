# Recommened base image for Unraid
# Use phusion/baseimage as base image. To make your builds reproducible, make
# sure you lock down to a specific version, not to `latest`!
# See https://github.com/phusion/baseimage-docker/blob/master/Changelog.md for
# a list of version numbers.
FROM phusion/baseimage:0.11

## Enable SSH
RUN rm -f /etc/service/sshd/down
# Regenerate SSH host keys. baseimage-docker does not contain any, so you
# have to do that yourself. You may also comment out this instruction; the
# init system will auto-generate one during boot.
RUN /etc/my_init.d/00_regen_ssh_host_keys.sh
#### TEMP Use insecure key for SSH Auth
RUN /usr/sbin/enable_insecure_key

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

# ...put your own build instructions here...
RUN apt-get update && apt-get install -y wget xz-utils
RUN wget https://developer.salesforce.com/media/salesforce-cli/sfdx-linux-amd64.tar.xz
RUN mkdir sfdx
RUN tar xJf sfdx-linux-amd64.tar.xz -C sfdx --strip-components 1
RUN ./sfdx/install
RUN rm -rf sfdx

# Expose port 22 for SSH and expose config folder
EXPOSE 22
VOLUME /config

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*