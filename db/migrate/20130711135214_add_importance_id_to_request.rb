class AddImportanceIdToRequest < ActiveRecord::Migration
  def change
    add_column :requests, :importance_id, :integer
    remove_column :requests, :importance
  end
end
