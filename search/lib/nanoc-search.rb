# Derived from https://github.com/PascalW/jekyll_indextank
require 'indextank'
require 'nokogiri'

class SearchFilter < Nanoc::Filter
  identifier :search
  type :text

  def initialize(hash = {})
    super

    raise ArgumentError.new 'Missing indextank:api_url.' unless @config[:indextank][:api_url]
    raise ArgumentError.new 'Missing indextank:index.' unless @config[:indextank][:index]

    @last_indexed_file = '.nanoc_indextank'

    load_last_timestamp

    api = IndexTank::Client.new(@config[:indextank][:api_url])
    @index = api.indexes(@config[:indextank][:index])
  end

  # Index all pages except pages matching any value in config[:indextank][:excludes]
  # The main content from each page is extracted and indexed at indextank.com
  # The doc_id of each indextank document will be the absolute url to the resource without domain name
  def run(content, params={})
    # only process item that are changed since last regeneration
    if (!@last_indexed.nil? && @last_indexed > item.mtime)
      return content
    end

    puts "Indexing page #{@item.identifier}"

    while not @index.running?
      # wait for the indextank index to get ready
      sleep 0.5
    end

    page_text = extract_text(content)

    @index.document(@item.identifier).add({
          :text => page_text,
          :title => @item[:title] || item.identifier
      })
    puts 'Indexed ' << item.identifier

    @last_indexed = Time.now
    write_last_indexed

    content
  end

  def extract_text(content)
    doc = Nokogiri::HTML(content)
    doc.xpath('//*/text()').to_a.join(" ").gsub("\r"," ").gsub("\n"," ")
  end

  def write_last_indexed
    begin
      File.open(@last_indexed_file, 'w') {|f| Marshal.dump(@last_indexed, f)}
    rescue
      puts 'WARNING: cannot write indexed timestamps file.'
    end
  end

  def load_last_timestamp
    begin
      @last_indexed = File.open(@last_indexed_file, "rb") {|f| Marshal.load(f)}
    rescue
      @last_indexed = nil
    end
  end
end
