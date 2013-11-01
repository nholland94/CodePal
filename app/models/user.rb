class User < ActiveRecord::Base
  attr_accessible :email, :password, :session_token, :username

  before_validation do
    self.session_token = self.session_token || self.class.generate_session_token
  end

  validates :email, presence: true
  validates :password_digest, presence: true
  validates :session_token, presence: true
  validates :username, presence: true

  has_many(
    :created_projects,
    class_name: "Project",
    foreign_key: :creator_id,
    primary_key: :id
  )

  has_many(
    :project_memberships,
    class_name: "ProjectMember"
  )

  has_many :jointProjects, through: :project_memberships, source: :project

  def self.generate_session_token
    return SecureRandom::urlsafe_base64
  end

  def password=(raw_pass)

  end
end
