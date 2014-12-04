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
    tag_index = tag_array.index{ |hash| hash["title"] == search_term.capitalize} #do a regex search 
    if tag_index
      tag_id = tag_array[tag_index]["id"]
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

  def links_array
    array = []
    get_json["list"]["story"].each do |story_hash|
      array << story_hash["link"].first["$text"]
    end
    return array
  end
  
end