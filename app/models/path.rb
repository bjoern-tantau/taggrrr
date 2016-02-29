class Path < ActiveRecord::Base
  has_many :directories, dependent: :destroy
  has_many :images, through: :directories
  validates :path, presence: true

  def root
    self.directories.find_by(parent: nil)
  end
end
