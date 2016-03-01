class ImagesController < ApplicationController
  def index
    @filter_params = params.slice( :paths, :directories, :keywords ).symbolize_keys
    @images = Image
      .includes(:path)
      .where(@filter_params)
      .page(params[:page])
    @paths = Path.all
  end

  def show
    @image = Image.find(params[:id])
  end

  def output
    @image = Image.find(params[:id])
    send_file @image.full_path, type: @image.image_file.mime_type, disposition: 'inline'
  end

  def thumbnail
    @image = Image.find(params[:id])
    size = '115x115'
    dir = File.join('tmp', 'cache', 'images')
    Dir.mkdir dir unless File.exists? dir
    filename = File.join(dir, @image.file_hash + size + @image.name)
    if !File.readable?(filename)
      thumb = @image.image_file.image
      thumb.combine_options do |i|
        i.resize(size + '^')
        i.gravity('center')
        i.crop(size + '+0+0')
      end
      thumb.write filename
    end
    send_file filename, type: @image.image_file.mime_type, disposition: 'inline'
  end
end
