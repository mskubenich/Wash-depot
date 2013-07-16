class ProblemAreasController < ApplicationController
  load_and_authorize_resource

  def tab
    'problem_areas'
  end

  def index
    @areas_grid = initialize_grid(ProblemArea, per_page: 10)
  end

  def show
    @area = ProblemArea.find params[:id]
  end
  #
  def new
    @area = ProblemArea.new
  end

  def create
    @area = ProblemArea.new(params[:problem_area])
    respond_to do |format|
      if @area.save
        format.html {
          flash[:success] = 'Area was successfully created.'
          redirect_to problem_area_path(@area)
        }
      else
        format.html {
          flash[:error] = 'Failed to create area.'
          render action: 'new'
        }
      end
    end
  end

  def edit
    @area = ProblemArea.find(params[:id])
  end

  def update
    @area = ProblemArea.find(params[:id])
    respond_to do |format|
      if @area.update_attributes(params[:problem_area])
        flash[:success] = 'Problem Area was successfully updated.'
        format.html{
          redirect_to problem_area_path(@area)
        }
      else
        flash[:error] = 'Failed to update area.'
        format.html{
          render action: 'edit'
        }
      end
    end
  end

  def destroy
    @area = ProblemArea.find(params[:id])
    @area.destroy

    respond_to do |format|
      format.html {
        flash[:notice] = 'Area was successfully destroyed.'
        redirect_to problem_areas_path
      }
    end
  end
end
