class CreateProblemAreas < ActiveRecord::Migration
  def change
    create_table :problem_areas do |t|
      t.string :name

      t.timestamps
    end
  end
end
