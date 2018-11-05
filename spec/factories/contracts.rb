FactoryBot.define do
  factory :contract do
    vendor
    category
    user
    cost { 1.5 }
    ends_on { "2018-11-05 23:42:37" }
  end
end
