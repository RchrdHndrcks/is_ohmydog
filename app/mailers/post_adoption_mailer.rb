# app/mailers/post_adoption_mailer.rb

class PostAdoptionMailer < ApplicationMailer
  def contact_email(contact_form, post_creator_email)
    @contact_form = contact_form
    @post_creator_email = post_creator_email
    @user = User.find_by(email: post_creator_email) # Encuentra al usuario por su email

    mail(to: @post_creator_email, subject: 'Alguien se ha interessado en tu post de adopcion!')
  end
end
