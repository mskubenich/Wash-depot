class UsersController < ApplicationController

  def index
    @users = User.paginate(:page => params[:page], :per_page => 10)
  end

  def show
    @user = User.find params[:id]
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    puts '-----------------------------------------test----'
            puts @user
    puts '--------------------------------------------ere-'
    respond_to do |format|
      if @user.save
        format.html {
          flash[:success] = 'User was successfully created.'
          redirect_to @user
        }
      else
        format.html {
          flash[:error] = 'Failed to create user.'
          render action: 'new'
        }
      end
    end
  end
  #
  #  def edit
  #    @request = Request.find(params[:id])
  #  end
  #
  #  def update
  #    @request = Request.find(params[:id])
  #    respond_to do |format|
  #      if @request.update_attributes(params[:request])
  #        flash[:success] = 'Request was successfully updated.'
  #        format.html{
  #          redirect_to @request
  #        }
  #      else
  #        flash[:error] = 'Failed to update request.'
  #        render action: 'edit'
  #      end
  #    end
  #  end
  #
  #  def destroy
  #    @request = Request.find(params[:id])
  #    @request.destroy
  #
  #    respond_to do |format|
  #      format.html {
  #        flash[:notice] = 'Request was successfully destroyed.'
  #        redirect_to requests_url
  #      }
  #    end
  #  end
  #
  #end

end
