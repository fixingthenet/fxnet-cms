# CMS

Currently it has exactly one purpose:
 * Delivering some static files from a backend (currently S3 compatible only)

Why not use S3 static website?

1. You could add authentification server with this in front of it 
2. Use S3 compatible servers without static website feature

# Setup

Environment variables to set
 * AWS_ID, AWS_SECRET
 * AWS_S3_BUCKET_NAME
 * AWS_S3_PREFIX (optional)
 
 


# Development

It's wrapped in Falcon so you should use async-xxxx packages like
async-postgres or async-redis if you want to connect to backend services.

We're using async-http-faraday to retrieve S3 files, unfortunately we can't
use aws-sdk any more (doesn't support faraday).





 

