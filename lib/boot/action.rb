module X
  module Action
    module ClassMethods
      def bash_completion(*args, &fn)
        if fn
          @bash_completion = fn
        elsif @bash_completion
          @bash_completion.call *args
        else
          []
        end
      end

      def description(value = nil)
        if value.nil?
          @description
        else
          @description = value
        end
      end

      def help(value = nil)
        if value.nil?
          @help
        else
          @help = value
        end
      end

      def keyword(value = nil)
        if value.nil?
          @keyword
        else
          @keyword = value
        end
      end
    end

    class << self
      def [](command)
        all.select { |x| x.keyword == command }.first
      end

      def all
        @all || []
      end

      def all_sorted
        all.sort_by &:keyword
      end

      def completion_for(args)
        command = args.shift || ""

        if args.empty?
          all.map(&:keyword).select do |keyword|
            keyword =~ /^#{Regexp.escape command}/
          end
        else
          action = X::Action[command]
          return [] unless action
          action.bash_completion(args) || []
        end
      end

      def included(other)
        other.extend X::Action::ClassMethods
        @all ||= []
        @all << other
      end

      def run(args)
        if args.empty?
          action = X::Help
        else
          command = args.shift
          action = X::Action[command]
        end

        unless action
          actions = all_sorted.map(&:keyword).join " "
          X::IO.error "Unknown action '#{command}'
Available actions are: #{actions}"
        end

        action.new.run args
      end
    end
  end
end
