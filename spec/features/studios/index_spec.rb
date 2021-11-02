require 'rails_helper'

RSpec.describe 'the studio index page' do
  describe 'as a user' do
    it 'I see each studios name and location' do
      studio_1 = Studio.create!(name: 'Universal Pictures', location: 'Universal City')
      studio_2 = Studio.create!(name: 'Walt Disney Studios', location: 'Burbank')
      studio_3 = Studio.create!(name: '20th Century Studios', location: 'Century City')

      visit studios_path

      expect(page).to have_content studio_1.name
      expect(page).to have_content studio_2.name
      expect(page).to have_content studio_3.name
      expect(page).to have_content studio_1.location
      expect(page).to have_content studio_2.location
      expect(page).to have_content studio_3.location
    end

    it 'lists each studios movie titles' do
      studio_1 = Studio.create!(name: 'Universal Pictures', location: 'Universal City')
      studio_2 = Studio.create!(name: 'Walt Disney Studios', location: 'Burbank')

      movie_1 = studio_1.movies.create!(title: 'The Birds', creation_year: 1963, genre: 'Horror')
      movie_2 = studio_1.movies.create!(title: 'Jaws', creation_year: 1975, genre: 'Thriller')
      movie_3 = studio_2.movies.create!(title: 'Pirates of the Caribbean: The Curse of the Black Pearl', creation_year: 2003, genre: 'Fantasy')
      movie_4 = studio_2.movies.create!(title: 'Mary Poppins', creation_year: 1964, genre: 'Musical')

      visit studios_path

      within "div#studio-#{studio_1.id}" do
        expect(page).to have_content movie_1.title
        expect(page).to have_content movie_2.title
      end

      within "div#studio-#{studio_2.id}" do
        expect(page).to have_content movie_3.title
        expect(page).to have_content movie_4.title
      end
    end
  end
end
