require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = []
    10.times do
      @letters << ('A'..'Z').to_a.sample
    end
  end

  def valid?(word)
    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    word_serialized = URI.open(url).read
    word_values = JSON.parse(word_serialized)
    word_values['found']
  end

  def in_grid?(word, grid)
    word_letters = word.upcase.split('')
    word_letters.all? do |letter|
      word_letters.count(letter) <= grid.count(letter)
    end
  end

  def score
    @total_score = 0
    @valid = valid?(params[:word])
    @in_grid = in_grid?(params[:word], params[:letters])
  end
end
