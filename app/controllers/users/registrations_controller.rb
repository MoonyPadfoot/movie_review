class Users::RegistrationsController < Devise::RegistrationsController
  def edit
    @user = current_user.includes(:posts, :region, :province, :city, :barangay)
    super
  end

  def update
    @user = current_user.includes(:posts, :region, :province, :city, :barangay)
    super
  end
end