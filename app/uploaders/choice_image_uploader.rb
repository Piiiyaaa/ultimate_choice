class ChoiceImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  
  storage :fog if Rails.env.production?

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def default_url
    "no_image.png"
  end

  def extension_allowlist
    %w(jpg jpeg gif png)
  end

  version :thumb do
    process resize_to_fit: [400, 300]
    
    def full_filename(for_file)
      "thumb_#{for_file}"
    end
  end
end