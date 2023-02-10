
## HadoopStack Quick Start

----

### Simplest possible Docker Compose startup:

docker-compose up

http://localhost:9870

----

### Standard Docker startup:

#### Build the image and tag it "hadoopstack":

docker build -t hadoopstack .

#### Run the "hadoopstack" image. Name the container the same "hadoopstack":

docker run --name hadoopstack -p 9864:9864 -p 9870:9870 -p 8088:8088 -p 9000:9000 --hostname localhost hadoopstack

----

