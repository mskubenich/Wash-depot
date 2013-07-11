class ImportancesController < ApplicationController
  load_and_authorize_resource
  def index
    @importances_grid = initialize_grid(Importance, per_page: 10)
  end

  def show
    @importance = Importance.find params[:id]
  end

  def new
    @importance = Importance.new
  end

  def create
    @importance = Importance.new(params[:importance])

    respond_to do |format|
      if @importance.save
        format.html {
          flash[:success] = 'importance was successfully created.'
          redirect_to @importance
        }
      else
        format.html {
          flash[:error] = 'Failed to create importance.'
          render action: 'new'
        }
      end
    end
  end

  def edit
    @importance = Importance.find(params[:id])
  end

  def update
    @importance = Importance.find(params[:id])
    respond_to do |format|
      if @importance.update_attributes(params[:importance])
        flash[:success] = 'importance was successfully updated.'
        format.html{
          redirect_to @importance
        }
      else
        flash[:error] = 'Failed to update importance.'
        format.html{
          render action: 'edit'
        }
      end
    end
  end

  def destroy
    @importance = Importance.find(params[:id])
    @importance.destroy

    respond_to do |format|
      format.html {
        flash[:notice] = 'importance was successfully destroyed.'
        redirect_to importances_url
      }
    end
  end

end
