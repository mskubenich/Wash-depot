class Api::RequestsController < ApplicationController
	
	respond_to :json
	
	def index
	 # if current_user.type != 0
	  	@requests = Request.all
	 # end
	 respond_to do |format|
	 	format.json {render :json => @requests.to_json }
	 end
	   
	end

	def show
		@request = Request.find(params[:id])
	end
end
