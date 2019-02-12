Scanner and Parser for Demo
Author: Kexi Dang (kd38)

# About source code
- myscanner.l: Specification input file for Flex
- myparser.y: Specification input file for Bison
- main.c: Driver that parses command line arguments and invokes the parser
- Makefile: List of rules how to (re)compile the source code
- test/: Including unit test, feature test in ut directory and 4 error test programs in errors directory (Professor give them on clear '/clear/courses/comp506/students/demo/lab1')
- test1.demo and test2.demo: two valid test programs written in Demo language


# How to build: make command
Use Make (rules in Makefile) to build the scanner and parser.


# How to execute
    ./demo -h
        see the help menu.
    ./demo [filename]
        compile the file.
        if the filename is missing, the parser will read from stdin (twice ctrl+d means EOF)
	    if the filename is invalid, it will print an error.
    ./demo -s [filename]
        compile and produce a listing of variables used in program.