module Nytimes
  class Client
    include HTTParty
    base_uri '...'

    def get_stories(user)
       response = self.class.get("/user/#{user}.json",
        :query => { } #here's where you add in query string paramaters.
        )
       return parseForStories(response.body)
    end

    def parseForStories(responseHash)
      
    end
  end
end