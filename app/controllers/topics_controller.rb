class TopicsController < ApplicationController

  def show
    @topic = params[:topic].gsub(" ", "%20")

    nyt_array = NytApi.new(@topic).stories_array.collect do |story|
      hash = {
        "title" => story["headline"]["main"],
        "link" => story["web_url"],
        "img_src" => (story["multimedia"].first.nil? ? "http://www.consciouscoffees.com/joomla1/images/stories/nyt-logo.png" : "http://static01.nyt.com/" + story["multimedia"].first["url"] )
      }
      Score.show?(@topic, hash["title"]) ? hash : nil
    end.compact
    npr_array = NprApi.new(@topic).stories_array.collect do |story|
      hash = {
        "title" => story["title"]["$text"],
        "link" => story["link"].first["$text"],
        "img_src" => (story["image"].nil? ? "http://www.niemanlab.org/images/iheartnpr_web_250x250_stacked.jpg" : story["image"].first["src"] )
      }
      Score.show?(@topic, hash["title"]) ? hash : nil
    end.compact
    amazon_array = AmazonScraper.new(@topic).attributes_array
    coursera_array = CourseraApi.new(@topic).courses_array
    @stories_array = (npr_array + nyt_array + amazon_array + coursera_array)
  end
  
end
