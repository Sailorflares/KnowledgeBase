require 'pry'
class ScoresController < ApplicationController

  def train_relevant
    Score.train(params[:topic], 'relevant', params[:train])
  end

  def train_irrelevant
    Score.train(params[:topic], 'irrelevant', params[:train])
  end
end
