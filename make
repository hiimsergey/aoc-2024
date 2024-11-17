#!/bin/sh

banner="    _          ____   ____   ___ ____  _  _   
   / \\   ___  / ___| |___ \\ / _ \\___ \\| || |  
  / _ \\ / _ \\| |       __) | | | |__) | || |_ 
 / ___ \\ (_) | |___   / __/| |_| / __/|__   _|
/_/   \\_\\___/ \\____| |_____|\\___/_____|  |_|  
"

if [ $# -eq 0 ] || [ $# -gt 2 ]; then
    echo "$banner"
    echo "Usage: ./make <day>
       ./make prep <day>
       ./make all"
    exit 1
fi

case $1 in
    "prep")
        if [ -e $2.c ]; then
            echo "$2.c already exists."
            exit 1
        fi

        echo "#include <stdio.h>

// TODO include the string content in INPUT

void one() {
    int result = 0;
    printf(\"$2.1: %d\\t\\t\", result);
}

void two() {
    int result = 0;
    printf(\"$2.2: %d\\n\", result);
}

int main() { one(); two(); }" > $2.c && echo "Created $2.c"
        ;;
    "all")
        echo "$banner"
        for day in {1..25}; do
            ./$0 $day
            if [ $? -ne 0 ]; then
                echo "=====================================================
One or more tasks not completed, starting from day $day.
====================================================="
                exit 1
            fi
        done

        echo "==============================================================
All tasks completed! Now make sure that the numbers are correct.
================================================================"
        ;;
    *)
        gcc $1.c -o $1.out && ./$1.out
esac
