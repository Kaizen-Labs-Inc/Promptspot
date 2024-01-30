class RemoveModeFromTestSuite < ActiveRecord::Migration[7.0]
  def change
    remove_column :test_suites, :mode, :string
  end
end
