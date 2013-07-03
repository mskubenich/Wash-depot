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
        if params[:image1]
          picture = decode_base64file params[:image1], 'image/png', 'image1.png'
          @request.picture1 = Picture.create picture: picture
          @request.save
        end
        if params[:image2]
          picture = decode_base64file params[:image2], 'image/png', 'image1.png'
          @request.picture2 = Picture.create picture: picture
          @request.save
        end
        if params[:image3]
          picture = decode_base64file params[:image2], 'image/png', 'image1.png'
          @request.picture3 = Picture.create picture: picture
          @request.save
        end
				format.json {}
			else
				format.json {render :json => @request.errors.to_json }
			end
		end
	end

	def update
		respond_to do |format|
			if @request.update_attributes(@params_options)
				format.json {}
			else
				format.json {render :json => @request.errors.to_json }
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
          picture = decode_base64file params[:image1], 'image/png', 'image.png'
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
			@params_options[:status_id] = Status.where(:name => current_status_name).first.id
		end

		unless params["completed"].blank?
			@params_options[:completed] = params["completed"]
		end

		unless params["last_reviewed"].blank?
			last_review = params["last_reviewed"].to_s
			@params_options[:last_reviewed] = DateTime.strptime(last_review,'%s') 
		end

		unless params['creation_date'].blank? 
			@params_options[:creation_date] = DateTime.strptime(params['creation_date'].to_s,'%s')
		end

		unless params['location_name'].blank?
			@params_options[:location_id] = Location.where(:name => params['location_name']).first.id
		end

		# &&&
		unless params['requested_by'].blank?
			@params_options['requested_by'] = Location.where(:name => params['location']).first.id
		end
		
		unless params['desc'].blank?
			@params_options[:description] = params['desc']
		end

		unless params['priority'].blank?
			@params_options[:importance] = params['priority']
		end

		unless params['problem_area'].blank?
			@params_options[:problem_area_id] = ProblemArea.where(:name => params['problem_area']).first.id
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
end
