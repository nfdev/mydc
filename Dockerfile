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
    tmux vim \
  ;


##### Setup as User #####
# Setup User
RUN useradd -m hogemin
RUN chsh -s /bin/bash hogemin
RUN usermod -aG sudo hogemin
RUN echo "hogemin ALL=NOPASSWD: ALL" >> /etc/sudoers


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
