class FileType < ActiveRecord::Migration
  def up
    remove_column :project_files, :type
    add_column :project_files, :file_type, :string
  end

  def down
    remove_column :project_files, :file_type
    add_column :project_files, :type, :string
  end
end
