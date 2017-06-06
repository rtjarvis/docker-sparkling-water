# H2O's Sparkling water with Spark 2.1.0, H2O 2.1.8 and Java 8 - Docker Support

## To get associated Docker image

```
$ docker pull rtjarvis/ubuntu-sparkling-water
```

## Run bash inside container

```
$ docker run  -i -t -p 54333:54333 rtjarvis/ubuntu-sparkling-water /bin/bash
```

Configure the Spark cluster:
```
export MASTER="local-cluster[3,2,1024]"
```

> In this case, `local-cluster[3,2,1024]` points to embedded cluster of 3 worker nodes, each with 2 cores and 1G of memory.

And run Sparkling Shell:
```
bin/sparkling-shell
```

> Sparkling Shell accepts common Spark Shell arguments. For example, to increase memory allocated by each executor, use the `spark.executor.memory` parameter: `bin/sparkling-shell --conf "spark.executor.memory=4g"`

And initialize H2OContext 
```scala
import org.apache.spark.h2o._
val hc = new H2OContext(sc).start()
```



## Run Sparkling Shell inside container

```
docker run -i -t -p 54333:54333 --rm mikefaille/ubuntu-sparkling-water bin/sparkling-shell 
```

## Running examples in container

```
docker run -i -t -p 54333:54333 --rm mikefaille/ubuntu-sparkling-water bin/run-example.sh
```
