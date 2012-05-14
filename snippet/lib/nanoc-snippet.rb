require 'nokogiri'

module Nanoc::Helpers
  module Snippet
    # Show a snippet of the item.
    #
    # item - the nanoc item
    # options - options to customize the snippet (default: {})
    #           :range - the range of characters for the snippet (default: 0..150)
    #           :ellipsis - the ellipsis (default: '...')
    #           :selector - the xpath selector for the snippet (default: '//p/text()')
    #
    # Returns a snippet of the item
    def snippet(item, options={})
      op = {:range => 0..150,
            :ellipsis => '...',
            :selector => '//p/text()'}.merge(options)
      doc = Nokogiri::HTML(item.compiled_content)
      doc.xpath(op[:selector]).to_a.join(" ").gsub("\r"," ").gsub("\n"," ")[op[:range]] + op[:ellipsis]
    end
  end
end
