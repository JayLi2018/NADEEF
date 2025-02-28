#!/bin/bash
export BuildVersion='1.0.1019'
JAVA_ARGS="-Djava.util.logging.ConsoleHandler.level=FINE"
type -P javac > /dev/null 2>&1 || { echo "JDK cannot be found, please check your PATH var."; exit 1; }
 
function run_console()
{
  cmd="java $JAVA_ARGS -cp out/bin/*:examples/:out/test qa.qcri.nadeef.console.Console"
  exec $cmd
}

function run_dashboard()
{
  cmd="java $JAVA_ARGS -cp out/bin/*:. qa.qcri.nadeef.web.NadeefStart"
  exec $cmd
}

function run_non_interactive_console()
{
  echo "we in non interactive mode"
  cmd="java $JAVA_ARGS -cp out/bin/*:examples/:out/test qa.qcri.nadeef.console.Console $1"
  exec $cmd
}

if ! [ -d "out" ]; then
    echo NADEEF is not yet compiled, please first run 'ant' to build it.
else
    if [ $# -eq 1 ]; then
        if [ "$1" == "console" ]; then
          run_console
        elif [ "$1" == "dashboard" ]; then
          run_dashboard
        else
            echo 'Usage: nadeef.sh [OPTIONS]'
            echo 'Options are:'
            echo '    console : start the NADEEF console.'
            echo '    dashboard : start the NADEEF dashboard.'
            echo 'Environment variables considered: JAVA_ARGS. Example: JAVA_ARGS="-Xmx15G"'
        fi
    else
      run_non_interactive_console "$2"
    fi
fi

java -Djava.util.logging.ConsoleHandler.level=FINE -cp out/bin/*:examples/:out/test qa.qcri.nadeef.console.Console