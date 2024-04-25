PENDING_CHANGES=`liquibase --show-banner=false status | grep -E 'changeset has not been applied' | awk '{print $1}' `
echo PENDING_CHANGES=${PENDING_CHANGES}