#!/bin/sh

CLASS_TO_BE_RUN=net.sevecek.nemo.SpousteciTrida
PRGDIR=`dirname "$0"`
CLASSPATH="$PRGDIR/lib/Sevecek.net Utils/sevecek-net-utils.jar"         #   :"$PRGDIR/lib/Other/other.jar":"$PRGDIR/lib/Another/another.jar"
APP_JAR="$PRGDIR/dist/aplikace.jar"
BUILD_CLASSES_CLASSPATH="$PRGDIR/build/classes"
PREFERRED_JDK_HOME=~/Java-Training/JDK/Contents/Home
EXE_NAME=java

if [ -x "$PREFERRED_JDK_HOME/bin/$EXE_NAME" ]
then
    JAVA_HOME="$PREFERRED_JDK_HOME"
fi

if [ ! -z "$JAVA_HOME" ]
then
	JAVA_EXE="$JAVA_HOME/bin/$EXE_NAME"
fi

if [ -z "$JAVA_EXE" ] || [ ! -x "$JAVA_EXE" ]
then
    JAVA_EXE=`which java`
fi

if [ -f "$APP_JAR" ]
then
    CLASSPATH="$CLASSPATH":"$APP_JAR"
else
    CLASSPATH="$CLASSPATH":"$BUILD_CLASSES_CLASSPATH"
fi

echo
echo  Executing:
echo  $JAVA_EXE   -classpath "$CLASSPATH"   "$CLASS_TO_BE_RUN"
echo
echo
"$JAVA_EXE"   -classpath "$CLASSPATH"   "$CLASS_TO_BE_RUN"



if [ $? -eq 0 ]
then
	echo -n -e "\033]0;MyJavaAppShellScript\007"
    osascript -e 'tell application "Terminal" to close (every window whose name contains "MyJavaAppShellScript")' &
else
    echo
	echo THERE WAS AN ERROR
fi
