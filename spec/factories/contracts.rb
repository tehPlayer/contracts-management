FactoryBot.define do
  factory :contract do
    user
    costs { 10.5 }
    ends_on { "2018-11-05 21:42:37" } # TODO: to check for 23:50

    before(:create) do |contract, evaluator|
      vc = create(:vendor_category)
      contract.vendor = vc.vendor
      contract.category = vc.category
    end
  end
end
