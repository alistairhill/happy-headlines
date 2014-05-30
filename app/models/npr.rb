
module Npr
  class Client
    include HTTParty

    INTEREST = {
      sports: 1055
    }
    #sports id=1055
    URI = "http://api.npr.org/query?orgId=0&fields=title,storyDate,image,text,textWithHtml&requiredAssets=text,image&dateType=story&sort=dateAsc&output=JSON&numResults=50&"
    # http://api.npr.org/query?id=1026,1090&date=2014-05-29&dateType=story
    def get_news
      response = self.class.get(URI,
        :query => { "apiKey" => ENV['PIN']} #,  date:"2014-05-29"
      )
      JSON.parse(response.body)
    end

    def parse_news
      return get_news["list"]["story"].map {|story| NewsItem.new(story["title"]["$text"], story["storyDate"]["$text"], story["text"]["paragraph"].inject(" "){|memo, num| memo+ " " + num["$text"]}, story["image"][0]["src"])}
      .select {|story|story.ok}# && story.good}
    end

    # def cacheStories(parse_news)
    #   parse_news.map! do |story|
    #     { title: NewsItem.title,
    #       paragraph: NewsItem.paragraph,
    #       image: NewsItem.image,
    #       date: NewsItem.date,
    #       ok_news: NewsItem.ok,
    #       good_news: NewsItem.good
    #     }
    #   stories = parse_news.map {|story| Stories.create(story)}
    # end

    # def get_date(date)
    #   response = self.class.get(URI,
    #     :query => { "apiKey" => ENV['PIN'], date:"2013-05-29"} #, date:"2013-05-29" 
    #   )
    #   @changed_date = JSON.parse(response.body)
    # end

    # def parse_date
    #   return @changed_date["list"]["story"].map {|story| NewsItem.new(story["title"]["$text"], story["storyDate"]["$text"], story["text"]["paragraph"].inject(" "){|memo, num| memo+ " " + num["$text"]}, story["image"][0]["src"])}
    #   # .select {|story|story.ok}# && story.good}
    # end
  end
end