# -*- coding: utf-8 -*-
require 'uri'
require 'oembed'

OEmbed::Providers.register(OEmbed::Providers::Youtube)

class EmbedFilter < Nanoc::Filter
  identifier :embed
  type :text

  def initialize(hash={})
    super
    @cache_file = ".oembed_cache"
    @cache = open_cache
  end

  def run(content, params={})
    urls = URI.extract(content, ['http', 'https'])
    content2 = content.dup
    urls.each do |url|
      html = @cache.fetch(url, nil)
      if html.nil?
        html = get_oembed(url)
      end
      if !html.nil?
        content2.gsub!(url, html)
      end
      @cache.store(url, html)
    end
    save_cache @cache
    content2
  end

  def get_oembed(url)
    resource = OEmbed::Providers.get(url)
    resource.html
  rescue OEmbed::NotFound => e
    url
  end

  def open_cache
    if File.exists?(@cache_file)
      File.open(@cache_file) {|f| Marshal.load(f)}
    else
      Hash.new
    end
  end

  def save_cache(cache)
    File.open(@cache_file, 'w') {|f| Marshal.dump(cache, f)}
  end

end
