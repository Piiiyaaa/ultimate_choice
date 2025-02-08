CarrierWave.configure do |config|
    if Rails.env.production?
      config.storage = :fog
      config.fog_credentials = {
        provider: 'AWS',
        aws_access_key_id: ENV['CLOUDFLARE_R2_ACCESS_KEY_ID'],
        aws_secret_access_key: ENV['CLOUDFLARE_R2_SECRET_ACCESS_KEY'],
        endpoint: "https://#{ENV['CLOUDFLARE_R2_ACCOUNT_ID']}.r2.cloudflarestorage.com",
        region: 'auto'
      }
      config.fog_directory = ENV['CLOUDFLARE_R2_BUCKET']
      config.fog_public = true
    else
      config.storage = :file
    end
  end