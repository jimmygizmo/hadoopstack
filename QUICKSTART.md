
## HadoopStack Quick Start

----

### Simplest possible Docker Compose startup:

#### cd into the project root directory where docker-compose.yml is located

     cd <project_root_dir>

     docker-compose up

     open http://localhost:9870

----

### Standard Docker startup:

#### cd into the "hadoop" directory which is inside the project root directory

     cd hadoop

#### Build the image and tag it "hadoopstack-hadoop":

     docker build -t hadoopstack-hadoop .

#### Run the "hadoopstack-hadoop" image. Name the container the same "hadoopstack-hadoop":

     docker run --name hadoopstack-hadoop -p 9864:9864 -p 9870:9870 -p 8088:8088 -p 9000:9000 --hostname localhost hadoopstack-hadoop

----

