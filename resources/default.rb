# Company: Yipit.com
# Author: Andrew Gross
actions :format

default_action :format

attribute :mount_point, :kind_of => String, :required => true, :name_attribute => true
attribute :block_device, :kind_of => String, :required => true
attribute :file_system, :kind_of => String, :default => 'ext4', :required => true
attribute :options, :kind_of => String
