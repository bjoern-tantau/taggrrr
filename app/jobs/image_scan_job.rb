class ImageScanJob < ActiveJob::Base
  queue_as :default

  def perform(image)
    image.image_file.tags.each do |label, value|
      tag = Tag.find_or_initialize_by(label: label, image: image)
      tag.value = value
      tag.save
    end
  end
end
