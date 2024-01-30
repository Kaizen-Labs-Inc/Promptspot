FactoryBot.define do
  factory :test_suite do
    user
    account
    name { "Test Suite Example" }
    archived { false }
  end
end
