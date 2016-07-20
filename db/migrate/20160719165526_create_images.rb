class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.integer :sol
      t.text :img_src
      t.text :rover
      t.text :camera_name
      t.text :camera_full_name
      t.date :earth_date

      t.timestamps null: false
    end
  end
end
