#!/usr/bin/env ruby
log_content = ARGV[0]

sender = log_content[/from:([^\]]+)/, 1]
receiver = log_content[/to:([^\]]+)/, 1]
flags = log_content[/flags:([^\]]+)/, 1]

output = "#{sender},#{receiver},#{flags}"
puts output

