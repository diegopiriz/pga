class RemoveMimeTypeAndFileNameFromDogPicture < ActiveRecord::Migration
  def change
    remove_column  :dog_picture, :mime_type
    remove_column  :dog_picture, :filename
  end
end
