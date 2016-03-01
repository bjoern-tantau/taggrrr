class ImagesController < ApplicationController
  def index
    @params = params
    @filter_params = params.slice( :paths, :directories, :keywords ).symbolize_keys
    order = case @params[:order]
    when 'date.asc'
      'COALESCE(DateTimeOriginal.value, FileModifyDate.value) ASC'
    else
      'COALESCE(DateTimeOriginal.value, FileModifyDate.value) DESC'
    end
    @images = Image
      .includes(:path)
      .joins("LEFT JOIN tags AS FileModifyDate ON FileModifyDate.image_id = images.id AND FileModifyDate.label = 'FileModifyDate'")
      .joins("LEFT JOIN tags AS DateTimeOriginal ON DateTimeOriginal.image_id = images.id AND DateTimeOriginal.label = 'DateTimeOriginal'")
      .where(@filter_params)
      .order(order)
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
