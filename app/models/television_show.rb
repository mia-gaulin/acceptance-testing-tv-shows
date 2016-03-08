require "spec_helper"

class TelevisionShow
  attr_reader :title, :network, :starting_year, :genre, :synopsis

  GENRES = ["Action", "Mystery", "Drama", "Comedy", "Fantasy"]

  def initialize(title, network, starting_year, genre, synopsis)
    @title = title
    @network = network
    @starting_year = starting_year
    @genre = genre
    @synopsis = synopsis
    @errors = []
  end

  def self.all
    @tv_shows = File.readlines('television-shows.csv')
    shows = []

    @tv_shows.each do |row|
      shows << row
    end

    shows
  end

  def errors
    @errors
  end

  def valid?
    
  end

  def save

  end
end
