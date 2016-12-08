eb create dev-v1 \
--vpc.id vpc-id \
--vpc.elbsubnets subnet-id1,subnet-id2\
--vpc.ec2subnets subnet-id1,subnet-id2\
--tags CostCenter=blah 
#--instance_type t2.micro \
#--elb-type application \
