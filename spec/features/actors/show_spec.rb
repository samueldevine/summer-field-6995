require 'rails_helper'

RSpec.describe 'the actor show page' do
  describe 'as a user' do
    before :each do
      @actor_1 = Actor.create(name: 'Viola Davis', age: 56)
    end

    it 'I see the actors name and age' do
      visit actor_path(@actor_1)

      expect(page).to have_content @actor_1.name
      expect(page).to have_content @actor_1.age
    end

    it 'I see a unique list of other actors this actor has worked with' do
      studio = Studio.create(name: 'Walt Disney Studios', location: 'Burbank, CA')

      actor_2 = Actor.create(name: 'Meryl Streep', age: 72)
      actor_3 = Actor.create(name: 'Emma Stone', age: 32)
      actor_4 = Actor.create(name: 'Johnny Depp', age: 58)

      doubt = studio.movies.create(title: 'Doubt', creation_year: 2008, genre: 'Drama')
      doubt.actors << @actor_1
      doubt.actors << actor_2
      thehelp = studio.movies.create(title: 'The Help', creation_year: 2011, genre: 'Drama')
      thehelp.actors << @actor_1
      thehelp.actors << actor_3
      thehelp.actors << actor_2
      pirates = studio.movies.create(title: 'Pirates of the Caribbean: The Curse of the Black Pearl', creation_year: 2003, genre: 'Fantasy')
      pirates.actors << actor_4

      visit actor_path(@actor_1)

      within 'div#costars' do
        expect(page).to have_content actor_2.name
        expect(page).to have_content actor_3.name
        expect(page).to_not have_content actor_4.name
      end
    end
  end
end
