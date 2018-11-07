# Contracts management

Simple app using Ruby on Rails and React to manage contracts.

# Features

- Sign up
- Sign in
- Sign out
- Create contracts
- Edit contracts
- List contracts

# [Demo](https://marcin-contract-management.herokuapp.com/)

# Requirements

- Node (6+; I use 10+)
- Ruby (2.5.1)
- PostgreSQL
- Yarn - `brew install yarn --without-node`
- Chromedriver - `brew cask install chromedriver` (JS testing)

# Installation

```sh
bundle
yarn
rails db:create
rails db:migrate
rails s
```

# Testing

```sh
rspec
```

# Linter

```sh
rubocop
```