class AdminController < ApplicationController
  def show
    @application = Application.find(params[:application_id])
    @pets_applications = PetsApplication.where(application: params[:application_id])
    status = 'Pending'

    @pets_applications.each do |app|
      if !app.status.nil?
        if app.status == 'Rejected'
          status = 'Rejected'
        elsif status != 'Rejected' && app != @pets_applications.last && app.status != 'Rejected'
          status = 'Approved'
        end
        @application.update({status: status})
      end
    end
  end

  def approve
    pet_application = PetsApplication.where(:pet_id => "#{params[:pet_id]}",
                                            :application_id => "#{params[:application_id]}")
    pet_application.first.update({status: 'Approved'})
    redirect_to "/admin/applications/#{params[:application_id]}"
  end

  def reject
    pet_application = PetsApplication.where(:pet_id => "#{params[:pet_id]}",
                                            :application_id => "#{params[:application_id]}")
    pet_application.first.update({status: 'Rejected'})

    redirect_to "/admin/applications/#{params[:application_id]}"
  end
end
