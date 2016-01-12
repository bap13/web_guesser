require 'sinatra'
require 'sinatra/reloader'

class Secret
  attr_accessor :number, :guesses
  def initialize
    setup
  end

  def setup
    @number = rand(100)
    @guesses = 5
  end

  def reset
    setup
  end
end

secret = Secret.new
colors = {:very_wrong => "#F55",
          :wrong => "#F88",
          :correct => "#7F7",
          :reset => "#77F"}

get '/' do
  message = ""
  guess = params["guess"].to_i
  secret.guesses -= 1
  if secret.guesses <= 0 && secret.number != guess
    message = "You ran out of guesses<br><br>New number generated<br><br>"
    secret.reset
    color = colors[:reset]
  else
    if guess > secret.number + 5
      message = "Way too high!"
      color = colors[:very_wrong]
    elsif guess < secret.number - 5
      message = "Way too low!"
      color = colors[:very_wrong]
    elsif guess > secret.number
      message = "Too high!"
      color = colors[:wrong]
    elsif guess < secret.number
      message = "Too low!"
      color = colors[:wrong]
    else
      message = "You got it right! New number generated."
      color = colors[:correct]
      params["cheat"] = "true"
      secret.reset
    end
  end
  erb :index, :locals => {:secret => secret.number,
                          :message => message,
                          :color => color,
                          :cheat => params["cheat"],
                          :guesses => secret.guesses}
end
