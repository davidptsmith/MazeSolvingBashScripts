# Maze Solving Script - UWA

## Details

Version: 0.1  
Date: 2021-04-07    


## Background

You are employed by Minotoro, a company that contracts to build hedge
mazes, labyrinths and Halls of Mirrors for customers. You work as a Maze
Quality Control Officer.

Your manager, Stephen Dedalus, has provided you with a Bash script,
`maze_gen`, which generates plans for mazes. The mazes are made up of
3-by-3 *cells* with either adjoining walls, or corridors between them.

Running `maze_gen` *`width`* *`height`* will generate a maze plan which
is *width* cells wide and *height* cells high. For instance, the
following maze was generated by running `maze_gen 7 5`:

```
    ###############
                  #
    # # # ####### #
    # # #       # #
    # # ### #######
    # #   #       #
    # # ##### ### #
    # #     #   # #
    # ####### ### #
    #       #   #
    ###############
```

If the height and width of a maze, in terms of cells, are *h* and *w*,
then the printed plan will have *w \* 2 + 1* columns and *h \* 2 + 1* rows.

The maze plans Minotoro produces should satisfy the following
requirements (we assume maze plans are always oriented with north at the
top):

**Maze plan rules**

1.  The maze plans should contain only space characters, and the hash
    ("`#`") character.

2.  The top-left cell should have an entry to the maze in the western
    wall.

3.  The bottom-right cell should have an exit from the maze in the
    eastern wall.

4.  There should be no other entries or exits from the maze.

5.  The maze should always have the height and width (in terms of cells)
    that the client has requested.

6.  There should always be a route through the maze from the entry to
    the exit.

7.  There should always be a route from any cell to the exit.

8.  The maze should contain no loops – for instance, the following maze
    is a badly-formed one –

    ```
        ###########
             .....#
        # ###.###.#
        #   #.....
        ###########
    ```

    – since it contains a loop (marked with full stops).

It is also possible to use the `maze_gen` script to generate some mazes which are
known to be nearly always badly-formed – they breach one or more of the
above rules. It is possible a well-formed maze might be constructed by
accident, but this rarely seems to happen for mazes of any reasonable
size (e.g. more than about 5 cells in height).

Calling the `maze_gen` program as follows, with the "`-b`" flag –

    $ maze_gen -b 10 6

– will generate a (probably) badly-formed maze.

You will be required to write several Bash *quality control scripts*,
which are designed to test whether mazes are well-formed or not,
according to the above rules.

Note that the `maze_gen` script is only likely to work with Bash version
4.3 or greater (you can check what version of Bash you are using by
running "`bash --version`"), and when standard Linux utilities
installed. We will ensure everyone has access to a standard Ubuntu 20.04
environment, with the correct version of Bash and all required
utilities, for testing their programs on.

## Tasks

The scripts all should read from standard input, and output their
results to standard output. In general, they should just print the word
"`yes`" if the maze they are given passes the rules they are designed to
check, and the word "`no`" if it does not.

You should be able to try out one of your scripts by typing (for
instance):

    $ maze_gen 7 5 | quality-check-script-01.sh

If any script is invoked differently, we describe it below.

The scripts you will need to write are as follows:

1.  **`quality-check-script-01.sh`**: Check that maze plans supplied on
    standard input contain only space characters and hash characters
    ("`#`") – **6 marks**.

2.  **`quality-check-script-02.sh`**: Check that maze plans supplied on
    standard input have the correct number of rows and column – **4
    marks**.

    This script can be invoked as (for example):

        $ maze_gen 7 5 | quality-check-script-02.sh 7 5

3.  **`quality-check-script-03.sh`**: Check that maze plans supplied on
    standard input have an entry and exit as specified by rules 2 and 3
    – **3 marks**.

4.  **`quality-check-script-04.sh`**: Check that maze plans supplied on
    standard input have no other entries or exits besides the ones
    specified by rules 2 and 3 (this is rule 4) – **2 marks**.

5.  **`quality-check-script-05.sh`**: Check that maze plans supplied on
    standard input always have a route from start to finish, as required
    by rule 6 – **2 marks**.


## Automated tests

You do not have to make use of them, but if you want to see
what sort of tests we might run on your scripts, you can
`cd` into the directory `tests` of the repository and execute
`./run_tests.sh`.

The script should run on any Ubuntu 20.04 environment that has
the expected
tools installed. It runs the tests and shows how many pass or
fail (as well as how long the tests took to run).

## Extension tasks

Up to 2 marks are available for *extension tasks*, which are awarded at
the discretion of the marker. If you lose marks on some tasks, these
marks can increase your total (up to a maximum of 20). In general, 1
mark is awarded for an interesting and/or useful task, and 2 marks for
an excellently implemented and very challenging task.

If you would like to attempt an extension task, make sure you

-   make a directory called "`extension`" to put your extension script in
-   call your extension script "`extension.sh`"
-   add a script called `demo.sh` which shows how to run your
    extension script, as well as a
    README file describing what it does.


<!--
  vim: ts=2 sw=2 et tw=72
-->
