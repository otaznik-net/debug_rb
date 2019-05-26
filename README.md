No puts debugging
=================


Integrated tracer
-----------------

No code change approach
```
# ruby -rtracer  trace_simple.rb

#0:/home_REMOVED_lib/rubygems/core_ext/kernel_require.rb:54:Kernel:<:       return gem_original_require(path)
#0:trace_simple.rb:1::-: def boo
#0:trace_simple.rb:4::-: boo
#0:trace_simple.rb:1:Object:>: def boo
#0:trace_simple.rb:2:Object:-:   puts "boo"
boo
#0:trace_simple.rb:3:Object:<: end

```

Added code - support block syntax

```
# ruby trace_add_tracer.rb

#0:trace_add_tracer.rb:7::-: Tracer.on { boo }
#0:trace_add_tracer.rb:3:Object:>: def boo
#0:trace_add_tracer.rb:4:Object:-:   puts "boo"
boo
#0:trace_add_tracer.rb:5:Object:<: end

--------------- 2nd trace ---------------
#0:trace_add_tracer.rb:11::-:   boo
#0:trace_add_tracer.rb:3:Object:>: def boo
#0:trace_add_tracer.rb:4:Object:-:   puts "boo"
boo
#0:trace_add_tracer.rb:5:Object:<: end
#0:trace_add_tracer.rb:12::-:   puts '8)'
8)
#0:trace_add_tracer.rb:13::-: Tracer.off
```


Figure out later
----------------
1. how comes `ruby -rtracer script_x.rb` behave different to `require 'tracer'` at the top the file
