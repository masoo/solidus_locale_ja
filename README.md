# solidus_locale_ja

It provides the Japanese to Solidus.

## Installation

Add to your Gemfile:

```ruby
gem 'solidus', '~> 1.4.0'
gem 'solidus_auth_devise'
gem 'rails-i18n'
gem 'devise-i18n'
gem 'solidus_locale_ja'
gem 'kaminari-i18n'
```

Run the `bundle` command to install.

After installing gems, you'll have to run the generators to create necessary configuration files and migrations.
and Run migrations to create the new models in the database.

```shell
$ bundle exec rails g spree:install --migrate=false --sample=false --seed=false
$ bundle exec rake railties:install:migrations
$ bundle exec rake db:migrate
```

Change `db/seeds.rb`

```shell
$ vi db/seeds.rb
```

Comment out the contents `#Spree::Core::Engine.load_seed if defined?(Spree::Core)`.

```ruby
# comment out
# Spree::Core::Engine.load_seed if defined?(Spree::Core)
```

build seed data.

```shell
$ bundle exec rake db:seed:solidus_locale_ja
```

## Display japanese and Setting

edit `config/application.rb` and `config/initializers/spree.rb`

```shell
$ vi config/application.rb
```

```ruby
  # add next line.
  config.i18n.default_locale = :ja
```

```shell
$ vi config/initializers/spree.rb
```

```ruby
  Spree.config do |config|
    # comment out
    # config.currency = "USD"
    #
    # add next line
    config.currency = "JPY"
    config.default_country_id = 1
  end

  Spree::Frontend::Config.configure do |config|
    # comment out
    # config.locale = 'en'
    #
    # add next line
    config.locale = 'ja'
  end

  Spree::Backend::Config.configure do |config|
    # comment out
    # config.locale = 'en'
    #
    # add next line
    config.locale = 'ja'
  end
```

## Admin Setting

```
$ bundle exec rake spree_auth:admin:create
```

## Start

```shell
$ bundle exec rails s -b 0.0.0.0
```
