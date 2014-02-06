module X
  module Formatting
    def wrap
      # TODO: Wrap for 80 lines
      self
    end
  end
end

class String
  include X::Formatting
end
