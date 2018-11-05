FactoryBot.define do
  factory :contract do
    user
    cost { 10.5 }
    ends_on { "2018-11-05 23:42:37" }

    before(:create) do |contract, evaluator|
      vc = create(:vendor_category)
      contract.vendor = vc.vendor
      contract.category = vc.category
    end
  end
end
