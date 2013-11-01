require 'bcrypt'

class User < ActiveRecord::Base
  attr_accessible :email, :password, :password_confirmation, :session_token, :username

  before_validation do
    self.session_token || reset_session_token
  end

	validate :password_and_confirmation_match

	def password_and_confirmation_match
		unless self.password == self.password_confirmation
			self.errors[:password] << "doesn't match the confirmation form"
		end
	end

  validates :email, presence: true
	validates :password, length: {minimum: 6, allow_null: true}
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
    @password = raw_pass
    self.password_digest = BCrypt::Password.create(raw_pass)
  end

  def password
    @password
  end

  def is_password?(raw_pass)
    BCrypt::Password.new(self.password_digest).is_password?(raw_pass)
  end

  def reset_session_token
    self.session_token = User.generate_session_token
  end
end
