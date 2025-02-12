class User < ApplicationRecord
  EMAIL_FORMAT_VALIDATION = /\A(?:[-_+.a-z0-9]+@)((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i

  has_many :history_entries

  enum :role, { admin: 0, client: 1, agent: 2, vendor: 3 }, default: :client

  validates :role, presence: true
  validates :first_name, :last_name, presence: true
  validates :email, presence: true
  validates_uniqueness_of :email, case_sensitive: false
  validates_format_of :email, with: User::EMAIL_FORMAT_VALIDATION
end
