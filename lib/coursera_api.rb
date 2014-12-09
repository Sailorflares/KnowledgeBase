require 'open-uri'

class CourseraApi

  def initialize(search_term)
    @search_term = search_term
  end

  def courses_array
    courses = Nokogiri::HTML(open("https://api.coursera.org/api/catalog.v1/courses"))
    courses_array = JSON.parse(courses.css('body p').first.children.first)["elements"]
    return_array = []
    courses_array.collect do |hash|
      if hash["name"].match( Regexp.new(".*#{@search_term}.*", true) )
        attributes_hash = {}
        attributes_hash["title"] = hash["name"]
        attributes_hash["link"] = "https://www.coursera.org/course/#{hash["shortName"]}"
        attributes_hash["img_src"] = "http://everyoneon.org/wp-content/uploads/2014/06/cropped-coursera_logo.png"
        return_array << attributes_hash
      end
    end
    return return_array  
  end

end