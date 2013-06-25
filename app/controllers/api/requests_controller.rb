class Api::RequestsController < ApplicationController
	
	respond_to :json

	before_filter :only_admin_manager, :only => :index
	before_filter :only_admin, :only => [:update, :delete]
	before_filter :retrieve_params, :only => [:update]
	before_filter :get_request, :only => [:show, :update, :destroy]

	def index
		@requests = Request.all
	end

	def show
	end

	def create
	end

	def update
		respond_to do |format|
			if @request.update_attributes(@params_options)
				format.json { render :nothing => true }
			else
				format.json {render :json => @request.errors.to_json }
			end
		end 
	end

	def destroy
		respond_to do |format|
			if @request.destroy
				format.json { render :nothing => true }
			end
		end
	end

	private
	def only_admin_manager
		render "api/errors/permission_denied" if current_api_user.user_type == 0
	end

	def only_admin
		render "api/errors/permission_denied" if current_api_user.user_type != 2
	end

	def retrieve_params
		@params_options = {}

		unless params["current_status"].blank?
			current_status_name = params["current_status"]
			@params_options[:status_id] = Status.where(:name => current_status_name).first.id
		end

		unless params["completed"].blank?
			@params_options[:completed] = params["completed"]
		end

		unless params["last_review"].blank?
			last_review = params["last_review"]
			@params_options[:last_reviewed] = DateTime.strptime(last_review,'%s') 
		end
	end

	def get_request
		@request = Request.find params[:id]
	end
end
