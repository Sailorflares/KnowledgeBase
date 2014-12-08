require 'pry'
class ScoresController < ApplicationController

  def train_relevant
    binding.pry
    Score.train('topic', 'relevant', 'Definitely relative')
  end
end
