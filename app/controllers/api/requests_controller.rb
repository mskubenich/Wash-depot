class Api::RequestsController < ApplicationController
	
	respond_to :json
	
	def index
	 # if current_user.type != 0
	  	@requests = Request.all
	 # end
	end

	def show
		@request = Request.find(params[:id])
	end
end
