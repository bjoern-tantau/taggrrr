class PathScanJob < ActiveJob::Base
  queue_as :default

  def perform(path)
    self.add_files(path)
  end

  protected
    def add_files(path, full_path = nil, dir = nil)
      full_path ||= path.path
      dirname = File.basename(full_path.partition(path.path).last)
      directory = Directory.find_or_create_by(name: dirname, parent: dir, path: path)
      files = File.join(full_path, "*")
      Dir.glob(files).each do |file|
        if File.directory?(file)
          add_files(path, file, directory)
        else
          basename = File.basename(file)
          image = Image.find_or_initialize_by(name: basename, directory: directory)
          if image.image_file.valid?
            image.file_hash = image.image_file.file_hash
            image.image_hash = image.image_file.image_hash
            image.save
            image.image_file.tags.each do |label, value|
              tag = Tag.find_or_initialize_by(label: label, image: image)
              tag.value = value
              tag.save
            end
          end
        end
      end
    end
end
