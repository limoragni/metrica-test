class CreateLines < ActiveRecord::Migration
  def change
    create_table :lines do |t|
      t.string :name
      t.float :time
      t.float :point_a_x
      t.float :point_a_y
      t.float :point_b_x
      t.float :point_b_y

      t.timestamps
    end
  end
end
