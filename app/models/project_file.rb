class ProjectFile < ActiveRecord::Base
  attr_accessible :body, :project_id, :file_type

  validates :body, length: { minimum: 0 }, allow_nil: false
  validates :project_id, presence: true
  validates :file_type, presence: true

  belongs_to :project
end
