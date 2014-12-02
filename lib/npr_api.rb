require 'open-uri'

class NprApi

  def self.create_query_url(search_term)
    "http://api.npr.org/query?searchTerm=#{search_term}&apiKey=MDE3NTg1OTAzMDE0MTc0NjU3MDZhZTk4Yw001"
  end

  def self.get_json(search_term)
    JSON.load(open(create_query_url(search_term)))
  end
end