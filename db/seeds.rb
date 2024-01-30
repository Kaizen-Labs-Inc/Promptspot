# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

model_provider = ModelProvider.find_or_create_by!(name: "OpenAI")

models_data = [
  {name: "gpt-4-preview", description: "The latest GPT-4 model intended to reduce cases of 'laziness' where the model doesn’t complete a task.", enabled: true},
  { name: "gpt-3.5-turbo-1106", description: "The latest GPT-3.5 Turbo model with improved instruction following, JSON mode, reproducible outputs, parallel function calling, and more. Returns a maximum of 4,096 output tokens.", enabled: true },
]

models_data.each do |model_data|
  model = Model.find_or_initialize_by(name: model_data[:name])
  model.update!(model_data.merge(model_provider: model_provider))
end

puts "✅ Created model providers and models"
