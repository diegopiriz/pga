module DogPicturesHelper
  def main_picture_id(dog)
    first_picture = dog.dog_pictures.order(updated_at: :asc).first
    first_picture || 1
  end
end
