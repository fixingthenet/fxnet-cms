require 'async_s3_client'


S3_CLIENT=AsyncS3Client.new(
  access_key_id:  ENV['AWS_ACCESS_KEY_ID'],
  secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'],
  region: 'eu-west-1'
)


