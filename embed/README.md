# Embed

All to embed many type of content directly in your page.

It use [ruby-oembed](https://github.com/judofyr/ruby-oembed).

## Install

    gem install nanoc-embed

If you use bundler, add it to your Gemfile:

    gem "nanoc-snippet", "~> 0.0.1"

## Usage

Add to *lib/default.rb*:

```ruby
require 'nanoc-embed'
```

Add a filter at the compile time to use it:

```ruby
compile '*' do
  filter :embed
  filter :erb
  layout 'default'
end
```

## Cache

A cache file *.oembed_cache* is created. It helps you to reduce the compile time. You can ignore it.

## License

(c) 2012 Stormz

This code is free to use under the terms of the MIT license
