require 'open-uri'
require 'nori'

class NprApi

  attr_reader :url, :xml_doc

  def initialize(search_term)
    @url = create_query_url(search_term)
    @xml_doc = get_xml
  end

  def create_query_url(search_term)
    "http://api.npr.org/query?searchTerm=#{search_term}&apiKey=MDE3NTg1OTAzMDE0MTc0NjU3MDZhZTk4Yw001"
  end

  def get_xml
    Nokogiri::XML(open(url)).to_xml
  end

  def links_array
    parser = Nori.new
    parser.parse(get_xml)
  end
  
end