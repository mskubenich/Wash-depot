class Api::ListsController < ApplicationController

  respond_to :json

  skip_before_filter :authenticate_user!
  before_filter :api_authentikate_user

  def get_lists
    respond_to do |format|
      @locations = Location.all
      @areas = ProblemArea.all
      @statuses = Status.all
      @importances = Importance.all
      @locations_names = []
      @areas_names = []
      @statuses_names = []
      @importances_names = []
      @locations.each do |location|
        @locations_names << location.name
      end
      @areas.each do |area|
        @areas_names << area.name
      end
      @statuses.each do |status|
        @statuses_names << status.name
      end
      @importances.each do |importance|
        @importances_names << importance.name
      end
      format.json{render :json => {locations: @locations_names, problem_areas: @areas_names, statuses: @statuses_names, importances: @importances_names}}
    end
  end

end
