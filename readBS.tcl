proc ascii2chars {asciis {delemiter ""}} {
    if {[string equal "" $delemiter]} {
        set asciis [regsub -all {([0-9a-zA-Z]{2})} $asciis " \\1"]
        set delemiter " "
    }
    set asciis [string trimright $asciis $delemiter]
    set asciis ${delemiter}${asciis}
    set RE \[$delemiter\]\+
    set hexes [regsub -all $RE $asciis ${delemiter}0x]
    return [binary format c* $hexes]
}


proc display { asciis step color_set} { 
    set colors(0) "\033\[1;30;40m"
    set colors(1) "\033\[1;31;40m"
    set colors(2) "\033\[1;32;40m"
    set colors(3) "\033\[1;33;40m"
    set colors(4) "\033\[1;34;40m"
    set colors(5) "\033\[1;35;40m"
    set colors(6) "\033\[1;36;40m"
    set colors(7) "\033\[1;37;40m"
    set color_set_len [llength $color_set]
    for {set h 0} { $h < $color_set_len} { incr h } {
        set sub_colors($h) $colors([lindex $color_set $h])
    }
    set len [string length $asciis] 
    puts "\033\[0m"
    set i 0
    set round 0
    while { $i < $len } {
        set color_index [expr $round % $color_set_len]
            puts -nonewline $sub_colors($color_index)
        for {set j 0} { $j < $step} { incr j } {
            puts -nonewline [string range $asciis [expr $i + $j] [expr $i + $j]]
        }
        incr i $step
        incr round
    }
    puts "\033\[0m"
}

proc help { } {
    puts "how to use it:"
    puts "    display \$string \$frequency \$colorset"
    puts "the 1st para 'string' is a string you want to colored it:"
    puts "    for exzample 'helloworld'"
    puts "the 2nd para 'frequency' means the frequency you want to change the color:"
    puts "    for exzample, if frequency == 1,the color changed every char"
    puts "    for exzample, if frequency == 2,the color changed every two chars"
    puts "the colorset is a list of numbers:"
    puts "    each number stand for a color,the map is:"
    puts -nonewline "\033\[0m"
    puts -nonewline "        0 mapped to "
    puts -nonewline "\033\[1;30;40m"
    puts "grey:"
    puts -nonewline "\033\[0m"
    puts -nonewline "        1 mapped to "
    puts -nonewline "\033\[1;31;40m"
    puts "red:"
    puts -nonewline "\033\[0m"
    puts -nonewline "        2 mapped to "
    puts -nonewline "\033\[1;32;40m"
    puts "green:"
    puts -nonewline "\033\[0m"
    puts -nonewline "        3 mapped to "
    puts -nonewline "\033\[1;33;40m"
    puts "yellow:"
    puts -nonewline "\033\[0m"
    puts -nonewline "        4 mapped to "
    puts -nonewline "\033\[1;34;40m"
    puts "blue:"
    puts -nonewline "\033\[0m"
    puts -nonewline "        5 mapped to "
    puts -nonewline "\033\[1;35;40m"
    puts "purple:"
    puts -nonewline "\033\[0m"
    puts -nonewline "        6 mapped to "
    puts -nonewline "\033\[1;36;40m"
    puts "azure:"
    puts -nonewline "\033\[0m"
    puts -nonewline "        7 mapped to "
    puts -nonewline "\033\[1;37;40m"
    puts "white:"
    puts -nonewline "\033\[0m"
    puts "tunning your terminal to one type support ANSI color, and try the belows to see the effect:"
    puts "    display 'helloworld' 2 {0 1 2 3 4 5 6 7}"
    puts "    display 'helloworld' 3 {0 1 2 3 4 5 6 7}"
    puts "    display 'helloworld' 4 {0 1 2 3 4 5 6 7}"
    puts "    display 'helloworld' 2 {2 3}"
    puts "    display 'helloworld' 1 {2 3}"
}






set asciis [lindex $argv 0]
set delemiter [lindex $argv 1]
#set colorset [lindex $argv 2]
#"6c 32 74 70 5f 76 33 74 65 73 74"
set str [ascii2chars $asciis $delemiter]
display $str 1 {2 3}
binary scan $str H* asciis
display $asciis 2 {2 3}

