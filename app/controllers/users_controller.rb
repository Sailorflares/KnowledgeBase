class UsersController < ApplicationController

  def show
    @npr_array = NprApi.new("excercise").stories_array.collect do |story|
      hash = {
        "title" => story["title"]["$text"],
        "link" => story["link"].first["$text"],
        "img_src" => (story["image"].nil? ? "http://www.niemanlab.org/images/iheartnpr_web_250x250_stacked.jpg" : story["image"].first["src"] )
      }
      Score.show?(@topic, hash["title"]) ? hash : nil
    end.compact
  end
end
