require 'mini_magick'
require 'yaml'

class PhotoTool

  def initialize(source_dir, target_dir, width)
    @source_dir = source_dir

    Dir.mkdir(target_dir,0755) unless Dir.exists?(target_dir)
    @target_dir = target_dir
    @width = width
  end

  def resize_all
    imgs =  Dir[@source_dir]

    imgs.each do |img|
      resize_photo(img,@target_dir)
    end
  end

  def resize_photo source, target
    img = MiniMagick::Image.open source
    img.resize "#{@width}x"
    new_file =  File.basename source
    new_file =  "#{target}/#{new_file}"
    img.write new_file
  end
end  

app_config = YAML.load(File.open('app.yml'))

tool = PhotoTool.new app_config['source_dir'], app_config['target_dir'], app_config['width']
tool.resize_all

p 'photo.resize.ok'