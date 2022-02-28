require 'async/http/internet'

class AsyncS3Client

  def initialize(access_key_id:, secret_access_key:, region:)
    @access_key_id=access_key_id
    @secret_access_key=secret_access_key
    @region=region
  end


  def get_object(bucket:, key:)
    raise "need block" unless block_given?
    internet = Async::HTTP::Internet.new
    host="#{bucket}.s3.#{@region}.amazonaws.com"
    signer = Aws::Sigv4::Signer.new(
      service: 's3',
      region: @region,
      access_key_id: @access_key_id,
      secret_access_key: @secret_access_key,
      unsigned_headers: ["content-length"]
    )

    signature = signer.sign_request(
      http_method: 'GET',
      url: "https://#{host}#{key}",
      headers: {},
    )

    headers=signature.headers
    headers["user-agent"]="Fxnet CMS client"
    headers.delete('host') # without this you'll get two host entries!

    Async do
      begin
        response = internet.get("https://#{host}#{key}", headers)
        response.each do |chunk|
            yield response, chunk
        end
        yield response, :done
      rescue
        logger.error("Error: #{$!}")
      ensure
       logger.info("Closing: #{host}#{key}")
       internet.close
      end
    end

  end

  def logger
    Rails.logger
  end
end
