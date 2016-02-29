class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.string :relative_path
      t.string :file_hash
      t.string :image_hash
      t.references :path, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
