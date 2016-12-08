#!/bin/bash

script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source "${script_dir}/lib.sh"

stack_name=${1:-ecs-demo-svc-flask}
ecs_cluster_name=${2:-ecs-demo}
desired_count=$3
profile=${4:-cicd-dev}

# scale via update-service
ecs_service_shortname=$(get_ecs_service_shortname $profile $stack_name)
task_definition_latest=$(strip_taskdef_revision $profile $stack_name)
echo "ecs_service_shortname=${ecs_service_shortname}"
echo "task_definition_latest=${task_definition_latest}"
aws ecs update-service --cluster ${ecs_cluster_name} --service ${ecs_service_shortname} --desired-count ${desired_count} --profile $profile
