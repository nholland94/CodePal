class Project < ActiveRecord::Base
  attr_accessible :creator_id, :description, :title

  validates :creator_id, presence: true
  validates :description, presence: true
  validates :title, presence: true

  belongs_to(
    :creator,
    class_name: "User",
    foreign_key: :creator_id,
    primary_key: :id
  )

  has_many(
    :project_memberships,
    class_name: "ProjectMember",
    foreign_key: :project_id,
    primary_key: :id
  )

  has_many :members, through: :project_memberships, source: :user

  def all_members
    [self.creator] + self.members
  end
end
