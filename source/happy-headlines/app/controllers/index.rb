get '/' do
  erb :index
end

get '/stories' do
  client = Nytimes::Client.new
  erb :results
end