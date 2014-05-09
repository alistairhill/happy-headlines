require_relative 'news_item'

module Nytimes
  class Client
    include HTTParty

    URI = "http://api.nytimes.com/svc/search/v2/articlesearch.json"
    # DATE = "20130502"
    def get_news
      response = self.class.get(URI,
        :query => { "api-key" => ENV['KEY'], news_desk:("AP")} 
        )
    end

    def parse_news 
      return get_news["response"]["docs"].map { |story| NewsItem.new(story["snippet"], story["headline"]["main"], story["web_url"])}.select {|story|story.good}
    end

    def get_sports
      response = self.class.get(URI,
        :query => { "api-key" => ENV['KEY'], fq:("Sports")}
      )                                  
    end

    def parse_sports
      return get_sports["response"]["docs"].map { |story| NewsItem.new(story["snippet"], story["headline"]["main"], story["web_url"])}.select {|story|story.good}
    end

    def get_date(date)
      @changed_date = self.class.get(URI,
        :query => { "api-key" => ENV['KEY'], news_desk:("AP"),  end_date:(date)} 
      )
    end

    def parse_date
      return @changed_date["response"]["docs"].map { |story| NewsItem.new(story["snippet"], story["headline"]["main"], story["web_url"])}.select {|story|story.good}
    end


  end
end
