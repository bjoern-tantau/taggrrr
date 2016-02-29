class Image < ActiveRecord::Base
  belongs_to :directory
  has_one :path, through: :directory
  has_many :tags, dependent: :destroy

  def image_file
    if !@image_file
      @image_file = ImageFile.new(self.full_path)
    end
    @image_file
  end

  def full_path
    if !@full_path
      directories = [self.name, self.directory.name]
      parent = self.directory.parent
      while parent
        directories << parent.name
        parent = parent.parent
      end
      directories << path.path
      directories.reverse!
      @full_path = File.join(directories)
    end
    @full_path
  end
end
