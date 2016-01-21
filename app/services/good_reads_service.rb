require 'open-uri'
require 'nori'

class GoodReadsService
  
  attr_reader :hash
  
  def initialize(search_term)
    @url = create_query_url(search_term)
    @hash = get_hash
  end

  def create_query_url(search_term)
    "https://www.goodreads.com/search/index.xml?key=t1x5VwC1g3sBqSgPd6rw&q=#{search_term}"
  end

  def get_hash
    Nori.new.parse(Nokogiri::XML(open(@url)).to_xml)
  end

  def books_array
    get_hash["GoodreadsResponse"]["search"]["results"]["work"].collect do |book|
      hash = {
          "title" => book["best_book"]["title"],
          "link" => "http://www.goodreads.com",
          "img_src" => book["best_book"]["image_url"]
      }
    end
  end
end