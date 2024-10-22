class Users::RegistrationsController < Devise::RegistrationsController
  def edit
    @user = current_user
    super
  end

  def update
    @user = current_user
    super
  end
end