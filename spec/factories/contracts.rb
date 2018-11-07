FactoryBot.define do
  factory :contract do
    user
    costs { 10.5 }
    ends_on { Date.tomorrow }

    before(:create) do |contract, _evaluator|
      if contract.vendor.nil? || contract.category.nil?
        vc = create(:vendor_category)
        contract.vendor ||= vc.vendor
        contract.category ||= vc.category
      end
    end
  end
end
