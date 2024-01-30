class RemoveModelTypeFromModel < ActiveRecord::Migration[7.0]
  def change
    remove_column :models, :model_type, :string
  end
end
