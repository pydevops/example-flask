#!/bin/bash
stack=${1:-ecs-demo-svc-flask}
ecs_cluster_name=${2:-ecs-demo-1}
docker_image_tag=${3:-latest}
profile=${4:-cicd-dev}
vpc_id=${5:-vpc-21d54840}
template=file://service_flask.yaml

#aws cloudformation validate-template --template-body $template --profile $env
aws cloudformation create-stack --stack-name $stack   \
--parameters  \
ParameterKey=VPC,ParameterValue=${vpc_id} \
ParameterKey=Cluster,ParameterValue=${ecs_cluster_name}  \
ParameterKey=ImageTag,ParameterValue=${docker_image_tag}  \
--template-body $template \
--tags Key=CostCenter,Value=cc Key=Project,Value=myproject \
--capabilities "CAPABILITY_IAM" "CAPABILITY_NAMED_IAM"  --profile $profile
