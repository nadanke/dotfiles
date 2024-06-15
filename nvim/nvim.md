e - to the end of the current word
redo - <C-r>
c - change operator, des was i gedacht hab s is?
b - motion für beginning of word

G - go to the end of the file
gg - go to the beginning of the file
number G - go to the line number
<C-o> - go back to the previous position
<C-i> - go forward to the next position -> des muas i remappen
% - jump to the matching bracket

 4. To substitute new for the first old in a line type
~~~ cmd
        :s/old/new
~~~
    To substitute new for all olds on a line type
~~~ cmd
        :s/old/new/g
~~~
    To substitute phrases between two line #'s type
~~~ cmd
        :#,#s/old/new/g
~~~
    To substitute all occurrences in the file type
~~~ cmd
        :%s/old/new/g
~~~
    To ask for confirmation each time add 'c'
~~~ cmd
        :%s/old/new/gc

:! - execute shell command
