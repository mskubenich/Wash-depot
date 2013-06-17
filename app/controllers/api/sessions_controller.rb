
class Api::SessionsController < Devise::SessionsController
  
  before_filter :require_no_authentication, :only => [:create]
  skip_before_filter :verify_authenticity_token,
                       :if => Proc.new { |c| c.request.format == 'application/json' }

   before_filter :ensure_params_exist, :only => [:create] 
   
   respond_to :json

   def create
    build_resource
    resource = User.find_for_database_authentication(:email=>params[:user][:email])
    return invalid_login_attempt unless resource
     
    if resource.valid_password?(params[:user][:password])
      sign_in("user", resource)
      render :json => {:success=>true, 
                      :info => "Logged in", 
                      :data => {:auth_token=>resource.authentication_token,  :email => resource.email }
                    }
      return
    end
    invalid_login_attempt
  end

  def destroy
    warden.authenticate!(:scope => resource_name, :recall => "#{controller_path}#invalid_login_attempt")
    User.where(:authentication_token => params[:auth_token]).first.update_column(:authentication_token, nil)
    render :status => 200,
           :json => { :success => true,
                      :info => "Logged out",
                      :data => {} }
  end

  protected
  
  def ensure_params_exist
    return unless params[:user].blank? || params[:user][:email].blank? || params[:user][:password].blank?
    invalid_login_attempt
  end

  def invalid_login_attempt
    render 'api/errors/require_auth'
  end
end