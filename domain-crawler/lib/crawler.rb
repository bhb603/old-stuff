require_relative 'crawler/crawler.rb'

if __FILE__ == $PROGRAM_NAME
  c = Crawler.new(ARGV[0])
  c.go
end
