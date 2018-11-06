class ContractsController < ApplicationController
  before_action :authenticate_user!

  def index
    @contracts = current_user.
      contracts.
      includes(:vendor, :category).
      as_json(methods: %I[vendor_name category_name])
  end

  def new
    @contract = current_user.contracts.new
  end
end
