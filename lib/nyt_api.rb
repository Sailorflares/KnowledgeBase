require 'open-uri'

class NytApi

  attr_reader :json

  def initialize(search_term)
    @url = create_query_url(search_term)
    @json = get_json
  end

  def create_query_url(search_term)
    "http://api.nytimes.com/svc/search/v2/articlesearch.json?q=#{search_term}&api-key=1a7b0ee104b10dc6baaa5e59392a0b17:8:70267967"
  end

  def get_json
    JSON.load(open(@url))
  end

  def stories_array
    @json["response"]["docs"]
  end
end