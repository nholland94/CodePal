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
end
