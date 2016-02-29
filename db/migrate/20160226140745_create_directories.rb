class CreateDirectories < ActiveRecord::Migration
  def change
    create_table :directories do |t|
      t.string :name
      t.references :parent, references: :directories, index: true, null: true
      t.references :path, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
