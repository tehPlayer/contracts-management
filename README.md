# Volders trial app

# Requirements

- Node (6+; I use 10+)
- Ruby
- PostgreSQL
- Yarn - `brew install yarn --without-node`
- Chromedriver - `brew cask install chromedriver` (JS testing)

# Installation

```sh
bundle
rails db:create
rails db:migrate
rails s
```

# Testing

```sh
rspec
```