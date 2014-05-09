get '/' do
  client = Nytimes::Client.new
  @stories = client.parse_news
  erb :index
end

get '/news' do
  client = Nytimes::Client.new
  @stories = client.parse_news
  erb :_news, layout: false
end

get '/sports' do
  client = Nytimes::Client.new
  @sports = client.parse_sports
  erb :_sports, layout: false
end