FactoryBot.define do
  factory :contract do
    user
    costs { 10.5 }
    ends_on { Date.tomorrow }

    before(:create) do |contract, evaluator|
      vc = create(:vendor_category)
      contract.vendor = vc.vendor
      contract.category = vc.category
    end
  end
end
