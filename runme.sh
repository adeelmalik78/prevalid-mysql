export CLONED_PORT=3366
export CLONED_DB=DEV_1
export CLONED_URL=jdbc:mysql://localhost:${CLONED_PORT}/${CLONED_DB}
export CLONED_UID=root
export CLONED_PW=password
export LB_ENVIRONMENT=DEV
export SECONDS_TO_WAIT=10

export LIQUIBASE_COMMAND_URL=jdbc:mysql://localhost:3306/DEV
export LIQUIBASE_COMMAND_USERNAME=root
export LIQUIBASE_COMMAND_PASSWORD=password
export LIQUIBASE_COMMAND_CHANGELOG_FILE=Changelogs/changelog.sql

rm -rf report

liquibase flow --flow-file=liquibase.flowfile-wprevalidate.yaml

