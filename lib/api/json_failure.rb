class Api::JsonFailure < Devise::FailureApp
	
	include ActionController::Rendering

	def respond
	    if request_format == '*/*'
	      # it is n the best way, but ...
	      # render habl view
        render json: {success: false, info: 'Login Failed', data: {}, status: 401}
	    else
	      super
	    end
 	end
end