class AddPicToPicture < ActiveRecord::Migration
  def self.up
    add_attachment :pictures, :picture
  end

  def self.down
    remove_attachment :pictures, :picture
  end
end
