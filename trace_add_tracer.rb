require 'tracer'

def boo
  puts "boo"
end

Tracer.on { boo }

separator = '-' * 15
puts "\n#{separator} 2nd trace #{separator}\n"

Tracer.on
  boo
  puts '8)'
Tracer.off
