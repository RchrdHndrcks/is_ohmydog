# app/mailers/post_adoption_mailer.rb

class DogWalkerMailer < ApplicationMailer
    def contact_email(dog_walkers_sitters_contact, post_trabajador_email, cc_emails)
      @dog_walkers_sitters_contact = dog_walkers_sitters_contact
      @post_trabajador_email = post_trabajador_email
      #@user = User.find_by(email: post_creator_email) # Encuentra al usuario por su email
      Rails.logger.debug("admin emails en mailer")
      Rails.logger.debug(cc_emails)
      mail(to: @post_trabajador_email, cc: cc_emails, subject: 'Alguien se ha interesado en tu servicio!')
    end
  end
  