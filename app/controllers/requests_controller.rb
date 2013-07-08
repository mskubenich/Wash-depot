class RequestsController < ApplicationController
  def index
    @requests_grid = initialize_grid(Request, include: [:location, :problem_area, :status], per_page: 20)
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
