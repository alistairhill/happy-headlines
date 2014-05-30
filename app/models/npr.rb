
module Npr
  class Client
    include HTTParty

    INTEREST = {
      sports: 1055
    }
    #sports id=1055
    URI = "http://api.npr.org/query?fields=title,storyDate,image,text,textWithHtml&requiredAssets=text,image&dateType=story&sort=dateAsc&output=JSON&numResults=50&"
    # URI = "http://api.npr.org/query?id=1026,1090&date=2014-05-29&dateType=story&output=JSON&numResults=50&"
    def get_news
      response = self.class.get(URI,
        :query => { "apiKey" => ENV['PIN']} # 
      )
      JSON.parse(response.body)
    end

    def parse_news#(get_news)
      return get_news["list"]["story"].map do |story|

        combined_paragraphs = story["text"]["paragraph"].inject(" ") do |memo, num| 
          memo<< " #{num["$text"]}"
        end
        NewsItem.new( story["title"]["$text"],
                      story["storyDate"]["$text"], 
                      combined_paragraphs, 
                      story["image"][0]["src"])
      end#.select {|story|story.ok}# && story.good}
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

    def get_date(date)
      response = self.class.get(URI,
        :query => { "apiKey" => ENV['PIN'], date:(date)} #, date:"2013-05-29" 
      )
      something_good(JSON.parse(response.body))
    end

    def something_good(story_collection)
      story_collection["list"]["story"].map do |story|
        combined_paragraphs = story["text"]["paragraph"].inject(" ") do |memo, num| 
          memo<< " #{num["$text"]}"
        end
        NewsItem.new( story["title"]["$text"],
                      story["storyDate"]["$text"], 
                      combined_paragraphs,
                      story["image"][0]["src"])
      end
    end
  end
end