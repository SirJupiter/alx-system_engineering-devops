#!/usr/bin/env ruby
input_string = ARGV[0]
final_string = input_string.scan(/[A-Z]/).join
puts final_string

