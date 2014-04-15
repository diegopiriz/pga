class RemoveMimeTypeAndFileNameFromDogPicture < ActiveRecord::Migration
  def change
    remove_column  :dog_pictures, :mime_type
    remove_column  :dog_pictures, :filename
  end
end
