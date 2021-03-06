FROM ubuntu:latest

RUN apt-get update && apt-get install -y \
    apt-transport-https \
    curl

RUN apt-get update -y && \
    apt-get install -y software-properties-common && \
    apt-add-repository -y ppa:brightbox/ruby-ng && \
    curl -sL https://deb.nodesource.com/setup_14.x | sh - && \
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \	
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
    
RUN apt-get update -y && \
    DEBIAN_FRONTEND=noninteractive apt-get install -yq \
    build-essential \
    ruby2.7 ruby2.7-dev \
    libpq-dev \
    zlib1g-dev \
    unattended-upgrades \
    git \
    update-notifier-common \
    tzdata \
    nodejs \
    yarn
 
RUN gem install bundler

RUN mkdir -p /src/gospeltoolbox/account

WORKDIR /src/gospeltoolbox/account

ADD Gemfile      .
ADD Gemfile.lock .

ADD . .

RUN bundle && yarn

ENV PORT 80
EXPOSE 80

ENTRYPOINT ["./docker/entrypoint.sh"]
CMD ["start"]
