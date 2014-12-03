class ArticlesController < ApplicationController
	def show
	end

	def wiki_scrape
		topic = params["topic"].gsub(" ","_").downcase
		scraper = Scraper.new(topic)
		wiki_results = scraper.parse_to_json
		render :json => {data: wiki_results}
		# render :json => wiki_results
	end

	def d3
		render :partial => "articles/show.json"
	end

end
