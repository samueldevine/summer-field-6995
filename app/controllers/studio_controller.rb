class StudioController < ApplicationController
  def index
    @studios = Studio.all
  end
end
