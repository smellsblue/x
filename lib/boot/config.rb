require "yaml"

module X
  class Config
    PATH = File.expand_path "~/.x"

    class << self
      def [](key)
        load[key]
      end

      def require!
        if self[:requires]
          self[:requires].each do |path|
            X.require_dir path
          end
        end
      end

      private

      def load
        return @config if @config

        if File.exists? X::Config::PATH
          @config = YAML.load File.read(X::Config::PATH)
        else
          @config = {}
          File.write X::Config::PATH, YAML.dump(@config)
        end

        @config
      end
    end
  end
end
