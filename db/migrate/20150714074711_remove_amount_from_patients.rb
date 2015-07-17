class RemoveAmountFromPatients < ActiveRecord::Migration
  def change
    remove_column :patients, :amount, :integer
  end
end

