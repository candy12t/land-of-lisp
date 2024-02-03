class GuessNumberGame::Command::UnknownCommand < StandardError
  def initialize(command)
    super
    @command = command
  end

  def message
    "unknown command: #{@command}"
  end
end
