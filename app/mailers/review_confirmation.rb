class ReviewConfirmation < ApplicationMailer
	default from: 'michael.foster@outlook.com',
	return_path: 'michael.foster@outlook.com'

	def conf_mail(user, drink)
		mail( to: 'michael.foster@outlook.com',
		subject: 'Review succesfully posted' )
  end
end
