class TopicsController < ApplicationController

  def show
    @topic = params[:topic].gsub(" ", "%20")
  end
  
end
