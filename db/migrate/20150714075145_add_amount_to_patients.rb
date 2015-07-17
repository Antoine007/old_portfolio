class AddAmountToPatients < ActiveRecord::Migration
  def change
    add_column :patients, :amount, :float
  end
end
