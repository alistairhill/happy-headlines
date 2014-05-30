get '/' do
  client = Npr::Client.new
  begin
    @stories = client.parse_news
    erb :index
  rescue
    status 404
    "Sinatra didn't sing shit on that day"
  end
end

get '/categories/:category' do
  client = Npr::Client.new
  @stories = client.parse_news(params[:category])
  erb :_news
end

get '/date' do
  client = Npr::Client.new
  date = params[:date]
  @stories = client.get_date(date)
  erb :_news
end

