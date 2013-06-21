
class Api::UsersController < ApplicationController

	respond_to :json

	def index
		@users = User.all
		render "api/users/index"
	end
end
