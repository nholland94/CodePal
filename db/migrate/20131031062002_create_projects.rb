class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :title
      t.integer :creator_id
      t.text :description

      t.timestamps
    end

    add_index :projects, :creator_id
  end
end
