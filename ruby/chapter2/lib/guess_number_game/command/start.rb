class GuessNumberGame::Command::Start < GuessNumberGame::Command::Command
  PROMPT = '> '

  def initialize(argv, stdin, stdout, stderr)
    super
    @game = GuessNumberGame::GuessNumber.new
  end

  def run
    puts PROMPT+'guss_my_number'
    puts @game.guess_my_number

    loop do
      print PROMPT
      cmd = @stdin.gets.chomp
      break if !cmd or cmd =~ /^exit$/

      begin
        result = @game.send(cmd)
      rescue NoMethodError
        result = "unknown command: #{cmd}"
      end
      puts result
    end
  end
end
