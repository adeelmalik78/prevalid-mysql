# Prevalid - MYSQL

This repository shows how to setup Liquibase pipeline with script validation for MySQL database.

Instead of running `liquibase update` against your target database, you would replace it with a flow file: 
```liquibase flow --flow-file=flowfiles/liquibase.flowfile-wprevalidate.yaml```

A number of environment variables are needed to be setup, as shown in `runme.sh` script.

## Environment variables
Following variables needed to set before running
``` bash
LIQUIBASE_PRO_LICENSE_KEY
CLONED_PORT             # e.g., 3366
CLONED_DB               # e.g., DEV_1
CLONED_URL              # e.g., jdbc:mysql://localhost:${CLONED_PORT}/${CLONED_DB}
CLONED_UID
CLONED_PW
LB_ENVIRONMENT          # e.g., DEV
SECONDS_TO_WAIT         # e.g., 10

LIQUIBASE_COMMAND_URL   # e.g., jdbc:mysql://localhost:3306/DEV
LIQUIBASE_COMMAND_USERNAME
LIQUIBASE_COMMAND_PASSWORD
LIQUIBASE_COMMAND_CHANGELOG_FILE
```

## Flow files
Following flow files are provided:
* `liquibase.flowfile-wprevalidate.yaml`: This flow file invokes prevalidate
* `clone-setup.yaml` - takes backup of the target database, creates a cloned database
* `clone-cleanup.yaml` - removes cloned database
* `liquibase.testprevalid` - simple flow file to test clone setup and cleanup
* `liquibase.flowfile.yaml` - This is a normal flow file which does not invoke prevalidate


## Docker
Commands to setup MySQL databases in Docker
```
# Setup DEV database
docker run -p 3306:3306 --name mysqldb -v ${PWD}/BASE:/BASE -e MYSQL_ROOT_PASSWORD=password -d mysql

docker exec -i mysqldb mysql --user=root --password=password -e "use sys; create database DEV;"

# Setup CLONED database
docker run -p 3366:3306 --name mysqldb_cloned -v ${PWD}/BASE:/BASE  -e MYSQL_ROOT_PASSWORD=password -d mysql

docker exec -i mysqldb_cloned mysql --user=root --password=password -e "use sys; create database DEV;"
```

Command to take a backup: 
```
docker exec -it mysqldb /bin/bash -c "mysqldump --password=password DEV > BASE/DEV_backup.sql"
```

Command to restore/import MySQL:
```
docker exec -i mysqldb_cloned /bin/bash -c "mysql --user=root --password=password DEV < BASE/DEV_backup.sql"
```

Command to destroy cloned DB:
```
docker rm -f mysqldb_cloned
```

## Liquibase Pro features in use

* Drift detection
* Operations reports
* Quality Checks
* Flow files
* Liquibase Pro commands: 
    * `rollback-one-update`
