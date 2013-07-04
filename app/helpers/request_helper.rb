module RequestHelper
  include JqgridsHelper

  def requests_jqgrid

    grid = [{
              :url => '/requests',
              :datatype => 'json',
              :mtype => 'GET',
              :colNames => ['Id','Description', 'Importance', 'Creation Date', 'Completed', 'User', 'Status', 'Problem Area', 'Location'],
              :colModel  => [
                { :name => 'id',   :index => 'id',    :width => 30 },
                { :name => 'description', :index => 'description',  :width => 100 },
                { :name => 'importance', :index => 'importance',  :width => 80 },
                { :name => 'creation_date', :index => 'creation_date',  :width => 130 },
                { :name => 'completed', :index => 'completed',  :width => 80 },
                { :name => 'user', :index => 'user',  :width => 100 },
                { :name => 'status', :index => 'status',  :width => 100 },
                { :name => 'problem_area', :index => 'problem_area',  :width => 100 },
                { :name => 'location', :index => 'location',  :width => 100 }
              ],
              :pager => '#requests_pager',
              :rowNum => 10,
              :rowList => [10, 20, 30],
              :caption => 'Requests',
              :height => 'auto',
              :width => '100%',
              :ondblClickRow => "function() { click();}".to_json_var,
              :multiselect => false
            }]

    # See http://www.trirand.com/jqgridwiki/doku.php?id=wiki:navigator
    # ('navGrid','#gridpager',{parameters}, prmEdit, prmAdd, prmDel, prmSearch, prmView)

    pager = [:navGrid, "#requests_pager", {:del => true}, {:closeAfterEdit => true, :closeOnEscape => true}, {}, {}, {}, {}]

    #pager_button = [:navButtonAdd, "#invoices_pager", {:caption => 'Add', :onClickButton => 'function() {click()}'.to_json_var }]

    jqgrid_api 'requests_list', grid, pager
  end
end
