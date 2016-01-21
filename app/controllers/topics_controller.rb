class TopicsController < ApplicationController

  def show
    @topic = params[:topic].gsub(" ", "%20")

    #still unable to determine why the services do not respond correctly when not instantiated in the TopicsController class. 
    #Future fix - move topicStoriesHelper into a StoriesService
    return topicStoriesHelper
  end

  def topicStoriesHelper
    nyt_array = NytService.new(@topic).stories_array
    npr_array = NprService.new(@topic).stories_array
    amazon_array = AmazonService.new(@topic).attributes_array
    coursera_array = CourseraService.new(@topic).courses_array
    goodreads_array = GoodReadsService.new(@topic).books_array

    stories_array = (npr_array + amazon_array + coursera_array + nyt_array + goodreads_array)

    @stories_array = stories_array.sort do |x,y|
      Score.classifications(@topic,y['title'])['relevant'] <=> Score.classifications(@topic,x['title'])['relevant']
    end
  end
  
end
