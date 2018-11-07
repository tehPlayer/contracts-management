module Contracts
  class Create < ServicesBase
    attr_accessor :params, :contract, :user

    def initialize(params, user)
      @params, @user = params, user
    end

    def perform!
      scaffold_contract!
      contract.save if validate_ends_on
      contract
    end

    protected

      def scaffold_contract!
        @contract = user.contracts.new(params)
      end

      def validate_ends_on
        Date.parse(params[:ends_on])
      rescue ArgumentError
        contract.errors.add(:ends_on, :invalid)
        false
      end
  end
end