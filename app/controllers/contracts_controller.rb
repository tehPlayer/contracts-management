class ContractsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_contract, only: %I[edit update]

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
    service = Contracts::Create.run(contract_params, current_user)

    if service.success?
      redirect_to contracts_path, notice: t('contracts.controllers.create.messages.success')
    else
      @contract = service.result
      @vendors = Vendor.all
      @categories = @contract.vendor&.categories

      flash[:alert] = @contract.errors.full_messages.to_sentence
      render :new
    end
  end

  def edit
    @vendors = Vendor.all
    @categories = @contract.vendor.categories
  end

  def update
    service = Contracts::Update.run(contract_params, @contract)

    if service.success?
      redirect_to contracts_path, notice: t('contracts.controllers.update.messages.success')
    else
      flash[:alert] = service.result.errors.full_messages.to_sentence
      edit
      render action: :edit
    end
  end

  protected

    def set_contract
      @contract = current_user.contracts.find(params[:id])
    end

    def contract_params
      params.require(:contract).permit(:vendor_id, :category_id, :costs, :ends_on)
    end
end
