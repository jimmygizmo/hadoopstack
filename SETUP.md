## Setup

----

#### cd into the "hadoop" directory where the Dockerfile is located

     cd hadoop

#### Download the Apache Hadoop package:

     curl -L "http://archive.apache.org/dist/hadoop/common/hadoop-3.3.3/hadoop-3.3.3.tar.gz" --output hadoop-3.3.3.tar.gz

The download is over 630 MB and can take up to an hour sometimes.

This package is now in the location required by the build.

If you happen to leave this file in place and want to make commits, there is no problem. .gitignore will keep it out of the repo.

----

