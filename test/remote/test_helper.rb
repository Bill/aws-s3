require 'test/unit'
require 'uri'
$:.unshift File.dirname(__FILE__) + '/../../lib'
require 'aws/s3'
begin
  require_library_or_gem 'breakpoint'
rescue LoadError
end

# Set this (temporarily) to a bucket that you control. Also set AMAZON_ACCESS_KEY_ID, AMAZON_SECRET_ACCESS_KEY in your environment
# Change it back to aws-s3-tests before committing your changes.
TEST_BUCKET = 'aws-s3-tests'

# Set this (temporarily) to a Virtual Hosting domain ( =  bucket name ) that you control, and for which you have an appropraite
# CNAME mapping. e.g. if you want to simulate hosting at images.mydomain.com then you set the TEST_VIRTUAL_HOSTING_BUCKET to 
# 'images.mydomain.com' and you create a CNAME mapping on the mydomain.com domain from "images" to
# "images.mydomain.com.s3.amazonaws.com."
# Notice that final dot! More information at http://docs.amazonwebservices.com/AmazonS3/2006-03-01/index.html?VirtualHosting.html
TEST_VIRTUAL_HOSTING_BUCKET = 'images.mydomain.com'

TEST_FILE   = File.dirname(__FILE__) + '/test_file.data'

class Test::Unit::TestCase
  include AWS::S3
  def establish_real_connection
    Base.establish_connection!(
      :access_key_id     => ENV['AMAZON_ACCESS_KEY_ID'], 
      :secret_access_key => ENV['AMAZON_SECRET_ACCESS_KEY']
    )
  end
  
  def disconnect!
    Base.disconnect
  end
  
  class TestBucket < Bucket
    set_current_bucket_to TEST_BUCKET
  end
  
  class TestS3Object < S3Object
    set_current_bucket_to TEST_BUCKET
  end
end