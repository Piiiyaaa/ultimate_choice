class ChoiceImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  
  storage :fog if Rails.env.production?  # 本番環境ではFog（Cloudflare R2）を使う

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

  def url
    if Rails.env.production?
      base_url = ENV['CLOUDFLARE_R2_PUBLIC_URL'].to_s.chomp('/')
      "#{base_url}#{super}"
    else
      super
    end
  end
end
