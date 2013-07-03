module RequestHelper
  include JqgridsHelper

  def invoices_jqgrid

    grid = [{
              :url => '/requests',
              :datatype => 'json',
              :mtype => 'GET',
              :colNames => ['Id','Description', ''],
              :colModel  => [
                { :name => 'id',   :index => 'id',    :width => 30 },
                { :name => 'description', :index => 'description',  :width => 400 },
                { caption:"NewButton"}
              ],
              :pager => '#invoices_pager',
              :rowNum => 10,
              :rowList => [10, 20, 30],
              :caption => 'Requests',
              :height => 'auto',
              :width => '100%'
            }]

    jqgrid_api 'invoices_list', grid
  end
end
