class GuessNumberGame::Command::Command
  def initialize(argv, stdin=$stdin, stdout=$stdout, stderr=$stderr)
    @argv   = argv
    @stdin  = stdin
    @stdout = stdout
    @stderr = stderr
  end
end
