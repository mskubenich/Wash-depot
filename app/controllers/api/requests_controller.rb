class Api::RequestsController < ApplicationController
	
	respond_to :json

	before_filter :only_admin_manager, :only => :index
	before_filter :only_admin, :only => [:update, :delete]
	before_filter :retrieve_params, :only => [:update, :create]
	before_filter :get_request, :only => [:update, :destroy]

	def index
		@requests = Request.all
	end

	def show
    @ar = ['1', '454']
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
    request_json = {creation_date: params[:creation_date], description: params[:description], importance: params[:importance],
                    last_reviewed: params[:last_reviewed], problem_area_id: params[:problem_area_id], status_id: params[:status_id]}
		@request = user.requests.build request_json
	  respond_to do |format|
			if @request.save
        if params[:image1]
          picture = decode_base64file params[:image1], 'image/png', 'image1.png'
          Picture.create picture: picture, request_id: @request.id
        end
        if params[:image2]
          picture = decode_base64file params[:image2], 'image/png', 'image1.png'
          Picture.create picture: picture, request_id: @request.id
        end
        if params[:image2]
          picture = decode_base64file params[:image3], 'image/png', 'image1.png'
          Picture.create picture: picture, request_id: @request.id
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
				format.json { render :nothing => true }
			else
				format.json {render :json => @request.errors.to_json }
			end
		end 
	end

	def destroy
		respond_to do |format|
			if @request.destroy
				format.json { render :nothing => true }
			end
		end
	end

	private

	def only_admin_manager
		render "api/errors/permission_denied" if current_api_user.user_type == 0
	end

	def only_admin
		render "api/errors/permission_denied" if current_api_user.user_type != 2
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

		unless params["last_review"].blank?
			last_review = params["last_review"].to_s
			@params_options[:last_reviewed] = DateTime.strptime(last_review,'%s') 
		end

		unless params['creation_date'].blank? 
			@params_options[:creation_date] = DateTime.strptime(params['creation_date'].to_s,'%s')
		end

		unless params['location'].blank?
			@params_options[:location_id] = Location.where(:name => params['location']).first.id
		end

		# &&&
		unless params['requested_by'].blank?
			@params_options['requested_by'] = Location.where(:name => params['location']).first.id
		end
		
		unless params['description'].blank?
			@params_options[:description] = params['description']
		end

		unless params['importance'].blank?
			@params_options[:importance] = params['importance']
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
		@request = Request.find params[:id]
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
