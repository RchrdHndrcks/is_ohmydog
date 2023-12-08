# app/mailers/post_adoption_mailer.rb

class PostAdoptionMailer < ApplicationMailer
  def contact_email(contact_form, post_creator_email, cc_emails)
    @contact_form = contact_form
    @post_creator_email = post_creator_email
    #@user = User.find_by(email: post_creator_email) # Encuentra al usuario por su email
    Rails.logger.debug("admin emails en mailer")
    Rails.logger.debug(cc_emails)
    mail(to: @post_creator_email, cc: cc_emails, subject: 'Alguien se ha interesado en tu post de adopcion!')
  end
end
