class AddPicturesToRequest < ActiveRecord::Migration
  def change
    add_attachment :requests, :picture1
    add_attachment :requests, :picture2
    add_attachment :requests, :picture3

    drop_table :pictures
  end
end
