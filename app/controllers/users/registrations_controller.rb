class Users::RegistrationsController < Devise::RegistrationsController

  before_filter :configure_permitted_parameters
  include Users::RegistrationsHelper
   def create

    build_resource(sign_up_params)
    
    if resource.save
      yield resource if block_given?
      if resource.active_for_authentication?
        set_flash_message :notice, :signed_up if is_flashing_format?
        sign_up(resource_name, resource)
        respond_with resource, :location => after_sign_up_path_for(resource)
      else
        set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_flashing_format?
        expire_data_after_sign_in!
        respond_with resource, :location => after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      respond_with resource
    end
  end


  def update
    @user = User.find(current_user.id)
    puts params.inspect
    successfully_updated = if needs_password?(@user, params)
      if(params[:user][:email].nil?) #IF the email is not passed, remove it.
        params[:user][:email]=@user.email
      end

      @user.update_with_password(parameters)
    else
      # remove the virtual current_password attribute update_without_password
      # doesn't know how to ignore it
      #params[:user].delete(:current_password)
      #params[:user].delete(:encrypted_password)
      @user.update_without_password(parameters)
    end

    if successfully_updated
      set_flash_message :notice, :updated
      # Sign in the user bypassing validation in case his password changed
      sign_in @user, :bypass => true
      #redirect_to after_update_path_for(@user)
      redirect_to edit_user_registration_path
    else
      render "edit"
    end
  end

  protected
 
  # my custom fields are :name, :heard_how
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) do |u|
      u.permit(:name, 
        :email, :password, :password_confirmation)
    end
    devise_parameter_sanitizer.for(:account_update) do |u|
      u.permit(:name,
        :email, :password, :password_confirmation, :current_password,:list_visibility)
    end
      devise_parameter_sanitizer.for(:sign_in) do |u|
      u.permit(:name,
        :email, :password, :password_confirmation, :current_password)
    end
  end

  def parameters
    params[:user].permit(:email, :password, :name,:current_password)
  end
  private

  # check if we need password to update user data
  # ie if password or email was changed
  # extend this as needed
  def needs_password?(user, params)

    !(params[:user][:email].nil?)&&(user.email != params[:user][:email]) ||      params[:user][:password].present?
  end

end
