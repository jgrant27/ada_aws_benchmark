set terminal png size 800,600 enhanced font 'Verdana,10'
set output 'results/ada-aws.png'
set key off
set title "Ada HelloWorld REST API Benchmark (100% success)"
set xlabel "concurrency"
set ylabel "tps"
set logscale x 2
plot "results/ada-aws.dat" with lines
