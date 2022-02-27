class CmsController < ApplicationController
  include ActionController::Live
  
  def get
    headers=nil
    S3_CLIENT.get_object( bucket: 'metoda-assets', key: request.env['REQUEST_PATH']) do |resp, chunk|
      unless headers
        headers=resp.headers.to_h
        logger.debug("Chunk received: #{headers}\n#{chunk.size}\n#{response.headers}\n#{chunk}\n")
        response.headers["Content-Type"] = headers["content-type"]
        response.headers.delete("Content-Length")
        response.headers["Cache-Control"] = "no-cache"
      end
      response.stream.write(chunk)
    end
    logger.debug("Done")
    response.stream.close
  end
end