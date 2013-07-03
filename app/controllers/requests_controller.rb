class RequestsController < ApplicationController
  def index
    @requests = Request.all

    @columns = ['id', 'description']
    @invoices = Request.paginate(:page => params[:page], :per_page => params[:rows])
    if request.xhr?
      render :json => json_for_jqgrid(@invoices, @columns)
    end
  end

  def show
    @col_model = col_model_for_jqgrid(['id', 'description' ], {})
  end

end
