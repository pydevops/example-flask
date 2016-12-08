#!/bin/bash

script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source "${script_dir}/lib.sh"

image_tag=${1:-latest}
stack_name=${2:-ecs-demo-svc-flask}
ecs_cluster_name=${3:-ecs-demo}
profile=${4:-cicd-dev}

# generate service json for taskdef registration
family=$(get_taskdef_family $profile $stack_name)
echo "family=${family}"
cat service_flask.template | sed -e "s/{FAMILY}/${family}/g" -e "s/{IMAGE_TAG}/${image_tag}/g" > service_flask.json

# register task definition
service_json=file://service_flask.json
aws ecs register-task-definition --cli-input-json ${service_json} --profile $profile

# update-service
ecs_service_shortname=$(get_ecs_service_shortname $profile $stack_name)
task_definition_latest=$(strip_taskdef_revision $profile $stack_name)
echo "ecs_service_shortname=${ecs_service_shortname}"
echo "task_definition_latest=${task_definition_latest}"
aws ecs update-service --cluster ${ecs_cluster_name} --service ${ecs_service_shortname} --task-definition ${task_definition_latest}  --profile $profile
