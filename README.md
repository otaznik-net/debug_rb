No puts debugging
=================

puts/p
------
Just being slightly more verbose. `p` is a good reason to avoid 
[puts x.inspect](https://ruby-doc.org/core-2.4.0/Kernel.html#method-i-p)

Might improve understanding of the source code.


IRB
---
Executable via `binding`
Since [ruby 2.4.0, 2016-12-25](https://www.ruby-lang.org/en/news/2016/12/25/ruby-2-4-0-released/) and
actually quite a simple <3
[see the commit](https://github.com/ruby/ruby/commit/493e48897421d176a8faf0f0820323d79ecdf94a)


DEBUGGER
--------
Library providing debugging functionality to ruby (TODO: find out since when)

Immediate breaking via `require 'debug'`
```
# ruby debug_add_debug.rb

debug_add_debug.rb:3:  puts "boo"
(rdb:1) p a
"t"
(rdb:1) list -5,5
[0, 5] in debug_add_debug.rb
   1  def boo(a)
   2    require 'debug'
=> 3    puts "boo"
   4  end
   5
(rdb:1) c
boo
```


No code change approach
```
# ruby -rdebug debug_simple.rb

debug_simple.rb:1:def boo(a)
(rdb:1) n
debug_simple.rb:5:boo('t')
(rdb:1) s
debug_simple.rb:2:  puts "boo"
(rdb:1) a
"t"
(rdb:1) list -5,5
[0, 5] in debug_simple.rb
   1  def boo(a)
=> 2    puts "boo"
   3  end
   4
   5  boo('t')
(rdb:1) c
boo
```

How to start from vim with breakpoint on current line? 8)
---------------------------------------------------------
[Help](https://ruby-doc.org/stdlib-2.4.0/libdoc/debug/rdoc/DEBUGGER__.html#class-DEBUGGER__-label-Getting+help)
advise to use `b[reak] [file:|class:]<line|method>` OR `b[reak] [class.]<line|method>`

=/ Bad luck, debug just stops

Byebug
------
Not a part of stdlib, BUT supports `--no-stop` and reads `.byebugrc` file(s) (current dir, home, both will be read)
```
cat .byebugrc
break /home/_REMOVED_/debug_simple.rb:2

byebug --no-stop debug_simple.rb
Stopped by breakpoint 1 at /home/_REMOVED_/debug_simple.rb:2

[1, 5] in /home/_REMOVED_/debug_simple.rb
   1: def boo(a)
=> 2:   puts "boo"
   3: end
   4:
   5: boo('t')
```

So, when you pair it with `my_bug.bash` script (in `~/bin` if it is in your PATH)
```
#!/bin/bash
file=${1%:*}
break_point=$1
echo "break ${break_point}" > .byebugrc
byebug --no-stop ${file}
if [ -f .byebugrc ]; then
  rm .byebugrc
fi
```

and a vim command like
```
execute "!my_bug.bash " .shellescape(expand('%'), 1).":".shellescape(line('.'), 1)
" put following to your ~/.vimrc and then just call ":MyBug"
:command MyBug execute "!my_bug.bash " .shellescape(expand('%'), 1).":".shellescape(line('.'), 1)
```

It just works =)

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

Integrated profiler
-------------------
require 'profile'` OR `ruby -rprofile -S executable`


Figure out later
----------------
1. how comes `ruby -rtracer script_x.rb` behave different to `require 'tracer'` at the top the file
2. mix into one vim command
3. extend for more breakpoints
