module X
  class BashCompletion
    include X::Action
    keyword "bash_completion"

    def run(args)
      args.shift
      puts X::Action.completion_for(args).sort.join(" ")
    end
  end
end
