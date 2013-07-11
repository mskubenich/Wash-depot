class RequestsController < ApplicationController
  load_and_authorize_resource
  def index
    conditions = {}
    if current_user && current_user.role?(:regular)
      conditions = {user_id: current_user.id}
    end
    @requests_grid = initialize_grid(Request, include: [:location, :problem_area, :status], per_page: 20, :conditions => conditions)
  end

  def show
    @request = Request.find params[:id]
  end

  def new
    @request = Request.new
  end

  def create
    @request = Request.new(params[:request])
    @request.user = current_user
    respond_to do |format|
      if @request.save
        format.html {
          flash[:success] = 'Request was successfully created.'
          redirect_to @request
        }
      else
        format.html {
          flash[:error] = 'Failed to create request.'
          render action: 'new'
        }
      end
    end
  end

  def edit
    @request = Request.find(params[:id])
    @request.creation_date = @request.creation_date.strftime("%m-%d-%Y EST") if @request.creation_date
    @request.last_reviewed = @request.last_reviewed.strftime("%m-%d-%Y EST") if @request.last_reviewed
  end

  def update
    @request = Request.find(params[:id])
    respond_to do |format|
      if @request.update_attributes(params[:request])
        flash[:success] = 'Request was successfully updated.'
        format.html{
          redirect_to @request
        }
      else
        flash[:error] = 'Failed to update request.'
        render action: 'edit'
      end
    end
  end

  def destroy
    @request = Request.find(params[:id])
    @request.destroy

    respond_to do |format|
      format.html {
        flash[:notice] = 'Request was successfully destroyed.'
        redirect_to requests_url
      }
    end
  end

end
