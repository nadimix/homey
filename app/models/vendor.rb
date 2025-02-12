class Vendor < User
  default_scope { where(role: :vendor) }

  has_many :projects, foreign_key: :vendor_id
end
