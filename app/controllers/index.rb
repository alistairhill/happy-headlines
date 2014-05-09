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
  @stories = client.parse_sports
  erb :_news, layout: false
end

get '/date' do
  client = Nytimes::Client.new
  date = params[:date].gsub('-','')
  client.get_date(date)
  @stories = client.parse_date
  erb :_news
end

