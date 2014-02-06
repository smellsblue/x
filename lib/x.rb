module X
  class << self
    def require_dir(path)
      Dir[File.join(path, "*.rb")].each do |file|
        require file
      end
    end
  end
end

X.require_dir File.expand_path("../boot", __FILE__)
X.require_dir File.expand_path("../core", __FILE__)
X::Config.require!
X::Action.run ARGV
