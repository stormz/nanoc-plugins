# Search

Index an item in an indextank compatible API.

It use [nokogiri](http://nokogiri.org/) and indextank.

## Install

    gem install nanoc-search

If you use bundler, add it to your Gemfile:

    gem "nanoc-search", "~> 0.0.1"

## Usage

Add to *lib/default.rb*:

```ruby
require 'nanoc-search'
```

Add to *config.yaml*:

    indextank:
      index: index_name
      api_url: http://:password@api

Add a filter at the compile time to use it:

```ruby
compile '*' do
  filter :search
  filter :erb
  layout 'default'
end
```

## License

(c) 2011 Pascal Widdershoven (https://github.com/PascalW/jekyll_indextank)
(c) 2012 Stormz

This code is free to use under the terms of the MIT license
