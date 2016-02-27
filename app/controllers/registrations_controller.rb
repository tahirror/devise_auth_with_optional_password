class User::RegistrationsController < Devise::RegistrationsController
  before_filter :configure_permitted_parameters

  def create
    build_resource(sign_up_params)
    resource_saved = resource.save

    yield resource if block_given?
    if resource_saved
      if resource.active_for_authentication?
        set_flash_message :notice, :signed_up if is_flashing_format?
        sign_up(resource_name, resource)
        respond_with resource, location: after_sign_up_path_for(resource)
      else
        set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_flashing_format?
        expire_data_after_sign_in!
        respond_with resource, location: after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      @validatable = devise_mapping.validatable?
      if @validatable
        @minimum_password_length = resource_class.password_length.min
      end
      respond_with resource
    end
  end

  protected
    def configure_permitted_parameters
      devise_parameter_sanitizer.for(:sign_up).push(:referral_link, :referral_user_id)
      devise_parameter_sanitizer.for(:account_update).push(:referral_link, :referral_user_id)
    end

  private
    def sign_up_params
      params.require(:user).permit(:email, :password, :password_confirmation, :referral_link, :referral_user_id)
    end
end