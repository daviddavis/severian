# Severian

A simple ruby gem for extracting info from rpms. It essentially calls `rpm` from the
command line to extract the info.

## Requirements

* rpm (tested against 4.10.3.1)

## Installation

Add this line to your application's Gemfile:

    gem 'severian'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install severian

## Usage

There are two ways to instantiate an RPM object. First from a filepath to an
rpm:

```ruby
Severian::RPM.extract("/path/to/my_rpm.rpm")
```

Or you can just pass the information as a hash to #new. God help you if you
choose to do this.

```ruby
Severian::RPM.new(my_hash_of_info)
```


## Development

To test out severian in a console from the gem repo, just run:

```
irb -Ilib -rseverian
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
