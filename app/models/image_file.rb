class ImageFile
  def initialize(filename)
    @filename = filename
  end

  def image
    if !@image
      @image = MiniMagick::Image.open(@filename)
    end
    @image
  end

  def exif
    if !@exif
      @exif = MiniExiftool.new @filename
    end
    @exif
  end

  def mime_type
    File.mime_type?(@filename)
  end

  def valid?
    File.readable?(@filename) && self.mime_type.start_with?('image/') && self.image.valid?
    rescue => e
      puts e.message
      return false
  end

  def file_hash
    Digest::MD5.hexdigest(File.read(@filename))
  end

  def image_hash
    self.image.signature
  end

  def tags
    self.exif.to_hash
  end
end
