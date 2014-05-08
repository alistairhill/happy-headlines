get '/' do
  client = Nytimes::Client.new
  @stories = client.get_news

  ### you can probably move this to the controller or helper method to clear up some space!
  @stories = @stories["response"]["docs"].map { |story| NewsItem.new(story["snippet"], story["headline"]["main"]) }
  @stories = @stories.select { |story| story.good }
  erb :index
end

# get '/stories' do

# end