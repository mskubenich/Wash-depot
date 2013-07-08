class Api::RequestsController < ApplicationController

	respond_to :json

	before_filter :only_admin_manager, :only => :index
	before_filter :only_admin, :only => [:update]
	before_filter :retrieve_params, :only => [:update, :create]
	before_filter :get_request, :only => [:update, :destroy, :add_picture_to_request]

	def index
    respond_to do |format|
      @requests = Request.all
      format.json{}
    end
	end

	def show
    respond_to do |format|
      if params[:request_id]
        @request = Request.find params[:request_id]
        @request.class_eval do
          attr_accessor :body, :original_filename
        end
        format.json{}
      else
        format.json {render :json => 'request id needed'}
      end
    end
	end

	def create
    user = User.where(:authentication_token => params[:auth_token]).first
		@request = user.requests.build @params_options
	  respond_to do |format|
			if @request.save
				format.json {}
			else
				format.json {render :json => @request.errors.to_json }
			end
		end
	end

	def update
		respond_to do |format|
      if @request
        if @request.update_attributes(@params_options)
          format.json {}
        else
          format.json {render :json => @request.errors.to_json }
        end
      else
        format.json { render :json => {success: false, message: 'can\'t find request by id'} }
      end
		end 
	end

	def destroy
		respond_to do |format|
      if @request && @request.destroy
        format.json { render :json => {success: true, message: 'successfully deleted request'} }
      else
        format.json { render :json => {success: false, message: 'can\'t find request by id'} }
      end
		end
  end

  def add_picture_to_request
    respond_to do |format|
      if @request
        if params[:image1]
          Picture.create picture: picture, request_id: @request.id
        end
        if params[:image2]
          picture = decode_base64file params[:image2], 'image/png', 'image.png'
          Picture.create picture: picture, request_id: @request.id
        end
        if params[:image2]
          picture = decode_base64file params[:image3], 'image/png', 'image.png'
          Picture.create picture: picture, request_id: @request.id
        end
        format.json {}
      else
        format.json { render :json => {success: false, message: 'can\'t find request by id'} }
      end
    end
  end

  def remove_picture
    picture = Picture.find_by_id params[:picture_id]
    respond_to do |format|
      if picture
        picture.destroy
        format.json { render :json => {success: true, message: 'successfully removed image'} }
      else
        format.json { render :json => {success: false, message: 'can\'t find request by id'} }
      end
    end
  end

	private

	def only_admin_manager
		render "api/errors/permission_denied" if current_user.user_type == 0
	end

	def only_admin
		render "api/errors/permission_denied" if current_user.user_type != 2
	end

	def retrieve_params
		
		# make available mass assignment

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
      @params_options[:importance] = params['importance']
    end

		unless params['problem_area'].blank?
      problem_area = ProblemArea.where(:name => params['problem_area']).first
			@params_options[:problem_area_id] = problem_area.id if problem_area
		end

    unless params['identifier'].blank?
      # Set request id
      @params_options[:id] = params['identifier']
    end

    unless params[:image1].blank?
      @params_options[:picture1] = decode_base64file params[:image1], 'image/png', 'image.png'
    end

    unless params[:image2].blank?
      @params_options[:picture2] = decode_base64file params[:image2], 'image/png', 'image.png'
    end

    unless params[:image3].blank?
      @params_options[:picture3] = decode_base64file params[:image3], 'image/png', 'image.png'
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
