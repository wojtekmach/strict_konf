# StrictKonf

Extend Konf with required keys

## Rationale

It's very annoying when configuration files get out of sync, i.e.: you have a developer's `config.yml` that is ignored, `config.yml.sample` checked-in and another `config.yml` on the production box. Problems arise when the developer, when adding a new key, forgets to update `.sample` file or the production config and the code & configuration is out of sync.

This gem extends Konf to fail when there is a discrepancy between the required list of keys and the actual configuration file content.

## Example

Based on <https://github.com/GBH/konf#usage>

```yaml
development:
  admin:
    name: Dev
    email: dev@test.test
```

You can read the file like usual with Konf:

```ruby
config = StrictKonf.new('configuration.yml', nil, [:name, :email])
config.development.admin.name # => Dev
```

It will fail when you have too much or too few keys in your configuration:

```
StrictKonf.new('configuration.yml', nil, [:name])                # raises NotFound error
StrictKonf.new('configuration.yml', nil, [:name, :email, :role]) # raises UnknownKeys error
```

## Installation

Add this line to your application's Gemfile:

    gem 'strict_konf', github: 'wojtekmach/strict_konf'

And then execute:

    $ bundle

## Usage

TODO: Write usage instructions here

## Contributing

1. Fork it ( http://github.com/<my-github-username>/strict_konf/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
