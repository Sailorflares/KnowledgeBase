class UsersController < ApplicationController

  def show
    @amazon = AmazonScraper.new("evolution")
  end
end
