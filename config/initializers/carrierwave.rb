CarrierWave.configure do |config|
  if Rails.env.production?
    config.storage = :fog
    config.fog_provider = 'fog/aws'
    
    # 認証情報を設定
    config.fog_credentials = {
      provider: 'AWS',
      aws_access_key_id: ENV['CLOUDFLARE_R2_ACCESS_KEY_ID'],
      aws_secret_access_key: ENV['CLOUDFLARE_R2_SECRET_ACCESS_KEY'],
      endpoint: "https://#{ENV['CLOUDFLARE_R2_ACCOUNT_ID']}.r2.cloudflarestorage.com",
      path_style: true,
      aws_signature_version: 4,
      host: "#{ENV['CLOUDFLARE_R2_ACCOUNT_ID']}.r2.cloudflarestorage.com",
      scheme: 'https',
      debug_response: true
    }
    
    config.fog_directory = ENV['CLOUDFLARE_R2_BUCKET']
    config.fog_public = true
    config.fog_attributes = { 'Cache-Control' => 'max-age=31536000' }
    
    # デバッグ情報を出力
    Rails.logger.info "=== CarrierWave Configuration ==="
    Rails.logger.info "Storage: #{config.storage}"
    Rails.logger.info "Provider: #{config.fog_provider}"
    Rails.logger.info "Bucket: #{config.fog_directory}"
    Rails.logger.info "Endpoint: #{config.fog_credentials[:endpoint]}"
  end
end