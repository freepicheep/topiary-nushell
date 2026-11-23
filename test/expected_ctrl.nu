# for
for i in [1 2 3] {
  # if
  if (true or false) {
    print "break"; break # break
  } else if not false {
    print "continue"; continue # continue
  }
  return 1 # return
}
# alias
alias ll = ls -l # alias comment
# where
ls | where $in.name == 'foo'
| where {|e| $e.item.name !~ $'^($e.index + 1)' }
# match
let foo = {name: 'bar' count: 7}
match $foo {
  {name: 'bar' count: $it} if $it < 5 => ($it + 3) # match arm comment
  # match comment
  {name: 'bar' count: $it} if not ($it >= 5) => ($it + 7)
  _ => { exit 0 }
}
match $foo {
  [a b c] => 0
  a | b | c => 42
  a
  | b
  | c => 42
  {$bar $baz} => $baz
  #  ..rest pattern
  [$x ..$y] if $x == 1 => { 'good list' }
  [..$y] => { $y }
}
match $foo { null => { return "default" } $val => $val }
# while
mut x = 0; while $x < 10 { $x = $x + 1 }; $x # while comment
# loop
loop {
  if $x > 10 { break };
  $x = $x + 1
}
# try
try {
  # error
  error make -u {
    msg: 'Some error info'
  }
}; print 'Resuming'

# try catch finally
try {
} catch { } finally {
  1
}
# row conditions (nushell 0.117)
ls | where enabled and not hidden
ls | where not hidden
ls | where modified older-than 2day
ls | where modified newer-than 2day
ls | where --help
ls | any {|x| $x.size > 1kb }
ls | all {|x| $x.size > 1kb }
(
  ls
  | where size > 1kb
)
# match rest patterns anywhere, guards on alternatives
match $foo {
  [$first ..$mid $last] => 1
  [.. $last] => 2
  [$first ..] => 3
  1 | 2 if $foo > 0 => 4
  _ => 5
}
