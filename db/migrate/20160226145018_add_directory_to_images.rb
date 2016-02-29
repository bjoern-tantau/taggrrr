class AddDirectoryToImages < ActiveRecord::Migration
  def change
    add_reference :images, :directory, index: true, foreign_key: true
    remove_column :images, :path_id, :int
    rename_column :images, :relative_path, :name
  end
end
