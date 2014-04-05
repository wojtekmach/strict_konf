# StrictKonf

Extend Konf with required keys

## Rationale

It's very annoying when configuration files get out of sync, i.e.: you have a developer's `config.yml` that is ignored, `config.yml.sample` checked-in and another `config.yml` on the production box. Problems arise when the developer, when adding a new key, forgets to update `.sample` file or the production config and the code & configuration is out of sync.

This gem extends Konf to fail when there is a discrepancy between the required list of keys and the actual configuration file content.

## Example

Based on <https://github.com/GBH/konf#usage>

```yaml
development:
  name: Dev
  email: dev@test.test
```

You can read the file like usual with Konf:

```ruby
config = StrictKonf.new('configuration.yml', 'development', [:name, :email])
config.name # => Dev
```

It will fail when you have too much or too few keys in your configuration:

```ruby
StrictKonf.new('configuration.yml', 'development', [:name])                # raises UnknownKeys error
StrictKonf.new('configuration.yml', 'development', [:name, :email, :role]) # raises NotFound error
```

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'strict_konf', github: 'wojtekmach/strict_konf'
```

And then execute:

    $ bundle
