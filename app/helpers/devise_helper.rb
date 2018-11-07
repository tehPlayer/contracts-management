# frozen_string_literal: true

module DeviseHelper
  def devise_error_messages!
    return '' unless devise_error_messages?

    errors = resource.errors.details.keys.map do |attr|
      resource.errors.full_messages_for(attr).first
    end

    flash[:alert] = errors.to_sentence

    ''
  end

  def devise_error_messages?
    !resource.errors.empty?
  end
end
