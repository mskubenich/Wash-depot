class ClientsController < ApplicationController
  skip_before_filter :require_no_authentication
  authorize_resource User

  def tab
    'users'
  end

  def index
    @clients_grid = initialize_grid(User, per_page: 20)
    @roles = Role.all
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
    @client = User.find(params[:id])
    @client.destroy

    respond_to do |format|
      format.html {
        flash[:notice] = 'Request was successfully destroyed.'
        redirect_to clients_url
      }
    end
  end

  def change_user_role
    user = User.find(params[:user_id])
    role = Role.find(params[:new_role_id])
    if user && role && user != current_user
      user.roles = [role]
      render :text => "Succesfully changed "+user.email + " role to " + role.name
    else
      render :text => "error"
    end
  end
end
