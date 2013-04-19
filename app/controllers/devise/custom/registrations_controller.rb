class Devise::Custom::RegistrationsController < Devise::RegistrationsController

  def new

    resource = build_resource({})
    resource.mobile_code=  rand(4..1000)
    respond_with resource

  end

  def create
    begin
      build_resource
      if resource.save

        number_to_send_to = params[:user][:mobile_no]

        twilio_sid = "AC7941fab0c71bc0250ef6a53a1e4c1f0c"
        twilio_token = "24826a7716099e98aa54efc8db87e6f3"
        twilio_phone_number = "4846528283" # put phone number here after verififcation from twilio

        @twilio_client = Twilio::REST::Client.new twilio_sid, twilio_token

        @twilio_client.account.sms.messages.create(
            :from => "+1#{twilio_phone_number}",
            :to => number_to_send_to,
            :body => "This is your mobile code. #{resource.mobile_code}"
        )




        if resource.active_for_authentication?
          set_flash_message :notice, :signed_up if is_navigational_format?
          sign_up(resource_name, resource)
          respond_with resource, :location => after_sign_up_path_for(resource)
        else
          set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_navigational_format?
          expire_session_data_after_sign_in!
          respond_with resource, :location => after_inactive_sign_up_path_for(resource)
        end
      else
        clean_up_passwords resource
        respond_with resource
      end



    end
  end

end