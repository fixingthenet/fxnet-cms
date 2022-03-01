class CmsController < ApplicationController
  def get
    s3_client=AsyncS3Client.new(
      access_key_id:  ENV['AWS_ACCESS_KEY_ID'],
      secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'],
      region: 'eu-west-1'
    )

    response.headers["rack.hijack"] = lambda do |stream|
      s3_client.get_object( bucket: ENV["S3_BUCKET"], key: "/#{params[:path]}.#{params[:format]}") do |resp, chunk|
        if chunk == :done
          stream.close
          #logger.debug("CMS: Done, #{stream.class}")
        else
          #logger.debug("CMS: Chunk #{chunk.bytesize}")
          stream.write(chunk)
        end
      end
    end

    response.headers.delete("Content-Length")
    response.headers["X-Accel-Buffering"] = "no"
    response.headers["Content-Type"] = Mime::Type.lookup_by_extension(params[:format] || 'txt')
    head :ok
  end
end
