require_relative 'news_item'

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

    # def parse_news
    #   get_news["response"]["docs"].map { |story| NewsItem.new(story["snippet"], story["headline"]["main"]) }
    # end

    # def filtered_news
    #   parse_news.select { |story| story.good }
    # end

  end
end
