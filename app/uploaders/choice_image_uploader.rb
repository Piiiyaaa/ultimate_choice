class ChoiceImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  version :thumb do
    process resize_to_fit: [300, 200]  # 横幅300px、高さ200pxに調整
  end

  storage :file

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
  end
end