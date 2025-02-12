class Project < ApplicationRecord
  belongs_to :client
  belongs_to :agent,  optional: true
  belongs_to :vendor, optional: true
  has_many :history_entries, dependent: :destroy

  enum :status, {
    searching: 0,
    shortlisted: 1,
    virtual_viewing: 2,
    in_person_viewing: 3,
    offer_submitted: 4,
    offer_accepted: 5,
    deposit_paid: 6,
    move_in_scheduled: 7,
    moved_in: 8,
    utilities_set_up: 9,
    renewed: 10
  }, default: :searching
end
