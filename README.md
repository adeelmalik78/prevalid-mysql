# Prevalid - MYSQL

## Environment variables
Following variables needed to set before running
```
LIQUIBASE_PRO_LICENSE_KEY
LIQUIBASE_COMMAND_URL
LIQUIBASE_COMMAND_USERNAME
LIQUIBASE_COMMAND_PASSWORD
LIQUIBASE_COMMAND_CHANGELOG_FILE
LIQUIBASE_COMMAND_TAG
CLONED_URL=jdbc:mysql://localhost:3366/DEV
CLONED_UID=root
CLONED_PW=password
LB_ENVIRONMENT=DEV
```

## Flow files
Following flow files are provided:
* liquibase.flowfile.yaml - This is a normal flow file which does not invoke prevalidate
* liquibase.flowfile-wprevalidate.yaml: This flow file invokes prevalidate
* clone-setup.yaml - 


## Docker
Commands to setup MySQL databases in Docker
```
# Setup DEV, TEST and PROD databases
docker run -p 3306:3306 --name mysqldb -v ${PWD}/BASE:/BASE -e MYSQL_ROOT_PASSWORD=password -d mysql
docker exec -i mysqldb mysql --user=root --password=password -e "use sys; create database DEV; create database TEST; create database PROD;"

# Setup CLONED database
docker run -p 3366:3306 --name mysqldb_cloned -v ${PWD}/BASE_cloned:/BASE  -e MYSQL_ROOT_PASSWORD=password -d mysql
docker exec -i mysqldb_cloned mysql --user=root --password=password -e "use sys; create database DEV; create database TEST; create database PROD;"
```

Command to take a backup: 
```
docker exec -it mysqldb /bin/bash -c "mysqldump --password=password DEV > BASE/DEV_backup.sql"
```

Command to restore MySQL:
```
```

## Liquibase Pro features in use

* Drift detection
* Operations reports
* Quality Checks
* Flow files
* Liquibase Pro commands: 
    * `rollback-one-update`
