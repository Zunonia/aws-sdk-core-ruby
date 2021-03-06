require 'cgi'

module Aws
  # @api private
  module Util

    # @param [String] string
    # @return [String] Returns the underscored version of the given string.
    def underscore(string)
      inflector = Hash.new do |hash, key|
        key.
          gsub(/([A-Z0-9]+)([A-Z][a-z])/, '\1_\2'). # split acronyms
          scan(/[a-z]+|\d+|[A-Z0-9]+[a-z]*/).       # split words
          join('_').downcase                        # join parts
      end

      # add a few irregular inflections
      inflector['ETag'] = 'etag'
      inflector['s3Bucket'] = 's3_bucket'
      inflector['s3Key'] = 's3_key'
      inflector['Ec2KeyName'] = 'ec2_key_name'
      inflector['Ec2SubnetId'] = 'ec2_subnet_id'
      inflector['Ec2VolumeId'] = 'ec2_volume_id'
      inflector['Ec2InstanceId'] = 'ec2_instance_id'
      inflector['ElastiCache'] = 'elasticache'
      inflector['NotificationARNs'] = 'notification_arns'

      inflector[string]
    end
    module_function :underscore

    def uri_escape(string)
      CGI::escape(string.encode('UTF-8')).gsub('+', '%20').gsub('%7E', '~')
    end
    module_function :uri_escape

  end
end
