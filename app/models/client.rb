class Client < User
  default_scope { where(role: :client) }

  has_many :projects, foreign_key: :client_id
end
