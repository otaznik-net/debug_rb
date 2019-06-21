require 'tracer'

def boo(a)
  puts "boo"
end

Tracer.on { boo('t') }

separator = '-' * 15
puts "\n#{separator} 2nd trace #{separator}\n"

Tracer.on
  boo('t')
Tracer.off
