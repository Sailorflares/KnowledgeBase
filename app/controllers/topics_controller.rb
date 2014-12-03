class TopicsController < ApplicationController

  def show
    @topic = params[:topic]
  end
  
end
