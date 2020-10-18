class ApplicationsController < ApplicationController

  def new

  end

  def show
    @application = Application.find(params[:application_id])
    @pet_search = Pet.search(params[:search])
  end

  def create
    user = User.find_by(name: params[:user_name])
    if user.nil?
      flash.now[:notice] = "User could not be found"
      render :new
    else
      @application = Application.create({status: "In Progress",
                                         user_id: user.id})
      redirect_to "/applications/#{@application.id}"
    end
  end
end
