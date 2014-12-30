module X
  class Exec
    class << self
      def [](command, options = {})
        X::Exec.exec command, options
      end

      def exec(command, options = {})
        if options[:dir]
          command = "cd '#{File.expand_path options[:dir]}' && #{command}"
        end

        if options[:capture]
          result = %x[#{command}]
        else
          result = Kernel.system command
        end

        success = $?.success?

        unless success
          X::IO.error "The command '#{command}' returned an error code."
        end

        result
      end
    end
  end
end
