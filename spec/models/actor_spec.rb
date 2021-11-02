require 'rails_helper'

RSpec.describe Actor do
  describe 'relationsips' do
    it {should have_many(:actor_movies)}
    it {should have_many(:movies).through(:actor_movies)}
  end
end
