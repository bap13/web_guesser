require 'sinatra'
require 'sinatra/reloader'

rand_num = rand(100)

get '/' do
  "The secret number is #{rand_num}."
end
