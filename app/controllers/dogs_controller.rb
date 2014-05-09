class DogsController < ApplicationController
  before_action :set_dog, only: [:show, :edit, :update, :destroy]

  # GET /dogs
  # GET /dogs.json
  def index
    @dogs = Dog.paginate(page: params[:page], :per_page => 9).order('name')
  end

  # GET /dogs/1
  # GET /dogs/1.json
  def show
    if params[:layout] == 'modal'
      render action: 'show', layout: 'modal'
    end
  end


  # GET /dogs/new
  def new
    @dog = Dog.new
    build_pictures
  end

  # GET /dogs/1/edit
  def edit
    build_pictures
  end

  # POST /dogs
  # POST /dogs.json
  def create
    @dog = Dog.new(dog_params)

    respond_to do |format|
      if @dog.save
        format.html { redirect_to @dog, notice: 'Dog was successfully created.' }
        format.json { render action: 'show', status: :created, location: @dog }
      else
        format.html { render action: 'new' }
        format.json { render json: @dog.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /dogs/1
  # PATCH/PUT /dogs/1.json
  def update
    respond_to do |format|
      if @dog.update(dog_params)
        #format.html { redirect_to @dog, notice: 'Dog was successfully updated.' }
        #format.html { redirect_to edit_dog_path(@dog), notice: 'Dog was successfully updated.' }
        format.html { redirect_to dogs_url, notice: 'Dog was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @dog.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /dogs/1
  # DELETE /dogs/1.json
  def destroy
    @dog.destroy
    respond_to do |format|
      format.html { redirect_to dogs_url }
      format.json { head :no_content }
    end
  end


  def search
    @dogs = Dog.paginate(page: params[:page], :per_page => 9).order('name').search(params)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_dog
      @dog = Dog.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def dog_params
      params.require(:dog).permit(:name, :years, :months, :admission, :colors, :story, :personality, :weight, :status, :sex, dog_pictures_attributes: [:id, :data, :_destroy] )
    end

    def build_pictures
      30.times { @dog.dog_pictures.build }
    end
end
