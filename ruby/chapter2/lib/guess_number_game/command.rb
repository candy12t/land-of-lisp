class GuessNumberGame::Command
  # autoload :Command, 'guess_number_game/command/command'
  # autoload :UnknownCommand, 'guess_number_game/command/unknown_command'
  # autoload :Root,    'guess_number_game/command/root'
  # autoload :Start,   'guess_number_game/command/start'

  # def self.run(argv)
  #   GuessNumberGame::Command::Root.run(argv)
  # end
  PROMPT = '> '

  def initialize(argv, stdin=$stdin, stdout=$stdout, stderr=$stderr)
    @argv   = argv
    @stdin  = stdin
    @stdout = stdout
    @stderr = stderr

    @game = GuessNumberGame::GuessNumber.new
  end

  def self.run(argv)
    new(argv).run
  end

  def run
    @stdout.puts PROMPT+'guss_my_number'
    @stdout.puts @game.guess_my_number

    loop do
      @stdout.print PROMPT
      cmd = @stdin.gets.chomp
      break if !cmd or cmd =~ /^exit$/

      if @game.respond_to?(cmd)
        @stdout.puts @game.send(cmd)
      else
        @stderr.puts "unknown command: #{cmd}"
      end
    end
  end
end
