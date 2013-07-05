class ClientsController < ApplicationController
  skip_before_filter :require_no_authentication
  def index
    @clients = User.paginate(:page => params[:page], :per_page => 10)
  end

  def show
    @client = User.find params[:id]
  end

  def new
    @client = User.new
  end

  def create
    @client = User.new(params[:user])
    respond_to do |format|
      if @client.save
        format.html {
          flash[:success] = 'User was successfully created.'
          redirect_to client_path(@client)
        }
      else
        format.html {
          flash[:error] = 'Failed to create user.'
          render action: 'new'
        }
      end
    end
  end

  def edit
    @client = User.find(params[:id])
  end

  def update
    @client = User.find(params[:id])
    respond_to do |format|
      if @client.update_attributes(params[:user])
        flash[:success] = 'Client was successfully updated.'
        format.html{
          redirect_to client_path(@client)
        }
      else
        flash[:error] = 'Failed to update client.'
        format.html{
          render action: 'edit'
        }
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
