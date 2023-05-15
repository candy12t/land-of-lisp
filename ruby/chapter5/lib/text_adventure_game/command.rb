class TextAdventureGame::Command
  PROMPT = '> '

  def initialize(argv, stdin=$stdin, stdout=$stdout, stderr=$stderr)
    @argv   = argv
    @stdin  = stdin
    @stdout = stdout
    @stderr = stderr

    world = TextAdventureGame::World.new
    @player = TextAdventureGame::Player.new(world, 'living_room')
  end

  def self.run(argv)
    new(argv).run
  end

  def run
    @stdout.puts PROMPT+'look'
    @stdout.puts @player.look

    loop do
      @stdout.print PROMPT
      cmd = @stdin.gets.chomp
      break if !cmd or cmd =~ /^exit$/
      function, *args = cmd.split(' ')

      begin
        if @player.respond_to?(function)
          @stdout.puts @player.send(function, *args)
        else
          @stderr.puts "unknown command: #{function}"
        end
      rescue ArgumentError
        @stderr.puts "invalid command argument: #{function}, #{args}"
      end
    end
  end
end
