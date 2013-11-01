class CreateProjectMembers < ActiveRecord::Migration
  def change
    drop_table :project_members

    create_table :project_members do |t|
      t.string :user_id
      t.string :project_id

      t.timestamps
    end

    add_index :project_members, :user_id
    add_index :project_members, :project_id
  end
end
