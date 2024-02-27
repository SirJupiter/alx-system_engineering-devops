#!/usr/bin/env ruby
input_string = ARGV[0]
final_string = input_string.scan(/School/).join
puts final_string

