#!/bin/bash
#apt-get update -y
#apt-get install -y docker.io
#usermod -aG docker ubuntu
#systemctl enable docker
#systemctl start docker
# Install ECS agent
chmod 755 -R /etc/ecs
cat <<EOF > /etc/ecs/ecs.config
ECS_CLUSTER=demo-backstage
EOF
#curl https://amazon-ecs-agent.s3.amazonaws.com/ecs-agent-latest.tar.gz -o ecs-agent.tar.gz
#mkdir -p /opt/ecs
#tar xzf ecs-agent.tar.gz -C /opt/ecs
#/opt/ecs/ecs-agent --cluster ${var.ecs_cluster_name} --region  ${var.region}