class Actor < ApplicationRecord
  has_many :actor_movies
  has_many :movies, through: :actor_movies

  def costars
    costars = Actor.find(ActorMovie.where(movie_id: movies.ids).pluck(:actor_id))
    costars.delete(self)
    costars
  end
end
