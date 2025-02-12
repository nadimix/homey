class Agent < User
  default_scope { where(role: :agent) }

  has_many :projects, foreign_key: :agent_id
end
