FactoryBot.define do
  factory :model do
    model_provider
    name { "davinci" }
    enabled { false }
    description { "This is an example description" }
  end
end
