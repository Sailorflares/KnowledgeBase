class TopicsController < ApplicationController

  def show
    @topic = params[:topic]
    @NPR_array = NprApi.new(params[:topic])
  end
  
end
