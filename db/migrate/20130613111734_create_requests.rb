class CreateRequests < ActiveRecord::Migration
  def change
    create_table :requests do |t|
      t.integer :importance
      t.datetime :creation_date
      t.text :description
      t.datetime :last_reviewed
      t.integer :completed

      t.timestamps
    end
  end
end
