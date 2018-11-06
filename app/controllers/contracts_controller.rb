class ContractsController < ApplicationController
  before_action :authenticate_user!

  def index
    @contracts = current_user.
      contracts.
      includes(:vendor, :category).
      as_json(methods: %I[vendor_name category_name])
  end

  def new
    @vendors = Vendor.all
    @contract = current_user.contracts.new
  end

  def create
    @contract = current_user.contracts.new(contract_params)
    if @contract.save
      redirect_to contracts_path, notice: "Your contract was added."
    else
      @vendors = Vendor.all
      @categories = @contract.vendor&.categories

      flash[:alert] = @contract.errors.full_messages.to_sentence
      render :new
    end
  end

  protected

    def contract_params
      params.require(:contract).permit(:vendor_id, :category_id, :costs, :ends_on)
    end
end
