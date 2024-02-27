#!/usr/bin/env ruby
input_string = ARGV[0]
final_string = input_string.scan(/^hbt{1,5}n$/)
puts final_string

