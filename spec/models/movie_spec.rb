require 'rails_helper'

RSpec.describe Movie do
  describe 'relationships' do
    it { should belong_to(:studio) }
  end

  describe 'instance methods' do
    before :each do
      @studio = Studio.create!(name: 'Walt Disney Studios', location: 'Burbank, CA')
      @movie = @studio.movies.create(title: 'Pirates of the Caribbean: The Curse of the Black Pearl', creation_year: 2003, genre: 'Fantasy')

      @actor_1 = @movie.actors.create(name: 'Johnny Depp', age: 58)
      @actor_2 = @movie.actors.create(name: 'Keira Knightley', age: 36)
      @actor_3 = @movie.actors.create(name: 'Orlando Bloom', age: 44)
    end

    describe '#actors_by_age' do
      it 'returns a movies actors in order of age, youngest to oldest' do
        expect(@movie.actors_by_age).to eq [@actor_2, @actor_3, @actor_1]
      end
    end

    describe '#average_age' do
      it 'returns the average age of all of the movies actors' do
        expect(@movie.average_age).to eq 46.0
      end
    end
  end
end
