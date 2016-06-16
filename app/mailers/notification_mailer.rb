class NotificationMailer < ActionMailer::Base
  default from: "no-reply@landscaprapp.com"

  def comment_added
    mail(to: "erinmorrissey@gmail.com", subject: "A comment has been added to your place")
  end
end
