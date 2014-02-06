module X
  class IO
    class << self
      def error(msg = "")
        STDERR.puts msg.wrap
        exit false
      end
    end
  end
end
