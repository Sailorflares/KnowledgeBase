class ArticlesController < ApplicationController
	def show
	end

	def wiki_scrape
		topic = params["topic"].gsub(" ","_").downcase
		scraper = Scraper.new(topic)
		wiki_results = scraper.parse_to_html
		render :json => {data: wiki_results}
	end


end
