module Api
  class CategoriesController < ApplicationController
    before_action :authenticate_user!
    before_action :set_vendor

    def index
      render json: @vendor.categories
    end

    private

      def set_vendor
        @vendor = Vendor.find(params[:vendor_id])
      end
  end
end