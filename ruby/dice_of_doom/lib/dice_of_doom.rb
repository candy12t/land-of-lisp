module DiceOfDoom; end

Dir.glob(File.expand_path('dice_of_doom/**/*.rb', __dir__)).each do |mod_name|
  require "#{mod_name}"
end
