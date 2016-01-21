require 'open-uri'

class NytService

  attr_reader :json

  def initialize(search_term)
    @url = create_query_url(search_term)
    @json = get_json
  end

  def create_query_url(search_term)
    "http://api.nytimes.com/svc/search/v2/articlesearch.json?q=#{search_term}&api-key=01cfea938257c574337d1f3d4b32d248:14:74070731"
  end

  def get_json
    JSON.load(open(@url))
  end

  def stories_array
    @json["response"]["docs"].collect do |story|
      hash = {
        "title" => story["headline"]["main"],
        "link" => story["web_url"]
      }
      if story["multimedia"].first.nil?
        hash["img_src"] = "http://static01.nyt.com/images/icons/t_logo_291_black.png"
      elsif story["multimedia"].size == 1
        hash["img_src"] = "http://static01.nyt.com/" + story["multimedia"][0]["url"]
      else
        hash["img_src"] = "http://static01.nyt.com/" + story["multimedia"][1]["url"]
      end
      
      hash
    end
  end
end



    