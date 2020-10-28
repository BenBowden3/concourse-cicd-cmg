```
docker build .
docker tag (image-id) 005901988046.dkr.ecr.us-east-1.amazonaws.com/concourse-worker

# To push to AWS ECR
aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 005901988046.dkr.ecr.us-east-1.amazonaws.com
docker push 005901988046.dkr.ecr.us-east-1.amazonaws.com/concourse-worker
```
