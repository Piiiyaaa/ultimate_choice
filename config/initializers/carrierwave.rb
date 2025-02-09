CarrierWave.configure do |config|
  if Rails.env.production?
    config.storage = :fog
    config.fog_provider = 'fog/aws'
    
    config.fog_credentials = {
      provider: 'AWS',
      aws_access_key_id: ENV['CLOUDFLARE_R2_ACCESS_KEY_ID'],
      aws_secret_access_key: ENV['CLOUDFLARE_R2_SECRET_ACCESS_KEY'],
      endpoint: "https://#{ENV['CLOUDFLARE_R2_ACCOUNT_ID']}.r2.cloudflarestorage.com",
      aws_signature_version: 4,
      path_style: true
    }
    
    config.fog_directory = ENV['CLOUDFLARE_R2_BUCKET']
    config.fog_public = true
    config.asset_host = ENV['CLOUDFLARE_R2_PUBLIC_URL'].presence&.chomp('/')
  end
end