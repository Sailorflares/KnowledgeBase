require 'open-uri'
require 'nori'

class Scraper

	attr_reader :doc
	
	def initialize(topic)
		@topic = topic
		url = "http://en.wikipedia.org/wiki/#{topic}"
		@doc = Nokogiri::HTML(open(url))
	end


	def parse_to_html
		results = Hash.new
	end

	def parse_to_json
		results = {}
		results["name"] = @topic
		results["children"] = []

		current_top_level = nil
		@doc.css('div.toc ul li').each do |li|
			number = li.css(".tocnumber").first.text.to_f
			text = li.css(".toctext").first.text	
			#results[text]=number

			if number % 1 == 0
				current_top_level = text
				results["children"] << {"name" => text}
			end

			# if number % 1 != 0
			# 	results["children"].collect do |key, value|
			# 		if value == current_top_level
						
			# 	end
			# end

		end
		


		results.to_json
	end
end

