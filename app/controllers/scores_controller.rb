require 'pry'
class ScoresController < ApplicationController

  def train_relevant
    Score.train('topic', 'relevant', 'Definitely relative')
  end
end
