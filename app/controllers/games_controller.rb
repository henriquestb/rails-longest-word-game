require 'open-uri'

class GamesController < ApplicationController
  def generate_grid(grid_size)
    final_array = []
    (0...grid_size).each do
      final_array << ("A".."Z").to_a.sample
    end
    final_array
  end
  def new
     @resp = params[:score]
     @letters = generate_grid(10)
     $start_time = Time.now
     $letters = @letters
  end

  def score
    @resp = params[:score]
    @result = run_game(params[:score], $letters)
  end

  def parse(attempt)
    url = "https://wagon-dictionary.herokuapp.com/" + attempt
    user_serialized = open(url).read
    result = JSON.parse(user_serialized)
    result
  end
  def run_game(attempt, grid)
  # TODO: runs the game and return detailed hash of result
  end_time = Time.now
  result = parse(attempt)
  pow = (result['length']**3).positive? ? (result['length']**3) : 0
  if attempt.upcase.chars.map { |char| attempt.upcase.chars.count(char) <= grid.count(char) }.all? == true
    result = {
      time: (end_time - $start_time),
      score: (result['found'] == true ? pow - (end_time - $start_time).to_i : 0),
      message: (result['found'] == true ? 'Well done!' : 'Not an english result!')
    }
  else result = { time: 0, score: 0, message: "It's not in the grid!" }
  end
  result
  end
  end
