class GuessNumberGame::Command::Root < GuessNumberGame::Command::Command
  def self.run(argv)
    new(argv).run
  end

  def run
    if @argv.empty?
      @stdout.puts 'help!'
      exit 1
    end

    if @argv.first == '-h' or @argv.first == '--help'
      @stdout.puts 'help!'
      return
    end

    if @argv.first == '-v' or @argv.first == '--version'
      @stdout.puts GuessNumberGame::VERSION
      return
    end

    command = build_command(@argv.first, @argv[1..])
    command.run
  rescue GuessNumberGame::Command::UnknownCommand => e
    @stderr.puts e.message
    exit 1
  end

  def build_command(name, options)
    case name
    when 'start'
      GuessNumberGame::Command::Start.new(options, @stdin, @stdout, @stderr)
    else
      raise GuessNumberGame::Command::UnknownCommand.new(name)
    end
  end
end
