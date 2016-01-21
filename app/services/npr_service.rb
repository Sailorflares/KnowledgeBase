require 'open-uri'
require 'pry'

class NprService

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
      return "http://api.npr.org/query?output=JSON&id=#{tag_id}&apiKey=MDIyMjYyNjM4MDE0NTMzNDc5MjAxN2ViNg000" 
    else
      return "http://api.npr.org/query?output=JSON&searchTerm=#{search_term}&apiKey=MDIyMjYyNjM4MDE0NTMzNDc5MjAxN2ViNg000"
    end
  end

  def get_json
     json = JSON.load(open(url))
  end

  def stories_array
    if(@json["list"])
      npr_array = @json["list"]["story"].collect do |story|
        hash = {
          "title" => story["title"]["$text"],
          "link" => story["link"].first["$text"],
          "img_src" => (story["image"].nil? ? "http://www.niemanlab.org/images/iheartnpr_web_250x250_stacked.jpg" : story["image"].first["crop"].first["src"] )
        }
      end
    else
      npr_array = []  
    end
    return npr_array
  end
  
end