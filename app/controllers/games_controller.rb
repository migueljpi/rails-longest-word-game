require 'open-uri'

class GamesController < ApplicationController
  def new
    abc = ("A".."Z").to_a
    @letters = Array.new(10) { abc.sample }
  end

  def score
    @word = params[:word]
    valid_letters = params[:letters].split("")
    @word.each_char do |char|
      if valid_letters.include?(char.upcase)
        valid_letters.delete_at(valid_letters.index(char.upcase)) # Remove used letter
      else
      # Invalid letter found
        @message = "Sorry but #{@word} can't be built out of #{params[:letters]}"
        return false
      end
    end

    url = "https://dictionary.lewagon.com/#{@word}"
    response = URI.open(url)
    result = JSON.parse(response.read)

    if result["found"] == false
      @message = "Sorry but #{@word.upcase} does not seem to be a valid English word..."
    else
      @message = "Congratulations! #{@word.upcase} is a valid English word!"
    end
  end
end
