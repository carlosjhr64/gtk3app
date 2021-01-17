if test "$PATH[1]" != "./bin"
  set -gx PATH ./bin $PATH
end

if test "$RUBYLIB[1]" != "./lib"
  set -gx RUBYLIB ./lib $RUBYLIB
end
