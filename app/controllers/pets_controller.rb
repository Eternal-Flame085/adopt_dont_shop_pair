class PetsController < ApplicationController

  def index
    @shelters = Shelter.all
    @pets = Pet.all
  end

  def show
    @pet = Pet.find(params[:id])
  end

  def new

  end

  def create
    pet = Pet.new({
      image: params[:pet][:image],
      name: params[:pet][:name],
      description: params[:pet][:description],
      age: params[:pet][:age],
      sex: params[:pet][:sex],
      status: params[:pet][:status],
      shelter_id: params[:shelter_id]
    })

    pet.save

    redirect_to "/shelters/#{params[:shelter_id]}/pets"
  end

  def edit
    @pet = Pet.find(params[:id])
  end

  def update
    pet = Pet.find(params[:id])
    pet.update(pet_params)

    redirect_to "/pets/#{params[:id]}"
  end

  def destroy
    Pet.destroy(params[:id])
    redirect_to '/pets'
  end

  private

  def pet_params
    params.permit(:image, :name, :age, :sex, :description)
  end
end
