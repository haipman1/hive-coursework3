FROM apache/hive:4.0.0
ADD --chmod=644 https://repo.maven.apache.org/maven2/org/postgresql/postgresql/42.7.4/postgresql-42.7.4.jar /opt/hive/lib/postgres.jar
