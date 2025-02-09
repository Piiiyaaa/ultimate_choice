class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  # 環境に応じてストレージを切り替え
  if Rails.env.production?
    storage :fog
  else
    storage :file
  end

  # アップロードファイルの保存先ディレクトリ
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # 許可する画像の拡張子
  def extension_allowlist
    %w(jpg jpeg gif png)
  end

  # デフォルト画像
  def default_url
    "/images/" + [version_name, "default.png"].compact.join('_')
  end

  # サムネイルの生成
  version :thumb do
    process resize_to_fit: [400, 300]
    
    # サムネイルのファイル名を明示的に指定
    def full_filename(for_file)
      "thumb_#{for_file}"
    end
  end

  # 本番環境でのURL生成
  def url
    if Rails.env.production?
      base_url = ENV['CLOUDFLARE_R2_PUBLIC_URL'].to_s.chomp('/')
      "#{base_url}#{super}"
    else
      super
    end
  end

  # アップロード処理のデバッグ
  def store!(file)
    Rails.logger.info "=== Starting file upload ==="
    Rails.logger.info "Storage: #{self.class.storage}"
    Rails.logger.info "File details:"
    Rails.logger.info "  - Original filename: #{file.original_filename}"
    Rails.logger.info "  - Content type: #{file.content_type}"
    Rails.logger.info "  - Size: #{file.size} bytes"
    Rails.logger.info "  - Path: #{store_dir}"
    
    begin
      super
    rescue => e
      Rails.logger.error "Upload Error: #{e.message}"
      Rails.logger.error e.backtrace.join("\n")
      raise
    end

    Rails.logger.info "=== Upload completed ==="
    Rails.logger.info "  - Stored path: #{path}"
    Rails.logger.info "  - Public URL: #{url}"
  end
end