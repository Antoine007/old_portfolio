class Patient < ActiveRecord::Base

  belongs_to :clinician

  validates :phone, :ref_id, presence: true
  validates :token, uniqueness: true

end
