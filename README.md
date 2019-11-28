# Ada Web Service REST API Server Benchmark

```
gprclean aws/aws_benchmark.gpr ; gprbuild aws/aws_benchmark.gpr
```

[![License](http://img.shields.io/badge/license-APACHE2-blue.svg)](LICENSE)

This is a fork of Stephane Carrez' [benchmarking tool](https://github.com/stcarrez/ada-rest-api-server-benchmark)

The project implements the same REST API as the
[java-rest-api-web-container-benchmark](https://github.com/arcadius/java-rest-api-web-container-benchmark)
which compares several Java web containers.  The REST API is the same for each
server (Java or Ada) and it returns the following json result:

  {"greeting":"Hello World!"}

Server performance is measured using [Siege](https://www.joedog.org/)

# Build

To build the Ada server, you must have built and installed the following:

* AWS      (http://libre.adacore.com/libre/tools/aws/)

Then build with:

```
    gprbuild -Paws/aws_benchmark -p
```

# Linux Network Stack settings

Siege makes an intensive use of network connections which results in exhaustion of
TCP/IP port to connect to the server.  This is due to the TCP TIME_WAIT that prevents
the TCP/IP port to be re-used for future connections.  To avoid such exhaustion,
you should setup the network stack on both the server host and the client host where
siege is executed.  You will do this with:

```
  sudo sysctl -w net.ipv4.tcp_tw_reuse=1
```

# Running the benchmark

Start the server that you want to benchmark, for example:

```
  aws/bin/aws_rest_api
```

In another window (or best on another computer), run the Siege benchmark:

```
  sh run-load-test.sh http://localhost:8080/api
```

(change *localhost* to the IP address of the server if necessary).

Results are produced in the *results* directory and you can plot them
by using [Gnuplot](http://www.gnuplot.info/).
