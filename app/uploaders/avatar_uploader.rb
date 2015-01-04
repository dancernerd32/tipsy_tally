# encoding: utf-8
class AvatarUploader < CarrierWave::Uploader::Base
  def default_url
    "https://s3-us-west-2.amazonaws.com/tipsy-tally/default.jpg"
  end
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

end
