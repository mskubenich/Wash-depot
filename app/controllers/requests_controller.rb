class RequestsController < ApplicationController
  def index

    @columns = ['id', 'description', 'importance', 'creation_date', 'completed', 'email', 'status_name', 'problem_area_name', 'location_name']

    @requests = Request.paginate(:page => params[:page], :per_page => params[:rows])

    @requests.each do |request|
      request.class_eval do
        attr_accessor :status_name, :problem_area_name, :location_name, :email
      end
      request.status_name = request.status ? request.status.name : nil
      request.problem_area_name = request.problem_area ? request.problem_area.name : nil
      request.location_name = request.location ? request.location.name : nil
      request.email = request.user ? request.user.email : nil
    end

    if request.xhr?
      render :json => json_for_jqgrid(@requests, @columns)
    end

  end

  def show
    @request = Request.find params[:id]
  end

  def new
    @request = Request.new
  end

  def create
    @request = Request.new(params[:request])

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
