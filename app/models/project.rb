class Project < ApplicationRecord
  belongs_to :client
  belongs_to :agent,  optional: true
  belongs_to :vendor, optional: true
  has_many :history_entries, dependent: :destroy

  validates :status, presence: true
  validate :status_must_change, on: :update

  after_update_commit :broadcast_status_change, if: :saved_change_to_status?

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


  # Returns the list of statuses that are not the current status
  def avaliable_statuses
    Project.statuses.except(self.status).keys
  end

  private

  def status_must_change
    return unless status_was == status

    errors.add(:status, "must be different from the current status")
  end


  def broadcast_status_change
    broadcast_update_to(
      [ self, "status_dropdown" ],
      target: "status_dropdown",
      html: render_dropdown_component
    )
  end

  def render_dropdown_component
    ApplicationController.render(
      DropdownComponent.new(
        trigger_text: "Change Status",
        options: avaliable_statuses,
        form_path: Rails.application.routes.url_helpers.update_status_project_path(self)
      ),
      layout: false
    )
  end
end
