module DogPicturesHelper
  def main_picture_id(dog)
    first_picture = dog.dog_pictures.order(updated_at: :asc).first
    first_picture || 1
  end

  def picture_for(dog_id, picture_id)
    @dog = Dog.find(dog_id)
    @dog_picture = @dog.dog_pictures.find(picture_id)
    @dog_picture.data
  end
end
