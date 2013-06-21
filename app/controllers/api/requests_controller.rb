class Api::RequestsController < ApplicationController
	
	respond_to :json
	before_filter :only_admin_manager, :only => :index
	before_filter :only_admin, :only => :update
	
	def index
		@requests = Request.all
	end

	def show
		@request = Request.find(params[:id])
	end

	def create
	end

	def update
	end

	private
	def only_admin_manager
		puts current_api_user.user_type.to_s + " #{current_api_user.user_type.class}"
		render "api/errors/permission_denied" if current_api_user.user_type == 0
	end

	def only_admin
		render "api/errors/permission_denied" if current_api_user.user_type != 2
	end
end
