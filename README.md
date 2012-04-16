# Collection of nanoc plugins

## Embed

All to embed many type of content directly in your page.

It use [ruby-oembed](https://github.com/judofyr/ruby-oembed). So don't forget to install it.

Add a filter at the compile time to use it:

```ruby
compile '*' do
  filter :embed
  filter :erb
  layout 'default'
end
```

## Snippet

Show a snippet of one item.

It use [nokogiri](http://nokogiri.org/). So don't forget to install it.

```ruby
<%= snippet(item) %>
```

## License

(c) 2012 Stormz

This code is free to use under the terms of the MIT license.
