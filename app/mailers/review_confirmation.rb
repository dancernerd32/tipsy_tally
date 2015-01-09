class ReviewConfirmation < ApplicationMailer
	default from: "michael.foster@outlook.com",
	return_path: "michael.foster@outlook.com"

	def conf_mail(user, drink)
		@user = user
		@drink = drink
		mail(to: @user.email, subject: "A review has been posted on your drink")
	end
end
