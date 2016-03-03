require 'sinatra'
require 'csv'
require 'pry'
require_relative "app/models/television_show"

get '/' do
  redirect '/television_shows'
end

get '/television_shows' do
  @shows = File.readlines('television-shows.csv')
  erb :index
end

get '/television_shows/new' do
  erb :new
end

post '/television_shows/new' do
  @tv_shows = File.readlines('television-shows.csv')
  @error = nil

  show_name = params['title']
  show_network = params['network']
  show_starting_year = params['starting_year']
  show_synopsis = params['synopsis']
  show_genre = params['Genre']

  @tv_shows.each do |show|
    @check = show.split(",")
  end

  if @check[0] == params['title']
    @error = "The show has already been added"
    erb :new
  elsif params['title'] != "" && params['network'] != "" && params['starting_year'] != "" && params['synopsis'] != ""

    show_data = [show_name, show_network, show_starting_year, show_synopsis, show_genre]

    CSV.open('television-shows.csv', 'a') do |file|
      file << show_data
    end

    redirect '/television_shows'
  else
    @error = "Please fill in all required fields"
    erb :new
  end
end

set :views, File.join(File.dirname(__FILE__), "app/views")
