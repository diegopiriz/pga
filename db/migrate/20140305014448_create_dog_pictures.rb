class CreateDogPictures < ActiveRecord::Migration
  def change
    create_table :dog_pictures do |t|
      t.integer :dog_id
      t.binary :data
      t.string :mime_type
      t.string :filename

      t.timestamps
    end
  end
end
