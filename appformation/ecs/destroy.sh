#!/bin/bash
stack=${1:-ecs-demo-svc-flask}
profile=${2:-cicd-dev}

#aws cloudformation validate-template --template-body $template --profile $env
aws cloudformation delete-stack --stack-name $stack --profile $profile
