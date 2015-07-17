class AddSmartphoneToPatients < ActiveRecord::Migration
  def change
    add_column :patients, :smartphone, :boolean
  end
end
