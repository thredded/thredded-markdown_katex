# Thredded Plugin: TeX math in Markdown via KaTex

A Thredded markdown plugin that renders TeX math server-side via [KaTeX].

This is what it looks like:

![screenshot](https://cloud.githubusercontent.com/assets/216339/22184709/a7799d12-e0cf-11e6-89dc-a0bf2206f98e.png)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'thredded-markdown_katex', '~> 0.1.0'
```

And then execute:

```bash
bundle
rails g thredded:markdown_katex:install
```

## Usage

Wrap math in `$$`.

See the [Kramdown Math documentation](https://kramdown.gettalong.org/syntax.html#math-blocks)
for more information.

## Development

After checking out the repo, run `bin/setup` to install dependencies.
Then, run `rake spec` to run the tests.
You can also run `bin/console` for an interactive prompt that will allow you to
experiment.

To install this gem onto your local machine, run `bundle exec rake install`.
To release a new version, update the version number in `version.rb`,
and then run `bundle exec rake release`, which will create a git tag for
the version, push git commits and tags, and push the `.gem` file to
[rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at
https://github.com/glebm/thredded-markdown_katex.

This project is intended to be a safe, welcoming space for collaboration,
and contributors are expected to adhere
to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of
the [MIT License](http://opensource.org/licenses/MIT).


[KaTeX]: https://github.com/Khan/KaTeX
