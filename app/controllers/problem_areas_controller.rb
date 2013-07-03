class ProblemAreasController < ApplicationController
  def index
    @problem_areas = ProblemArea.all
  end
end
