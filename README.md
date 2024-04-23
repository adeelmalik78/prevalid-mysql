# Prevalid - MYSQL

This repository shows how to setup Liquibase pipeline with script validation for MySQL database.

Instead of running `liquibase update` against your target database, you would replace it with a flow file: 
```liquibase flow --flow-file=flowfiles/liquibase.flowfile-wprevalidate.yaml```

A number of environment variables are needed to be setup, as shown in [runme.sh](runme.sh) script.

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
* [liquibase.flowfile-wprevalidate.yaml](flowfiles/liquibase.flowfile-wprevalidate.yaml): This is the main flow file. 
* [clone-setup.yaml](flowfiles/clone-setup.yaml) - (child flow file) takes backup of the target database, creates a cloned database
* [clone-cleanup.yaml](flowfiles/clone-cleanup.yaml) - (child flow file) removes cloned database
* [liquibase.testprevalid](flowfiles/liquibase.testprevalid) - (optiona) simple flow file to test clone setup and cleanup
* [liquibase.flowfile.yaml](flowfiles/liquibase.flowfile.yaml) - (optiona) This is a normal flow file which does not invoke prevalidate


## Docker
Here are some docker commands that are used in `clone-setup.yaml` and `clone-cleanup.yaml` to perform various operations such as start a MySQL clone database, take a backup of MySQL database, perform a restore of MySQL database.

### Setup TARGET database
If your target database (where changes are intended to be deployed post-validation) is needed to be setup in a docker container, use these commands to spin up a MySQL container with DEV database:
``` bash
docker run -p 3306:3306 --name mysqldb -v ${PWD}/BASE:/BASE -e MYSQL_ROOT_PASSWORD=password -d mysql

docker exec -i mysqldb mysql --user=root --password=password -e "use sys; create database DEV;"
```

### Setup CLONED database
Use these docker commands to start a MySQL clone database. The only difference between this and the earlier commands (above) is the name given to the docker container: `mysqldb_cloned`.

``` bash
docker run -p 3366:3306 --name mysqldb_cloned -v ${PWD}/BASE:/BASE -e MYSQL_ROOT_PASSWORD=password -d mysql
# wait for the MySQL container to be setup
docker exec -i mysqldb_cloned mysql --user=root --password=password -e "use sys; create database DEV;"
```

### Take MySQL backup of TARGET database
Command to take a backup of the target database: 
```
docker exec -it mysqldb /bin/bash -c "mysqldump --password=password DEV > BASE/DEV_backup.sql"
```

### Build MySQL CLONED database from the backup
Command to restore/import MySQL:
```
docker exec -i mysqldb_cloned /bin/bash -c "mysql --user=root --password=password DEV < BASE/DEV_backup.sql"
```

### Destroy MySQL CLONED database
Command to destroy cloned DB:
```
docker rm -f mysqldb_cloned
```

## Liquibase Pro features in use

* [Drift detection](https://docs.liquibase.com/tools-integrations/observability/operation-reports-drift-report.html)
* [Operations reports](https://docs.liquibase.com/tools-integrations/observability/operation-reports.html)
* [Quality Checks](https://docs.liquibase.com/commands/quality-checks/home.html)
* [Flow files](https://docs.liquibase.com/commands/flow/home.html)
* Liquibase Pro commands: 
    * `rollback-one-update` [[doc]](https://docs.liquibase.com/commands/rollback/rollback-one-update.html)
    * `checks run` [[doc]](https://docs.liquibase.com/commands/quality-checks/subcommands/run.html)
