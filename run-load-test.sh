#!/bin/sh
#
URL=http://localhost:8080/api
case $# in
  *)
        NAME=ada-aws
        ;;

  1)
        NAME=ada-aws
        URL=$2
        ;;
esac

mkdir -p results || exit 1
cd results || exit 1

REQ_TIME=10S

rm -f $NAME.csv $NAME.dat $NAME.log
echo "Running siege benchmark for $NAME" >> $NAME.log
date >> $NAME.log
for C in 1 2 4 8 16 32 64 128; do
   echo "Running benchmark with $C concurrent requests"
   siege -b -t$REQ_TIME -c$C $URL > result.log 2>&1
   T=`awk '/Transaction rate/ { print $3; }' result.log`
   echo "$C,$T" >> $NAME.csv
   echo "$C $T" >> $NAME.dat
   cat result.log >> $NAME.log
done

cd ..

./run-gnuplot.sh
