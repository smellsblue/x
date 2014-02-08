module X
  module Colorize
    FOREGROUND_COLORS = {
      :black  => "\e[30m",
      :red    => "\e[31m",
      :green  => "\e[32m",
      :yellow => "\e[33m",
      :blue   => "\e[34m",
      :purple => "\e[35m",
      :cyan   => "\e[36m",
      :white  => "\e[37m"
    }

    BACKGROUND_COLORS = {
      :black  => "\e[40m",
      :red    => "\e[41m",
      :green  => "\e[42m",
      :yellow => "\e[43m",
      :blue   => "\e[44m",
      :purple => "\e[45m",
      :cyan   => "\e[46m",
      :white  => "\e[47m"
    }

    COLOR_STYLES = {
      :bold => {
        true  => "\e[1m",
        false => "\e[22m"
      },

      :blink => {
        true  => "\e[5m",
        false => "\e[25m"
      },

      :reverse => {
        true  => "\e[7m",
        false => "\e[27m"
      },

      :reset => "\e[0m"
    }

    def colorize(options)
      fg = FOREGROUND_COLORS[options[:fg]]
      bg = BACKGROUND_COLORS[options[:bg]]
      reset = COLOR_STYLES[:reset]
      bold = COLOR_STYLES[:bold][!!options[:bold]] if options.include? :bold
      blink = COLOR_STYLES[:blink][!!options[:blink]] if options.include? :blink
      reverse = COLOR_STYLES[:reverse][!!options[:reverse]] if options.include? :reverse
      style = "#{bold}#{blink}#{reverse}"
      "#{fg}#{bg}#{style}#{self}#{reset}"
    end

    def black
      colorize :fg => :black
    end

    def red
      colorize :fg => :red
    end

    def green
      colorize :fg => :green
    end

    def yellow
      colorize :fg => :yellow
    end

    def blue
      colorize :fg => :blue
    end

    def purple
      colorize :fg => :purple
    end

    def cyan
      colorize :fg => :cyan
    end

    def white
      colorize :fg => :white
    end

    def bold
      colorize :bold => true
    end

    def blink
      colorize :blink => true
    end

    def reverse
      colorize :reverse => true
    end
  end

  module Formatting
    module Array
      def tableize(options = {})
        indent = options[:indent] || ""

        map do |row|
          if row.kind_of? Enumerable
            # TODO: align and account for wrapping
            "#{indent}#{row.join("  ").sub /\s+$/, ""}"
          else
            "#{indent}#{row}"
          end
        end.join "\n"
      end
    end

    module String
      def wrap
        # TODO: Wrap for 80 lines
        self
      end
    end
  end
end

class Array
  include X::Formatting::Array
end

class String
  include X::Colorize
  include X::Formatting::String
end
