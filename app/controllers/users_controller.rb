class UsersController < ApplicationController

  def show
    @coursera_array = CourseraApi.new("law").courses_array
  end
end
