require 'nokogiri'

# Show a snippet of the item
def snippet(item)
  doc = Nokogiri::HTML(item.compiled_content)
  doc.xpath('//p/text()').to_a.join(" ").gsub("\r"," ").gsub("\n"," ")[0..150] + '...'
end
