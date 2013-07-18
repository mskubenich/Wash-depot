
class Api::SessionsController < Devise::SessionsController

   skip_before_filter :authenticate_user!
   before_filter :api_authentikate_user, only: :destroy
   before_filter :ensure_params_exist, :only => [:create]

   respond_to :json

   def create
    @user = User.find_for_database_authentication(:email=>params[:user][:email])

    if @user && @user.valid_password?(params[:user][:password])
      range = [*'0'..'9', *'a'..'z', *'A'..'Z']
      session = Session.create(user_id: @user.id, auth_token: Array.new(30){range.sample}.join)
      render :json => {:success=>true,
                      :info => "Logged in",
                      :data => {auth_token: session.auth_token, email: resource.email, user_type: resource.user_type.to_s},
                      :status => 200
                    }
    else
      invalid_login_attempt 'invalid login or password', 401
    end
  end

  def destroy
    remove_expired_sessions   #sorry
    session = Session.where(:auth_token => params[:auth_token]).first
    if session
      session.destroy
      render :json => { :success => true,  :info => "Logged out", :status => 200 }
    else
      invalid_login_attempt 'invalid login or password', 401
    end
  end

  protected
  
  def ensure_params_exist
    if params[:user].blank? || params[:user][:email].blank? || params[:user][:password].blank?
      invalid_login_attempt 'invalid login or password', 401
    end
  end

  def remove_expired_sessions
    Session.where("updated_at < ?", Time.now - 1.week).each do |session|
      session.destroy
    end
  end

end