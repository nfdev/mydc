FROM ubuntu
MAINTAINER Admin <nfwork01@gmail.com>

##### Setup as Root #####
# Install base lib
RUN set -eux; \
  apt-get update; \
  apt-get install -y --no-install-recommends \
    git curl gnupg2 ca-certificates apt-transport-https sudo\
  ;

# Setup for Javascript
RUN set -eux; \
  curl -sL https://deb.nodesource.com/setup_10.x | bash -;
RUN set -eux; \
  apt-get update; \
  apt-get install -y --no-install-recommends \
    nodejs \
  ;

RUN set -eux; \
  curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
  echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
  ;
RUN set -eux; \
  apt-get update; \
  apt-get install -y --no-install-recommends \
    yarn \
  ;

# Setup for Python3
RUN set -eux; \
  apt-get update; \
  apt-get install -y --no-install-recommends \
    python3 python3-pip whois \
    gcc libpython3-dev libmysqlclient-dev \
  ;

# Install Terminals
RUN set -eux; \
  apt-get update; \
  apt-get install -y --no-install-recommends \
    iproute2 iputils-ping\
    tmux vim zsh command-not-found\
    man-db openssh-client\
  ;

##### Setup as User #####
# Setup User
RUN useradd -m hogemin
RUN chsh -s /bin/bash hogemin
RUN usermod -aG sudo hogemin
RUN echo "hogemin ALL=NOPASSWD: ALL" >> /etc/sudoers

RUN mkdir /share && chown hogemin:hogemin /share
RUN mkdir /orghome && chown hogemin:hogemin /orghome

# Install Editor
USER hogemin
WORKDIR /home/hogemin

RUN set -eux; \
  pip3 install setuptools\
  ;
RUN set -eux; \
  pip3 install ipython\
  ;
RUN set -eux; \
  pip3 install ipdb\
  ;

# Setup bin
COPY ./dcfile/entrypoint.sh /usr/local/bin/entrypoint.sh
COPY ./dcfile/myapt /usr/local/bin/myapt
COPY ./dcfile/dcupdate /usr/local/bin/dcupdate
COPY ./dcfile/myfile /usr/local/bin/myfile

RUN cp -rf /home/hogemin /orghome

VOLUME /home/hogemin
VOLUME /share

ENTRYPOINT /usr/local/bin/entrypoint.sh
