#!/bin/bash

# helper functions

function err() {
  echo -e "ERROR: ${1}" >&2
  exit 1
}

function warn() {
  echo -e "WARNING: ${1}" >&2
}


function get_taskdef_family() {
    local profile=$1
    local stack_name=$2
    local task_definition_arn=$(aws cloudformation describe-stacks --stack-name $stack_name --query "Stacks[*].Outputs[?OutputKey=='TaskDefinition'].OutputValue" --output text --profile $profile)
    local family=$(echo ${task_definition_arn} | awk -F "/" '{print $2}' | cut -d: -f1)

    echo $family
}


function strip_taskdef_revision() {
    local profile=$1
    local stack_name=$2
    local task_definition_arn=$(aws cloudformation describe-stacks --stack-name $stack_name --query "Stacks[*].Outputs[?OutputKey=='TaskDefinition'].OutputValue" --output text --profile $profile)
    local task_definition_base=$(echo ${task_definition_arn}| cut -d: -f1-6)
    echo $task_definition_base
}


function get_ecs_service_shortname() {
    local profile=$1
    local stack_name=$2
    local ecs_service_arn=$(aws cloudformation describe-stacks --stack-name $stack_name --query "Stacks[*].Outputs[?OutputKey=='Service'].OutputValue" --output text --profile $profile)
    local ecs_service_name=$(echo ${ecs_service_arn}| cut -d/ -f2)

    echo $ecs_service_name
}

# family=$(get_taskdef_family cicd-dev ecs-demo-svc-flask)
# echo $family
#
# service_name=$(get_ecs_service_shortname cicd-dev ecs-demo-svc-flask)
# echo $service_name
