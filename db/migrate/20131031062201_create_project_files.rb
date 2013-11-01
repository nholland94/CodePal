class CreateProjectFiles < ActiveRecord::Migration
  def change
    create_table :project_files do |t|
      t.string :type
      t.text :body
      t.integer :project_id

      t.timestamps
    end

    add_index :project_files, :project_id
  end
end
