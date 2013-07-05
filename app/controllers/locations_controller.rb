class LocationsController < ApplicationController
  def index
    @locations = Location.all
  end
  
  def show
    @location = Location.find params[:id]
  end

  def new
    @location = Location.new
  end

  def create
    @location = Location.new(params[:location])

    respond_to do |format|
      if @location.save
        format.html {
          flash[:success] = 'Location was successfully created.'
          redirect_to @location
        }
      else
        format.html {
          flash[:error] = 'Failed to create location.'
          render action: 'new'
        }
      end
    end
  end

  def edit
    @location = Location.find(params[:id])
  end

  def update
    @location = Location.find(params[:id])
    respond_to do |format|
      if @location.update_attributes(params[:location])
        flash[:success] = 'Location was successfully updated.'
        format.html{
          redirect_to @location
        }
      else
        flash[:error] = 'Failed to update location.'
        render action: 'edit'
      end
    end
  end

  def destroy
    @location = Location.find(params[:id])
    @location.destroy

    respond_to do |format|
      format.html {
        flash[:notice] = 'Location was successfully destroyed.'
        redirect_to locations_url
      }
    end
  end

end
