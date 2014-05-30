
module Npr
  class Client
    include HTTParty

    # URI = "http://api.npr.org/query?orgId=0&fields=title,teaser,storyDate,show,image,text,relatedLink&dateType=story&sort=dateAsc&output=JSON&numResults=50&"
    #sports id=1055
    URI = "http://api.npr.org/query?orgId=0&fields=title,storyDate,image,text,textWithHtml&requiredAssets=text,image&dateType=story&sort=dateAsc&output=JSON&numResults=50&"
    def get_news
      response = self.class.get(URI,
        :query => { "apiKey" => ENV['PIN']} #, date:"2013-05-29" 
      )
      JSON.parse(response.body)
    end

    def parse_news
      return get_news["list"]["story"].map {|story| NewsItem.new(story["title"]["$text"], story["storyDate"]["$text"], story["text"]["paragraph"].inject(" "){|memo, num| memo+ " " + num["$text"]}, story["image"][0]["src"])}
      .select {|story|story.ok}# && story.good}
    end

    # def cacheStories(parse_news)
    #   commentData = parsedCommentsHash[:comments]
    #   commentData.map! do |comment|
    #     {author: comment["data"]["author"],
    #       header: parsedCommentsHash[:header],
    #       points: (comment["data"]["ups"].to_i - comment["data"]["downs"].to_i),
    #       comment_created_at: comment["data"]["created"].to_s,
    #       body: comment["data"]["body"],
    #       thread_url: thread_url}
    #   end
    #   comments = commentData.map { |comment| Comment.create(comment) }
    # end
    
    def get_date(date)
      @changed_date = self.class.get(URI,
        :query => { "api-key" => ENV['KEY'], news_desk:("AP"),  end_date:(date)} 
      )
    end

    def parse_date
      return @changed_date["response"]["docs"].map { |story| NewsItem.new(story["snippet"], story["headline"]["main"], story["web_url"])}.select {|story|story.ok}
    end
  end
end