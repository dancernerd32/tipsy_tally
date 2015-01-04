# CarrierWave.configure do |config|
#   config.fog_credentials = {
#     provider:               'AWS',
#     aws_access_key_id:      ENV['S3_KEY'],
#     aws_secret_access_key:  ENV['S3_SECRET'],
#   }
#
#   # For testing, upload files to local `tmp` folder.
#
#
#   config.cache_dir        = "#{Rails.root}/tmp/uploads" # To let CarrierWave work on Heroku
#   config.fog_directory    = ENV['tipsy-tally']
# end

CarrierWave.configure do |config|
  if Rails.env.test? || Rails.env.cucumber?
        config.storage           = :file
        config.enable_processing = false
        config.root              = "#{Rails.root}/tmp"
      else
        config.storage = :fog
      end
  config.fog_credentials = {
    :provider               => 'AWS',
    :aws_access_key_id      => ENV['S3_KEY'],
    :aws_secret_access_key  => ENV['S3_SECRET'],
    :region                 => ENV['S3_REGION'] # Change this for different AWS region. Default is 'us-east-1'
  }
  config.fog_directory  = ENV['S3_BUCKET']
end
