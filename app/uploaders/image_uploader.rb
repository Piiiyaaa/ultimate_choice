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
  end

  # 本番環境でのURL生成（必要な場合）
  def url
    if Rails.env.production? && path.present?
      "#{ENV['CLOUDFLARE_R2_PUBLIC_URL']}/#{path}"
    else
      super
    end
  end
end