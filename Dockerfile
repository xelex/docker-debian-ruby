FROM debian:stable
MAINTAINER Alexey Tyazhelov
ENV NOTVISIBLE "in users profile"

RUN apt-get update

# Installing SSH
RUN apt-get install -y --force-yes apt-utils
RUN apt-get install -y --force-yes openssh-server
RUN mkdir /var/run/sshd
ADD keys/ssh.pub /tmp/ssh.pub
RUN cat /tmp/ssh.pub >> /root/.ssh/authorized_keys && rm -f /tmp/ssh.pub
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd
RUN echo "export VISIBLE=now" >> /etc/profile
EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]

# Insalling Ruby server
RUN apt-get install -y --force-yes build-essential curl git openssl
RUN apt-get install -y --force-yes libreadline6 libreadline6-dev curl zlib1g zlib1g-dev libssl-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt-dev autoconf libc6-dev ncurses-dev automake libtool bison
RUN gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
RUN \curl -sSL https://get.rvm.io | bash -s stable
RUN /bin/bash -l -c "rvm requirements"
RUN /bin/bash -l -c "rvm install ruby"
RUN /bin/bash -l -c "gem install bundler --no-ri --no-rdoc"

RUN apt-get clean
