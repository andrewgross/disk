require 'chef'

module Disk
  module Helpers

    include Chef::Mixin::ShellOut

    def _run_command(command)
      return %x[#{command}]
    end

    def needs_formatting(nr)
      return drive_empty(nr) && wrong_fs(nr)
    end

    def mounted?(nr)
      command = "mount -l | grep #{nr.block_device}"
      result = _run_command(command)
      return ! result.empty?
    end

    def drive_empty(nr)
      command = "ls -A #{nr.mount_point} | grep -v lost+found | wc -l"
      result = _run_command(command)
      Chef::Log.debug("Drive Contains how many files? #{result}")
      if result.to_i > 0
        r = false
      else
        r = true
      end
      Chef::Log.debug("Empty Drive? #{r}")
      r
    end

    def wrong_fs(nr)
      command = "df -T | grep #{nr.block_device} | awk '{print $2}'"
      result = _run_command(command)
      r = result.chomp != nr.file_system
      Chef::Log.debug("Wrong FS? #{r}")
      r
    end

  end
end

self.class.send(:include, Disk::Helpers)
