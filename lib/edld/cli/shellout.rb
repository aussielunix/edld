#!/usr/bin/env ruby

module Edld
  module Shellout
    # Public: A mixin to exectue shell commands caputuring stdout stderr and exit code
    # 
    #
    # *args - shell command to run
    #
    # Examples
    #
    # systemr("git remote update -p")
    # stdout, stderr = systemr("git --no-pager log ..@{u} --oneline")
    #
    # Returns stdout & stderr
    def systemr(*args)
      Edld::Log.debug("Running command: #{args}")
      command = Mixlib::ShellOut.new(*args)
      command.run_command
      status = command.status
      stdout = command.stdout
      stderr = command.stderr
      unless status.success?
        Edld::Log.fatal("Command #{cmd} failed with status code #{status.exitstatus}")
        Edld::Log.fatal("---STDOUT---")
        Edld::Log.fatal(stdout)
        Edld::Log.fatal("---STDERR---")
        Edld::Log.fatal(stderr)
        raise RuntimeError, "Command #{cmd} failed with status code #{status.exitstatus}"
      end
      Edld::Log.debug("---STDOUT---")
      Edld::Log.debug(stdout)
      Edld::Log.debug("------------")
      Edld::Log.debug("---STDERR---")
      Edld::Log.debug(stderr)
      Edld::Log.debug("------------")
      return stdout, stderr
    end
  end
end
