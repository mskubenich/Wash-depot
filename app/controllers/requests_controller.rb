class RequestsController < ApplicationController
  load_and_authorize_resource
  def index
    conditions = {}
    if current_user && current_user.role?(:regular)
      conditions = {user_id: current_user.id}
    end
    @requests_grid = initialize_grid(Request, include: [:location, :problem_area, :status, :importance], per_page: 20, :conditions => conditions)
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
    if params[:request][:picture1] == ""
      params[:request].delete(:picture1)
      @request.picture1.destroy if @request.picture1
    end
    if params[:request][:picture2] == ""
      params[:request].delete(:picture2)
      @request.picture2.destroy if @request.picture2
    end
    if params[:request][:picture1] == ""
      params[:request].delete(:picture1)
      @request.picture3.destroy if @request.picture3
    end
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
