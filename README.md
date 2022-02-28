# CMS

Currently it has exactly one purpose:
 * Delivering some static files from a backend (currently S3 compatible only)

Use cases:

1. Want to user your authentification proxy
2. Use your own S3 compatible servers without static website feature

# Setup

Environment variables to set
 * AWS_ACCESS_KEY_ID - an AWS key id for the bucket
 * AWS_SECRET_ACCESS_KEY - an AWS secret for the bucket 
 * S3_BUCKET - to serve files from
 * APP_PORT - the port to run the server on
 
run the server:

```bin/run```



# Development

It's wrapped in Falcon so you should use async-xxxx packages like
async-postgres or async-redis if you want to connect to backend services.

We're using async-http-faraday to retrieve S3 files, unfortunately we can't
use aws-sdk any more (doesn't support faraday).





 

