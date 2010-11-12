#!/usr/bin/ruby

require 'rubygems'
require 'aws/s3'

  AWS::S3::Base.establish_connection!(
    :access_key_id     => '1VDJRW8X3J4A7SNFG602',
    :secret_access_key => 'QLX9bYsM1+PRXCxeJHcW6nwU5yC2RjCTZDTYicM2'
  )
  
  dir = File.dirname(__FILE__)
  
  haml = "justin_thibault_resume.haml"
  html = "justin_thibault_resume.html"
  
  bucket = "ttt"
  
  input = File.join(dir, haml)
  output = File.join(dir, html)
  
  url = "http://s3.amazonaws.com/#{bucket}/#{html}"
  sub_url = "http://#{bucket}.s3.amazonaws.com/#{html}"
  
  system "haml #{input} > #{output}"
  
  AWS::S3::S3Object.delete html, bucket


  r = AWS::S3::S3Object.store(
    html, 
    open(output), 
    bucket,
    :access => :public_read
  )
  
  puts sub_url

