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

export LIQUIBASE_REPORTS_ENABLED=true
export LIQUIBASE_REPORTS_PATH=report

# export PENDING_CHANGES="cat found_changes.txt | awk '{print $1}'"
# export PENDING_CHANGES=`liquibase --show-banner=false status | grep -E 'changeset has not been applied' | awk '{print $1}' `

# Clear reports directory - no necessary when running from CICD pipeline
rm -rf report

liquibase flow --flow-file=flowfiles/liquibase.flowfile-wprevalidate.yaml

