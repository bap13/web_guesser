require 'sinatra'
require 'sinatra/reloader'

rand_num = rand(100)
colors = {:very_wrong => "#C33",
          :wrong => "#D77",
          :correct => "#4C4"}

get '/' do
  message = ""
  guess = params["guess"].to_i
  if guess > rand_num + 5
    message = "Way too high!"
    color = colors[:very_wrong]
  elsif guess < rand_num - 5
    message = "Way too low!"
    color = colors[:very_wrong]
  elsif guess > rand_num
    message = "Too high!"
    color = colors[:wrong]
  elsif guess < rand_num
    message = "Too low!"
    color = colors[:wrong]
  else
    message = "You got it right!<br>The SECRET NUMBER is #{rand_num}."
    color = colors[:correct]
  end
  erb :index, :locals => {:message => message, :color => color}
end
