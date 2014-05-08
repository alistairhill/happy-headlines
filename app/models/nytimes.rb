require_relative 'NewsItem'
# require_relative 'filter'

module Nytimes
  class Client
    include HTTParty
    # include Filter
    # base_uri "http://api.nytimes.com/svc/search/v2/articlesearch"

    def get_news
      response = self.class.get( "http://api.nytimes.com/svc/search/v2/articlesearch.json",
        :query => { "api-key" => ENV['KEY'] } 
        )
    end

    # def parse_news#(response)
    #   get_news["response"]["docs"].map { |story| NewsItem.new(story["snippet"], story["headline"]["main"]) }
    # end

    # def filtered_news
    #   parse_news.select { |story| story.good }
    # end

  end
end


# def return_news
#   response = HTTParty.get("http://api.nytimes.com/svc/search/v2/articlesearch.json?api-key=7312fccd241307a3f454e0756281cd3f:6:69373250&fq=news_desk:(Foreign)&begin_date=20140502&end_date=20140502")
# end

