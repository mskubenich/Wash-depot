class Api::ListsController < ApplicationController

  respond_to :json

  def get_locations
    respond_to do |format|
      @locations = Location.all
      @names = []
      @locations.each do |location|
        @names << location.name
      end
      format.json{render :json => @names}
    end
  end

  def get_problem_areas
    respond_to do |format|
      @areas = ProblemArea.all
      @names = []
      @areas.each do |area|
        @names << area.name
      end
      format.json{render :json => @names}
    end
  end

  def get_statuses
    respond_to do |format|
      @statuses = Status.all
      @names = []
      @statuses.each do |status|
        @names << status.name
      end
      format.json{render :json => @names}
    end
  end

  def get_available_importance
    respond_to do |format|
      @importances = [1, 2, 3]
      format.json{render :json => @importances}
    end
  end

end
