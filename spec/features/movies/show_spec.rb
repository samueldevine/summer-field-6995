require 'rails_helper'

RSpec.describe 'the movie show page' do
  describe 'as a user' do
    before :each do
      @studio = Studio.create(name: 'Walt Disney Studios', location: 'Burbank, CA')
      @movie = @studio.movies.create(title: 'Pirates of the Caribbean: The Curse of the Black Pearl', creation_year: 2003, genre: 'Fantasy')

      @actor_1 = @movie.actors.create(name: 'Johnny Depp', age: 58)
      @actor_2 = @movie.actors.create(name: 'Keira Knightley', age: 36)
      @actor_3 = @movie.actors.create(name: 'Orlando Bloom', age: 44)
    end

    it 'I see the movies title, creation year, and genre' do
      visit movie_path(@movie)

      expect(page).to have_content @movie.title
      expect(page).to have_content @movie.creation_year
      expect(page).to have_content @movie.genre
    end

    it 'I see a list of all its actors from youngest to oldest' do
      visit movie_path(@movie)

      # appear_before assertion defined by the orderly gem
      expect(@actor_2.name).to appear_before @actor_3.name
      expect(@actor_3.name).to appear_before @actor_1.name
    end

    it 'I see the average age of all the movies actors' do
      visit movie_path(@movie)

      expect(page).to have_content 'Average Age of Actors: 46.0'
    end

    it 'I do not see any actors that are not part of the movie' do
      actor_4 = Actor.create(name: 'George Clooney', age: 60)

      visit movie_path(@movie)

      expect(page).to_not have_content actor_4.name
    end

    it 'I see a form to add an actor to this movie' do
      visit movie_path(@movie)

      within "div#add-actor" do
        expect(page).to have_content 'Add an actor to this movie:'
        expect(page).to have_button 'Submit'
      end
    end

    it 'the form adds existing actors to the movie' do
      actor_4 = Actor.create(name: 'George Clooney', age: 60)

      visit movie_path(@movie)
      fill_in :name, with: actor_4.name
      click_on 'Submit'

      expect(current_path).to eq movie_path(@movie)

      expect(page).to have_content actor_4.name
    end
  end
end
