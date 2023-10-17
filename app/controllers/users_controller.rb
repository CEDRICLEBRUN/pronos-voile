class UsersController < ApplicationController
  def dashboard
    @my_crews = Crew.includes_user(current_user)
    @requests = Admission.waiting_validation(current_user)
  end
end
