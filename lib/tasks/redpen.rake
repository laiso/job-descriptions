require 'redpen_ruby'

DEFAULT_LANG = 'en'
PROJECT_MARKDOWNS = %w(README.md)

task :redpen do
  error = false

  (Dir.glob('*.md') - PROJECT_MARKDOWNS).each do |target_file|
    match = /\.(?<lang>\w+)\.md$/.match(target_file)
    lang = match ? match[:lang] : DEFAULT_LANG
    config_file = "./config/redpen/#{lang}.xml"
    redpen = RedpenRuby.check(config_file, target_file)
    unless redpen.valid?
      redpen.messages.each do |message|
        puts message
      end
      error = true
    end
  end

  exit 1 if error
end
