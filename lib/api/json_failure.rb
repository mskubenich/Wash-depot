class Api::JsonFailure < Devise::FailureApp
	
	include ActionController::Rendering

	def respond
	    if request_format == :json
        render 'app/views/api/errors/require_auth', :status => 401
	    else
	      super
	    end
 	end
end