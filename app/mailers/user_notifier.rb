class UserNotifier < ApplicationMailer
	default from: "michael.foster@outlook.com",
		return_path: "michael.foster@outlook.com"
	@user = user
	mail(to: @user.email, subject: "Thanks for signing up for our amazing app")
	end
end


