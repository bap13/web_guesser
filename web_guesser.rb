require 'sinatra'
require 'sinatra/reloader'

rand_num = rand(100)

get '/' do
  message = ""
  guess = params["guess"].to_i
  if guess > rand_num + 5
    message = "Way too high!"
  elsif guess < rand_num - 5
    message = "Way too low!"
  elsif guess > rand_num
    message = "Too high!"
  elsif guess < rand_num
    message = "Too low!"
  else
    message = "You got it right!<br>The SECRET NUMBER is #{rand_num}."
  end
  erb :index, :locals => {:message => message}
end
