require 'open-uri'
require 'pry'

class NprApi

  attr_reader :url, :json

  def initialize(search_term)
    @url = create_query_url(search_term)
    @json = get_json
  end

  def create_query_url(search_term)
    tag_array = Nori.new.parse(Nokogiri::XML(open("http://api.npr.org/list?id=3024")).to_xml)["list"]["item"]
    tag_index = tag_array.index{ |hash| hash["title"].match( Regexp.new(".*#{search_term}.*", true) ) } 
    if tag_index
      tag_id = tag_array[tag_index]["@id"].to_i
      return "http://api.npr.org/query?output=JSON&id=#{tag_id}&apiKey=#{ENV['NPR_KEY']}" 
    else
      return "http://api.npr.org/query?output=JSON&searchTerm=#{search_term}&apiKey=#{ENV['NPR_KEY']}"
    end
  end

  def get_json
    JSON.load(open(url))
  end

  def stories_array
    get_json["list"]["story"]
  end
  
end