class CreateClinicians < ActiveRecord::Migration
  def change
    create_table :clinicians do |t|

      t.string     :email
      t.string     :first_name
      t.string     :last_name
      t.string     :token
      t.timestamps null: false

    end
  end
end
