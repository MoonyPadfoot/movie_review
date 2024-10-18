class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:address, :address_region_id, :address_province_id, :address_city_id, :address_barangay_id])
    devise_parameter_sanitizer.permit(:account_update, keys: [:address, :address_region_id, :address_province_id, :address_city_id, :address_barangay_id])
  end
end
