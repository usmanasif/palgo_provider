class UserMailer < ActionMailer::Base
  def registration_confirmation(user)
    mail(:to => user.email, :subject => "Registered", :from => "usmantest@devsinc.com")
  end
end