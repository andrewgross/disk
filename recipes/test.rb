disk "Remount Ephemeral Disk" do
  action :format
  mount_point "/mnt"
  block_device "/dev/xvdb"
  file_system "ext4"
end
