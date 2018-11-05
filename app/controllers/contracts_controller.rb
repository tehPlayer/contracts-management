class ContractsController < ApplicationController
  before_action :authenticate_user!

  def index
    @contracts = current_user.contracts
  end
end
