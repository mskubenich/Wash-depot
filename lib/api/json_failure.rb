class Api::JsonFailure < Devise::FailureApp
	
	include ActionController::Rendering

	def respond
	    if request.format
	      # it is n the best way, but ...
	      # render habl view
	      render 'app/views/api/errors/require_auth', :status => 401
	    else
	      super
	    end
 	end
end