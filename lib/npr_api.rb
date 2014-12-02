require 'open-uri'

class NprApi

  attr_reader :url, :json

  def initialize(search_term)
    @url = create_query_url(search_term)
    @json = get_json
  end

  def create_query_url(search_term)
    "http://api.npr.org/query?output=JSON&searchTerm=#{search_term}&apiKey=MDE3NTg1OTAzMDE0MTc0NjU3MDZhZTk4Yw001"
  end

  def get_json
    JSON.load(open(url))
  end

  def links_array
    array = []
    get_json["list"]["story"].each do |story_hash|
      array << story_hash["link"].first["$text"]
    end
    return array
  end
  
end