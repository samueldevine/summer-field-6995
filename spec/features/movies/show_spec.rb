require 'rails_helper'

RSpec.describe 'the movie show page' do
  describe 'as a user' do
    before :each do
      @studio = Studio.create!(name: 'Walt Disney Studios', location: 'Burbank, CA')
      @movie = @studio.movies.create!(title: 'Pirates of the Caribbean: The Curse of the Black Pearl', creation_year: 2003, genre: 'Fantasy')

      @actor_1 = @movie.actors.create!(name: 'Johnny Depp', age: 58)
      @actor_2 = @movie.actors.create!(name: 'Keira Knightley', age: 36)
      @actor_3 = @movie.actors.create!(name: 'Orlando Bloom', age: 44)
    end

    it 'I see the movies title, creation year, and genre' do
      visit movies_path(@movie)

      expect(page).to have_content @movie.title
      expect(page).to have_content @movie.creation_year
      expect(page).to have_content @movie.genre
    end

    it 'I see a list of all its actors from youngest to oldest' do
      visit movies_path(@movie)

      # appear_before assertion defined by the orderly gem
      expect(@actor_2.name).to appear_before @actor_3.name
      expect(@actor_3.name).to appear_before @actor_1.name
    end

    it 'I see the average age of all the movies actors' do
      visit movies_path(@movie)

      expect(page).to have_content 'Average Age of Actors: 46.0'
    end
  end
end
