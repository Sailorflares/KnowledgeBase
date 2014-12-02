require 'open-uri'
require 'nori'

class Scraper

	attr_reader :doc
	
	def initialize(topic)
		url = "http://en.wikipedia.org/wiki/#{topic}"
		@doc = Nokogiri::HTML(open(url))
	end


	def parse_to_html
		results = Hash.new
		@doc.css('div.toc ul li').each do |li|
			number = li.css(".tocnumber").first.text.to_f
			text = li.css(".toctext").first.text	
			results[text]=number
		end
		results.to_s
	end
end

