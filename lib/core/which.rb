module X
  class Which
    include X::Action
    keyword "which"
    description "Locate the source of one of the X actions"
    help "Find the source of one of the actions available to X.

Example usage:

#{"x which help".yellow.bold}"

    bash_completion do |args|
      if args.length <= 1
        word = args.first || ""

        Action.all.map(&:keyword).select do |keyword|
          keyword =~ /^#{Regexp.escape word}/
        end
      end
    end

    def run(args)
      if args.empty? || args.size > 1
        X::IO.error "usage: x which <command>"
      end

      action = X::Action[args.first]

      unless action
        X::IO.error "Unknown action '#{args.first}'"
      end

      X::IO.puts action.instance_method(:run).source_location.first
    end
  end
end
