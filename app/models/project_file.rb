class ProjectFile < ActiveRecord::Base
  attr_accessible :body, :project_id, :type

  validates :body, presence: true
  validates :project_id, presence: true
  validates :type, presence: true

  belongs_to :project
end
