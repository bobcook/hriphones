task :console do
  require 'irb'
  require 'irb/completion'
  require 'telephony' # You know what to do.
  ARGV.clear
  IRB.start
end