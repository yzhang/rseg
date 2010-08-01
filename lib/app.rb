require 'sinatra/base'

class App < Sinatra::Base
  set :root,   File.dirname(__FILE__) + "/.."
  set :app_file, __FILE__

  get '/' do
    haml :index
  end

  post '/segment' do
    @input = params[:input]
    @result = Rseg.segment(@input).join(' ')
    haml :index
  end

  post '/seg' do
    @input = params[:input]
    @result = Rseg.segment(@input)
    @result.join(' ')
  end
end