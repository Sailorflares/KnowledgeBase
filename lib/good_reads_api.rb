class GoodReadsApi
  
  def create_query_url
    "https://www.goodreads.com/search/index.xml?key=#{ENV['GOOD_READS_KEY']}&q=#{{search_term}}"
  end
  
end