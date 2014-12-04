require 'open-uri'
require 'nori'

class GoodReadsApi
  
  attr_reader :hash
  
  def initialize(search_term)
    @url = create_query_url(search_term)
    @hash = get_hash
  end

  def create_query_url(search_term)
    "https://www.goodreads.com/search/index.xml?key=#{ENV['GOOD_READS_KEY']}&q=#{search_term}"
  end

  def get_hash
    Nori.new.parse(Nokogiri::XML(open(@url)).to_xml)
  end

  def stories_array
    get_hash["GoodreadsResponse"]["search"]["results"]["work"]
  end
end