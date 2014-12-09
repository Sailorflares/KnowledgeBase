require 'open-uri'
require 'pry'

class AmazonScraper

  attr_reader :doc

  def initialize(search_term)
    @url = "http://www.amazon.com/s/ref=nb_sb_noss?url=search-alias%3Dstripbooks&field-keywords=#{search_term}&rh=n%3A283155%2Ck%3A#{search_term}"
    @doc = Nokogiri::HTML(open(@url))
  end

  def attributes_array
    @doc.css('#s-results-list-atf')[0].children.collect do |result|
      unless (result.css('img.s-access-image')).empty?
        hash = {
          "img_src" => result.css('img.s-access-image').attribute("src").value,
          "link" => result.css('a.a-link-normal').attribute("href").value,
          "title" => result.css('a.a-link-normal')[1].attribute("title").value
        }
        Score.show?(@topic, hash["title"]) ? hash : nil
      end
    end.compact
  end

end