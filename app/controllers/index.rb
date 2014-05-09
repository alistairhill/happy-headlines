get '/' do
  client = Nytimes::Client.new
  @stories = client.get_news
  @stories = @stories["response"]["docs"].map { |story| NewsItem.new(story["snippet"], story["headline"]["main"], story["web_url"]) }
  @stories = @stories.select { |story| story.good }
  erb :index
end

# get '/stories' do

# end