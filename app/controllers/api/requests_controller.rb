class Api::RequestsController < ApplicationController
	
	respond_to :json
	before_filter :only_admin_manager, :only => :index
	before_filter :only_admin, :only => [:update, :delete]
	
	def index
		@requests = Request.all
	end

	def show
		@request = Request.find(params[:id])
	end

	def create
	end

	def update
		@request = Request.find(params[:id])

		update_options = {}

		unless params["current_status"].blank?
			current_status_name = params["current_status"]
			update_options[:status_id] = Status.where(:name => current_status_name).first.id
		end

		unless params["completed"].blank?
			update_options[:completed] = params["completed"]
		end

		unless params["last_review"].blank?
			last_review = params["last_review"]
			update_options[:last_reviewed] = DateTime.strptime(last_review,'%s') 
		end

		respond_to do |format|
			if @request.update_attributes(update_options)
				format.json { render :nothing => true }
			else
				format.json {render :json => @request.errors.to_json }
			end
		end 
	end

	def destroy
		@request = Request.find params[:id]
		
		respond_to do |format|
			if @request.destroy
				format.json { render :nothing => true }
			end
		end
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
