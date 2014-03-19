class Project < ActiveRecord::Base
  attr_accessible :creator_id, :description, :title

  validates :creator_id, presence: true
  validates :description, presence: true
  validates :title, presence: true

  has_many :project_files

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
  
  @file_types = %w(html css js)
  
  @file_types.each do |file_type|
    define_method file_type do
      self.project_files.select { |file| file.file_type == file_type) }.first
    end
  end
  
  after_create do
    @file_types.each do |type|
      ProjectFile.create!(file_type: type, body: "", project_id: self.id)
    end
  end
  
  def all_members
    [self.creator] + self.members
  end

end
