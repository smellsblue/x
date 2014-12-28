module X
  class BashCompletion
    include X::Action
    keyword "bash_completion"
    description "Utility for providing bash completion of actions"
    help "This is not intended to be invoked directly.

When you use tab completion, this action will provide bash with the completion options.

To provide custom bash completions for an action, simply specify it with bash_completion like so:

#{"class".yellow} #{"MyAction".cyan}
  #{"include".white} #{"X".cyan}#{"::".white}#{"Action".cyan}

  #{"bash_completion".white} #{"do".yellow} #{"|args|".white}
    #{"# return the possible words for bash completion.".blue}
    #{"[".white}#{'"word_1"'.green}#{",".white} #{'"word_2"'.green}#{"]".white}
  #{"end".yellow}

  #{"def".yellow} #{"run".cyan}#{"(args)".white}
  #{"end".yellow}
#{"end".yellow}"

    def run(args)
      args.shift
      puts X::Action.completion_for(args).sort.join(" ")
    end
  end
end
