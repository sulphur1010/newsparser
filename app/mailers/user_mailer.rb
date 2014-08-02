class UserMailer < ActionMailer::Base
  default from: configatron.mailer.address
  def welcome(user)
  	@user=user
  	mail to: user.email, subject: "Welcome to #{configatron.website.name}"

  end
end
