# Snippet

Show a snippet of one item.

It use [nokogiri](http://nokogiri.org/).

## Install

    gem install nanoc-snippet

If you use bundler, add it to your Gemfile:

    gem "nanoc-snippet", "~> 0.0.2"

## Usage

Add to *lib/default.rb*:

```ruby
require 'nanoc-snippet'

include Nanoc::Helpers::Snippet
```

In your layout:

```ruby
<%= snippet(item) %>
```

Some options are available. See the code to see all.

## License

(c) 2012 Stormz

This code is free to use under the terms of the MIT license
