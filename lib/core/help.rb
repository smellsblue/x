module X
  class Help
    include X::Action
    keyword "help"

    def described_actions
      X::Action.all_sorted.map do |x|
        [x.keyword, x.description]
      end.tableize :indent => "  "
    end

    def general_help
      X::IO.puts "Welcome to X!

You can run #{"x help <action>".white.bold} to obtain detailed help on any given action.

The following are the available actions:
#{described_actions}"
    end

    def run(args)
      if args.empty?
        general_help
      end
    end
  end
end
