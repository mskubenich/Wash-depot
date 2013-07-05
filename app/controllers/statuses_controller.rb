class StatusesController < ApplicationController
  def index
    @statuses = Status.all
  end


  def show
    @status = Status.find params[:id]
  end

  def new
    @status = Status.new
  end

  def create
    @status = Status.new(params[:status])

    respond_to do |format|
      if @status.save
        format.html {
          flash[:success] = 'Status was successfully created.'
          redirect_to @status
        }
      else
        format.html {
          flash[:error] = 'Failed to create status.'
          render action: 'new'
        }
      end
    end
  end

  def edit
    @status = Status.find(params[:id])
  end

  def update
    @status = Status.find(params[:id])
    respond_to do |format|
      if @status.update_attributes(params[:status])
        flash[:success] = 'Status was successfully updated.'
        format.html{
          redirect_to @status
        }
      else
        flash[:error] = 'Failed to update status.'
        render action: 'edit'
      end
    end
  end

  def destroy
    @status = Status.find(params[:id])
    @status.destroy

    respond_to do |format|
      format.html {
        flash[:notice] = 'Status was successfully destroyed.'
        redirect_to statuses_url
      }
    end
  end

end
