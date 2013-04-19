class Devise::Custom::ConfirmationsController < Devise::ConfirmationsController

  def show
    self.resource = resource_class.confirm_by_token(params[:confirmation_token])
    if resource.errors.empty?
      set_flash_message(:notice, :confirmed) if is_navigational_format?
      sign_in(resource_name, resource)
      respond_with_navigational(resource) { redirect_to after_confirmation_path_for(resource_name, resource) }
    else
      respond_with_navigational(resource.errors, :status => :unprocessable_entity) { render :new }
    end
  end

  def create
    self.resource = resource_class.find_or_initialize_with_error_by(:confirmation_token, params[:user][:confirmation_token])
    if (params[:user][:mobile_code] != resource.mobile_code.to_s)
      resource.errors[:mobile_code] = "mobile code not matched"
    end

    if resource.errors.empty?
      self.resource = resource_class.confirm_by_token(params[:user][:confirmation_token])
      set_flash_message(:notice, :confirmed) if is_navigational_format?
      sign_in(resource_name, resource)
      respond_with_navigational(resource) { redirect_to after_confirmation_path_for(resource_name, resource) }
    else
      flash[:error] = "mobile code not matched"
      respond_with_navigational(resource.errors, :status => :unprocessable_entity) { redirect_to new_user_confirmation_url(resource, :confirmation_token => params[:user][:confirmation_token]) }
    end
  end
end
