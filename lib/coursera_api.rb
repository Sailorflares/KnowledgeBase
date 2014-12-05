require 'open-uri'

class CourseraApi

  def initialize(search_term)
    @search_term = search_term
  end

  def stories_array(search_term)
    courses = Nokogiri::HTML(open("https://api.coursera.org/api/catalog.v1/categories"))["elements"]
    courses_array = []
    courses.collect do |hash|
      if hash["name"].match( Regexp.new(".*#{search_term}.*", true) )
        attributes_hash = {}
        attributes_hash["title"] = hash["name"]
        attributes_hash["url"] = "https://www.coursera.org/course/#{hash["shortName"]}"
        attributes_hash["img_src"] = "http://everyoneon.org/wp-content/uploads/2014/06/cropped-coursera_logo.png"
        courses_array << attributes_hash
      end
    end
    return courses_array  
  end

end