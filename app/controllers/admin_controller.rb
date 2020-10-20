class AdminController < ApplicationController
  def show
    @application = Application.find(params[:application_id])
    @pets_applications = PetsApplication.where(application: params[:application_id])
  end

  def approve
    pet_application = PetsApplication.find(params[:pet_id])
    pet_application.update({status: 'Approved'})

    redirect_to "/admin/applications/#{params[:application_id]}"
  end

  def reject
    pet_application = PetsApplication.find(params[:pet_id])
    pet_application.update({status: 'Rejected'})

    redirect_to "/admin/applications/#{params[:application_id]}"
  end
end
