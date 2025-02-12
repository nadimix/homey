class User < ApplicationRecord
  EMAIL_FORMAT_VALIDATION = /\A(?:[-_+.a-z0-9]+@)((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i

  has_secure_password
  has_many :history_entries
  has_many :sessions, dependent: :destroy

  enum :role, { admin: 0, client: 1, agent: 2, vendor: 3 }, default: :client

  normalizes :email, with: ->(e) { e.strip.downcase }

  validates :role, presence: true
  validates :first_name, :last_name, presence: true
  validates :email, presence: true, uniqueness: true
  validates_format_of :email, with: User::EMAIL_FORMAT_VALIDATION

  def full_name
    "#{first_name} #{last_name}"
  end
end
