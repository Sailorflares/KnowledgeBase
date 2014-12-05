class TopicsController < ApplicationController

  def show
    @topic = params[:topic].gsub(" ", "%20")

    nyt_array = NytApi.new(@topic).stories_array.collect do |story|
      {
        "title" => story["headline"]["main"],
        "link" => story["web_url"],
        "img_src" => (story["multimedia"].first.nil? ? "http://www.consciouscoffees.com/joomla1/images/stories/nyt-logo.png" : "http://static01.nyt.com/" + story["multimedia"].first["url"] )
      }
    end
    npr_array = NprApi.new(@topic).stories_array.collect do |story|
      {
        "title" => story["title"]["$text"],
        "link" => story["link"].first["$text"],
        "img_src" => (story["image"].nil? ? "http://www.niemanlab.org/images/iheartnpr_web_250x250_stacked.jpg" : story["image"].first["src"] )
      }
    end
    amazon_array = AmazonScraper.new(@topic).attributes_hash
    @stories_array = (npr_array + nyt_array + amazon_array).shuffle
  end
  
end
