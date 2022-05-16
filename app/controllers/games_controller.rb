require "json"
require "open-uri"

class GamesController < ApplicationController
  def new
    @letters = ('a'..'z').to_a.sample(10)
  end

  def match?
    @letters = params[:letters]
    @word = params[:word]
    @word.chars.all? do |letter|
      @word.count(letter) <= @letters.count(letter)
      end
  end

  def exist?
    url = "https://wagon-dictionary.herokuapp.com/#{params[:word]}"
    word_serialized = URI.open(url).read
    word = JSON.parse(word_serialized)

    word["found"]
  end

  def score
    # vérifier si les lettres du mot correspondent avec la grille et si le mot existe
    if match? && exist?
      @result = "you win"
    else
      @result = "Sorry but #{@word} can't be built out of #{@letters.join(',')}"
    end
  end
end
