class DogPicturesController < ApplicationController
  def create
    # @dog = Dog.find(params[:dog_id])
    # @dog_picture = @dog.dog_pictures.create(dog_picture_params)
    # redirect_to dog_path(@dog)

    puts "NEW PHOTO FOR #{params[:dog_id]}"

    # # build a photo and pass it into a block to set other attributes
    # @dog_picture = Dog.find(params[:dog_id]).dog_pictures.create(dog_picture_params) do |t|
    #   if params[:dog_picture][:data]
    #     t.data      = params[:dog_picture][:data].read
    #     t.filename  = params[:dog_picture][:data].original_filename
    #     t.type = params[:dog_picture][:data].content_type
    #   end
    # end
    @dog_picture = Dog.find(params[:dog_id]).dog_pictures.create()
    @dog_picture.data      = params[:dog_picture][:data].read
    @dog_picture.filename  = params[:dog_picture][:data].original_filename
    @dog_picture.mime_type = params[:dog_picture][:data].content_type

    # normal save
    if @dog_picture.save
       redirect_to dog_path(params[:dog_id])
    else
      render :action => "new"
    end
  end

  def destroy
    @dog = Dog.find(params[:dog_id])
    @dog_picture = @dog.dog_pictures.find(params[:id])
    @dog_picture.destroy
    redirect_to dog_path(@dog)
  end

  def serve
    @dog = Dog.find(params[:dog_id])
    @dog_picture = @dog.dog_pictures.find(params[:id])
    send_data(@dog_picture.data, :type => "image/png", :filename => "image.png", :disposition => "inline")
  end

  private
    def dog_picture_params
      params.require(:dog_picture).permit(:data)
    end
end
