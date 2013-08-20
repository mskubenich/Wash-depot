class ApplicationController < ActionController::Base
  before_filter :authenticate_user!
  protect_from_forgery

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url(error: 'Acces Denied!')
  end

  def tab
    nil
  end

  def invalid_login_attempt(errors, status = 200)
    warden.custom_failure!
    render :json => {:errors => errors,  :success => false}, :status => status and return
  end

  def api_authentikate_user
    @session = Session.where(:auth_token => params[:auth_token]).first
    unless @session
      invalid_login_attempt 'session invalid or expired', 401
    else
      @session.update_attributes(updated_at: Time.now)
      @current_user = User.where(id: @session.user_id).first
      unless @current_user
        invalid_login_attempt 'session invalid or expired', 401
        @session.destroy
      end
    end
  end

end
