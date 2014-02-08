module X
  class IO
    class << self
      def puts(msg = "")
        STDOUT.puts msg.wrap
      end

      def print(msg)
        STDOUT.print msg.wrap
      end

      def error(msg = "")
        STDERR.puts msg.wrap
        exit false
      end
    end
  end
end
