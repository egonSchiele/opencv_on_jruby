#!/bin/sh
OPENCV_JAR="/home/adit/opencv_2.4.9_old/bin/opencv-249.jar"
JAVA_FILE="helpers/org/opencv/LdLibraryLoader.java"
javac -cp ${OPENCV_JAR} ${JAVA_FILE}

