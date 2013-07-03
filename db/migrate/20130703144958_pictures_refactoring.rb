class PicturesRefactoring < ActiveRecord::Migration
  def up
    remove_column :pictures, :request_id
    add_column :requests, :picture1_id, :integer
    add_column :requests, :picture2_id, :integer
    add_column :requests, :picture3_id, :integer
    Picture.delete_all()
  end

  def down
    add_column :pictures, :request_id, :integer
    remove_column :requests, :picture1_id
    remove_column :requests, :picture2_id
    remove_column :requests, :picture3_id
  end
end
