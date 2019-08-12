require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = 10.times.map { ('A'..'Z').to_a.sample }
  end

  def score
    # assigning user input to a variable
    @word = params[:word]
    @letters = params[:letters]
    @answer ="You lose"
    if same?(@word, @letters) && english_word?(@word)
      @answer = "Well done!"
    elsif same?(@word, @letters)
      @answer = "Not an english word"
    elsif english_word?(@word)
      @answer = "English word, but not valid to the grid"
    else
      @answer
    end
  end
end





def same?(word, letters)
  word_array = word.upcase.split("")
  word_array.all? { |letter| word_array.count(letter) <= letters.count(letter) }
end

def english_word?(word)
  response = open("https://wagon-dictionary.herokuapp.com/#{word}")
  json = JSON.parse(response.read)
  return json['found']
end
