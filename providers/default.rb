action :format do

  mount_point = new_resource.mount_point
  block_device = new_resource.block_device
  file_system = new_resource.file_system
  options = new_resource.options

  needs_formatting = needs_formatting(new_resource)
  mounted = mounted?(new_resource)

  mount "Mount Device #{block_device} to #{mount_point}" do
    action :nothing
    mount_point mount_point
    device block_device
    options options
  end

  execute "Format Device #{block_device} to #{file_system}" do
    action :nothing
    command "mkfs.#{file_system} #{block_device}"
    notifies :mount, "mount[Mount Device #{block_device} to #{mount_point}]", :immediately
    notifies :enable, "mount[Mount Device #{block_device} to #{mount_point}]", :immediately
  end

  mount "Unmount Block Device #{block_device}" do
    action :umount
    mount_point mount_point
    device block_device
    only_if { needs_formatting && mounted }
    notifies :run, "execute[Format Device #{block_device} to #{file_system}]", :immediately
  end 

  
end
