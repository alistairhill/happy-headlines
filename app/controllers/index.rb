get '/' do
  client = Npr::Client.new
  # begin
    # section = params[:news]
    @stories = client.parse_news
    erb :index
  # rescue
  #   status 404
  #   "Sinatra didn't sing shit on that day"
  # # end
end

# get '/news' do
#   client = Npr::Client.new
#   @stories = client.parse_news
#   erb :_news, layout: false
# end

# get '/sports' do
#   client = Nytimes::Client.new
#   @stories = client.parse_sports
#   erb :_news, layout: false
# end

get '/date' do
  client = Npr::Client.new
  date = params[:date]#.gsub('-','')
  p date
  p"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
  client.get_date(date)
  @stories = client.parse_date
  erb :_news
end

