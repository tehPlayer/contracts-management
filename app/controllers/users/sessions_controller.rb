# frozen_string_literal: true

module Users
  class SessionsController < Devise::SessionsController
    def create
      self.resource = warden.authenticate!(auth_options)
      set_flash_message!(:notice, :signed_in, name: resource.first_name)
      sign_in(resource_name, resource)
      yield resource if block_given?
      respond_with resource, location: after_sign_in_path_for(resource)
    end
  end
end
