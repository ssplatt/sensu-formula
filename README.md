# sensu-formula
[![Build Status](https://travis-ci.org/ssplatt/sensu-formula.svg?branch=master)](https://travis-ci.org/ssplatt/sensu-formula)

"Monitoring that doesn't suck." https://sensuapp.org/

Getting Started Guide: https://sensuapp.org/docs/0.26/guides/getting-started/overview.html
Install Documentation: https://sensuapp.org/docs/latest/platforms/sensu-on-ubuntu-debian.html

Dependencies: Redis, Rabbitmq.

Optional: [Uchiwa Dashboard](https://uchiwa.io/#/).
Uchiwa configuration documentation: https://docs.uchiwa.io/getting-started/configuration/

## Basic Usage
Install and setup brew:
```
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```

```
brew install cask
brew cask install vagrant
```

```
cd <formula dir>
bundle install
```
or
```
sudo gem install test-kitchen
sudo gem install kitchen-vagrant
sudo gem install kitchen-salt
```

Run a converge on the default configuration:
```
kitchen converge default
```
