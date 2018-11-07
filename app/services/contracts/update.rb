module Contracts
  class Update < ServicesBase
    attr_accessor :params, :contract

    def initialize(params, contract)
      @params, @contract = params, contract
    end

    def perform!
      update_contract! if validate_ends_on
      contract
    end

    protected

      def update_contract!
        contract.update(params)
      end

      def validate_ends_on
        Date.parse(params[:ends_on])
      rescue ArgumentError
        contract.errors.add(:ends_on, :invalid)
        false
      end
  end
end