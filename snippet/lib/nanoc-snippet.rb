require 'nokogiri'

module Nanoc::Helpers
  module Snippet
    # Show a snippet of the item
    # It take the first paragraph of the item and return the first 150 words.
    #
    # item - the nanoc item
    #
    # Returns a snippet of the item
    def snippet(item)
      doc = Nokogiri::HTML(item.compiled_content)
      doc.xpath('//p/text()').to_a.join(" ").gsub("\r"," ").gsub("\n"," ")[0..150] + '...'
    end
  end
end
