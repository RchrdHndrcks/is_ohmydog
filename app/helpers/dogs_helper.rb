# app/helpers/dogs_helper.rb
module DogsHelper
    def render_error_messages_for(object, field)
      if object.errors[field].any?
        content_tag(:div, object.errors[field].to_sentence, class: 'error-message')
      end
    end
  end