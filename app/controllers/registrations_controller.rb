class RegistrationsController < Devise::RegistrationsController
  protected

  #this is for when people have to be approved, I think
  #def after_inactive_sign_up_path_for(resource)
  #  '/account_setup'
  #end
  def after_sign_up_path_for(resource)
    '/account_setup'
  end
end
