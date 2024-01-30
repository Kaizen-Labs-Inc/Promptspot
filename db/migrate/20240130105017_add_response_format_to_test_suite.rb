class AddResponseFormatToTestSuite < ActiveRecord::Migration[7.0]
  def change
    add_column :test_suites, :response_format, :string
  end
end
