
module Npr
  class Client
    include HTTParty

    INTEREST = {
      "news" => 1001,
      "sports" => 1055,
      "pop" => 1048,
      "science" => 1007,
      "space" => 1026,
      "technology" => 1019,
      "humor" =>1052,
      "fineart" => 1141,
      "digital" => 1049
    }

    URI = "http://api.npr.org/query?fields=title,storyDate,image,text,textWithHtml&requiredAssets=text,image&dateType=story&sort=dateAsc&output=JSON&numResults=50&"
    def parse_news(category="news")
      response = self.class.get(URI,
        :query => { "apiKey" => ENV['PIN'], id:get_category(category)}
      )
      something_good(JSON.parse(response.body))
    end

    def get_category(category_name)
      INTEREST.fetch(category_name, 2)
    end

    def get_date(date)
      response = self.class.get(URI,
        :query => { "apiKey" => ENV['PIN'], date:(date)}
      )
      something_good(JSON.parse(response.body))
    end
      
    # @changed_date["list"]["story"].map {|story| NewsItem.new(story["title"]["$text"], story["storyDate"]["$text"], story["text"]["paragraph"].inject(" "){|memo, num| memo+ " " + num["$text"]}, story["image"][0]["src"])}

    def something_good(story_collection)
      story_collection["list"]["story"].map do |story|
        combined_paragraphs = story["text"]["paragraph"].inject(" ") do |memo, num| 
          memo<< " #{num["$text"]}"
        end
        NewsItem.new( story["title"]["$text"],
                      story["storyDate"]["$text"], 
                      combined_paragraphs,
                      story["image"][0]["src"])
      end.select {|story|story.ok}# && story.good}
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
  end
end