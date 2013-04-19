class AddMobilecodeToUser < ActiveRecord::Migration
  def change
    add_column :users, :mobile_code, :integer
  end
end
