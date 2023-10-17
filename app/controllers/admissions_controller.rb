class AdmissionsController < ApplicationController
   def create
    @admission = Admission.new
    @admission.user = current_user
    @admission.crew = Crew.find(params[:crew_id])
    @admission.save!
    redirect_to crews_path
  end

  def delete
    admission = Crew.find(params['admission'])
    admission.destroy
    redirect_to crews_path
  end

  def accept
    @admission = Admission.find(params[:id])
    @admission.status = "accepted"
    @admission.save
    redirect_to users_dashboard_path
  end

  def reject
    @admission = Admission.find(params[:id])
    @admission.status = "rejected"
    @admission.save
    redirect_to users_dashboard_path
  end
end
