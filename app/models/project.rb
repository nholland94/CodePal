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
  
  after_create do
    ['html', 'css', 'js'].each do |type|
      ProjectFile.create!(file_type: type, body: "", project_id: self.id)
    end
  end

  def all_members
    [self.creator] + self.members
  end

  def method_missing(method, *args, &block)
    if method[-5..-1] == "_file"
      file_type = method[0..-6]
      file = self.project_files.where(file_type: file_type)
      return file
    else
      super
    end
  end
end
