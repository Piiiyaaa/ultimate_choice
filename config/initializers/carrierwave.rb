CarrierWave.configure do |config|
  if Rails.env.production?
    config.storage = :fog
    config.fog_credentials = {
      provider: 'AWS',
      aws_access_key_id: ENV['CLOUDFLARE_R2_ACCESS_KEY_ID'],
      aws_secret_access_key: ENV['CLOUDFLARE_R2_SECRET_ACCESS_KEY'],
      endpoint: "https://#{ENV['CLOUDFLARE_R2_ACCOUNT_ID']}.r2.cloudflarestorage.com",
      region: 'auto',
      path_style: true,
      aws_signature_version: 4,
      # 以下を追加
      host: "#{ENV['CLOUDFLARE_R2_ACCOUNT_ID']}.r2.cloudflarestorage.com",
      scheme: 'https'
    }
    config.fog_directory = ENV['CLOUDFLARE_R2_BUCKET']
    config.fog_public = true
    config.fog_attributes = { 
      'Cache-Control' => "public, max-age=#{365.days.to_i}",
      # 以下を追加
      'x-amz-acl' => 'public-read'
    }
    if ENV['CLOUDFLARE_R2_PUBLIC_URL'].present?
      config.asset_host = ENV['CLOUDFLARE_R2_PUBLIC_URL']
    end
  else
    config.storage = :file
  end

  # 以下を追加
  config.remove_previously_stored_files_after_update = false
end