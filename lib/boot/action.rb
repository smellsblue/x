module X
  module Action
    module ClassMethods
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
