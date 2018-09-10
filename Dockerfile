# Recommened base image for Unraid
# Use phusion/baseimage as base image. To make your builds reproducible, make
# sure you lock down to a specific version, not to `latest`!
# See https://github.com/phusion/baseimage-docker/blob/master/Changelog.md for
# a list of version numbers.
FROM phusion/baseimage:0.11

ENV USERNAME=sfdxuser
ENV PASSWORD=sfdxuser

ADD setupSSH.sh installSFDX.sh /usr/local/bin/
#RUN setupSSH.sh ${USERNAME} ${PASSWORD}
RUN ["chmod", "+x","/usr/local/bin/installSFDX.sh"]

# Expose port 22 for SSH and expose config folder
EXPOSE 22
VOLUME /data

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]