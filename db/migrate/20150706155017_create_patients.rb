class CreatePatients < ActiveRecord::Migration
  def change
    create_table :patients do |t|

      t.references :clinician
      t.string     :phone
      t.string     :first_name
      t.string     :last_name
      t.integer    :amount

      t.string     :email
      t.string     :address
      t.string     :postal_code
      t.string     :city
      t.string     :region
      t.string     :country
      t.string     :ref_id
      t.string     :token

      t.boolean    :paid

      t.timestamps null: false
    end
  end
end
