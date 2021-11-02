require 'rails_helper'

RSpec.describe Actor do
  describe 'relationsips' do
    it {should have_many(:actor_movies)}
    it {should have_many(:movies).through(:actor_movies)}
  end

  describe 'instance methods' do
    describe '#costars' do
      it 'returns a list of costars and not the actor' do
        studio = Studio.create(name: 'Walt Disney Studios', location: 'Burbank, CA')

        actor_1 = Actor.create(name: 'Viola Davis', age: 56)
        actor_2 = Actor.create(name: 'Meryl Streep', age: 72)
        actor_3 = Actor.create(name: 'Emma Stone', age: 32)
        actor_4 = Actor.create(name: 'Johnny Depp', age: 58)

        doubt = studio.movies.create(title: 'Doubt', creation_year: 2008, genre: 'Drama')
        doubt.actors << actor_1
        doubt.actors << actor_2
        thehelp = studio.movies.create(title: 'The Help', creation_year: 2011, genre: 'Drama')
        thehelp.actors << actor_1
        thehelp.actors << actor_3
        thehelp.actors << actor_2
        pirates = studio.movies.create(title: 'Pirates of the Caribbean: The Curse of the Black Pearl', creation_year: 2003, genre: 'Fantasy')
        pirates.actors << actor_4

        expect(actor_1.costars).to eq [actor_2, actor_3]
      end
    end
  end
end
