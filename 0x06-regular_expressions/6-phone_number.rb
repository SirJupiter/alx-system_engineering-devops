#!/usr/bin/env ruby
input_string = ARGV[0]
final_string = input_string.scan(/^[0-9]{10}$/).join
puts final_string

