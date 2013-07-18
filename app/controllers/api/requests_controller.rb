class Api::RequestsController < ApplicationController

  skip_before_filter :authenticate_user!
  before_filter :api_authentikate_user

  respond_to :json

	before_filter :only_admin_manager, :only => :index
	before_filter :only_admin, :only => [:update]
	before_filter :get_request, :only => [:update, :destroy, :add_picture_to_request]

	def index
    respond_to do |format|
      @requests = Request.all
      format.json{}
    end
  end

	def create
    @params = params
    retrieve_params
    require 'open-uri'
    image1 = params[:image1]
    image2 = params[:image2]
    image3 = params[:image3]
    auth_token = params[:auth_token]
    params_string = URI::decode(params[:json_body])
    @params = JSON.parse(params_string)
    retrieve_params
    @params_options[:picture1] = image1
    @params_options[:picture2] = image2
    @params_options[:picture3] = image3

    @request = @current_user.requests.build @params_options
      if @request.save
        respond_to do |format|
          format.json {}
        end
      else
        invalid_login_attempt @request.errors, 402
      end
	end

	def update
    @params = params
    retrieve_params
    if @request
      if @request.update_attributes(@params_options)
        respond_to do |format|
          format.json {}
        end
      else
        invalid_login_attempt @request.errors, 402
      end
    else
      invalid_login_attempt ['can\'t find request by id'], 402
    end
  end

	def destroy
    if @request && @request.destroy
      respond_to do |format|
        format.json { render :json => {success: true, message: 'successfully deleted request'} }
      end
    else
      invalid_login_attempt ['can\'t find request by id'], 402
    end
  end

	private

	def only_admin_manager
    invalid_login_attempt(['permission denied'], 402) unless (current_user && (current_user.role?(:admin) || current_user.role?(:manager)))
	end

	def only_admin
    invalid_login_attempt(['permission denied'], 402) unless (current_user && current_user.role?(:admin))
	end

	def retrieve_params
    params = @params if @params != nil
    @params_options = {}
		unless params["current_status"].blank?
			current_status_name = params["current_status"]
      status = Status.where(:name => current_status_name).first
			@params_options[:status_id] = status.id if status
		end

		unless params["completed"].blank?
			@params_options[:completed] = params["completed"]
		end

		unless params['last_reviewed'].blank?
			@params_options[:last_reviewed] = parse_date params['last_reviewed'].to_s
		end

		unless params['creation_date'].blank?
        @params_options[:creation_date] = parse_date params['creation_date'].to_s
		end

		unless params['location_name'].blank?
      location = Location.where(:name => params['location_name']).first
			@params_options[:location_id] = location.id if location
		end

		# &&&
		unless params['requested_by'].blank?
			@params_options['requested_by'] = Location.where(:name => params['location']).first.id
		end
		
		unless params['desc'].blank?
			@params_options[:description] = params['desc']
		end

    unless params['importance'].blank?
      importance = Importance.where(:name => params['importance']).first
      @params_options[:importance_id] = importance.id if importance
    end

		unless params['problem_area'].blank?
      problem_area = ProblemArea.where(:name => params['problem_area']).first
			@params_options[:problem_area_id] = problem_area.id if problem_area
		end

    unless params['identifier'].blank?
      # Set request id
      @params_options[:id] = params['identifier']
    end

  end

	def get_request
		@request = Request.find_by_id params[:request_id]
  end

  def decode_base64file(encoded_file, content_type, file_name)
    decoded_data = Base64.decode64(encoded_file)
    data = StringIO.new(decoded_data)
    data.class_eval do
      attr_accessor :content_type, :original_filename
    end
    data.content_type = content_type
    data.original_filename = File.basename(file_name)
    data
  end

  def parse_date date_string
    format = "%Y-%m-%dT%H:%M:%SZ"
    date = nil
    begin
      date = DateTime.strptime(date_string, format)
    rescue
    end
    date
  end

end
