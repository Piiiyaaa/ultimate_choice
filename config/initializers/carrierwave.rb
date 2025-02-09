CarrierWave.configure do |config|
  if Rails.env.production?
    config.storage = :fog
    config.fog_provider = 'fog/aws'  # 明示的に指定
    config.fog_credentials = {
      provider: 'AWS',
      aws_access_key_id: ENV['CLOUDFLARE_R2_ACCESS_KEY_ID'],
      aws_secret_access_key: ENV['CLOUDFLARE_R2_SECRET_ACCESS_KEY'],
      endpoint: "https://#{ENV['CLOUDFLARE_R2_ACCOUNT_ID']}.r2.cloudflarestorage.com",
      path_style: true,
      aws_signature_version: 4,
      host: "#{ENV['CLOUDFLARE_R2_ACCOUNT_ID']}.r2.cloudflarestorage.com",
      scheme: 'https',
      debug_response: true  # デバッグ情報を追加
    }
    
    config.fog_directory = ENV['CLOUDFLARE_R2_BUCKET']
    config.fog_public = true
    config.fog_attributes = { 
      'Cache-Control' => "public, max-age=#{365.days.to_i}",
      'x-amz-acl' => 'public-read'
    }

    if ENV['CLOUDFLARE_R2_PUBLIC_URL'].present?
      config.asset_host = ENV['CLOUDFLARE_R2_PUBLIC_URL'].chomp('/')  # 末尾のスラッシュを削除
    end

    # デバッグ用ログ出力
    Rails.logger.info "CarrierWave R2 Configuration:"
    Rails.logger.info "Storage: #{config.storage}"
    Rails.logger.info "Provider: #{config.fog_provider}"
    Rails.logger.info "Endpoint: #{config.fog_credentials[:endpoint]}"
    Rails.logger.info "Public URL: #{config.asset_host}"
  else
    config.storage = :file
  end

  config.remove_previously_stored_files_after_update = false
end