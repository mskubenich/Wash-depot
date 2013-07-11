class CreateImportances < ActiveRecord::Migration
  def change
    create_table :importances do |t|
      t.string :name
    end
  end
end
