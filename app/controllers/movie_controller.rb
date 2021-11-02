class MovieController < ApplicationController
  def show
    @movie = Movie.find(params[:id])
  end

  def update
    movie = Movie.find(params[:id])
    actor = Actor.find_by(name: params[:name])

    if actor
      movie.actors << actor
    end

    redirect_to movie_path(movie)
  end
end
