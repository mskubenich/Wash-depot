class AddRelationFieldsToRequest < ActiveRecord::Migration
  def change
    add_column :requests, :user_id, :integer
    add_column :requests, :status_id, :integer
    add_column :requests, :problem_area_id, :integer
    add_column :requests, :location_id, :integer
  end
end
