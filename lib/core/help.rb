module X
  class Help
    include X::Action
    keyword "help"
    description "Provide detailed help"
    help "Get help either on a specific action, or even drilled in to a topic for a particular action.

Example usage:

#{"x help".yellow.bold}
#{"x help my_command".yellow.bold}
#{"x help my_command sub_topic".yellow.bold}"

    bash_completion do |args|
      if args.length <= 1
        word = args.first || ""

        Action.all.map(&:keyword).select do |keyword|
          keyword =~ /^#{Regexp.escape word}/
        end
      end
    end

    def described_actions
      X::Action.all_sorted.map do |x|
        [x.keyword, x.description]
      end.tableize :indent => "  "
    end

    def general_help
      X::IO.puts "Welcome to X!

You can run #{"x help <action>".yellow.bold} to obtain detailed help on any given action.

The following are the available actions:
#{described_actions}"
    end

    def action_help(keyword)
      action = X::Action[keyword]
      X::IO.error "#{keyword.yellow.bold} is not a valid action!" unless action
      X::IO.puts keyword

      if action.description && !action.description.empty?
        X::IO.puts ""
        X::IO.puts action.description
      end

      if action.help && !action.help.empty?
        X::IO.puts ""
        X::IO.puts action.help
      end
    end

    def run(args)
      if args.empty?
        general_help
      elsif args.size == 1
        action_help args.first
      else
        # TODO
      end
    end
  end
end
