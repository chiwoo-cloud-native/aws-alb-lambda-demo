# aws-alb-lambda-demo
Terraform 모듈을 이용하여 ALB 와 Lambda 를 연동하여 서비스하는 샘플  프로젝트 입니다.


## 아키텍처

## Git
```

```

## Provisioning 

### Docker Demon
```
docker images
```

### Init

```
terraform -chdir=vpc init && \
terraform -chdir=alb init && \
terraform -chdir=helloworld init 
```

### Build
```
terraform -chdir=vpc apply -var-file=../terraform.tfvars -auto-approve && \
terraform -chdir=alb apply -var-file=../terraform.tfvars -auto-approve && \
terraform -chdir=helloworld apply -var-file=../terraform.tfvars -auto-approve
```


```
terraform -chdir=helloworld plan -var-file=../terraform.tfvars
```
### Check


```
curl -XGET --location https://hello.sympledemo.tk/ 
```

### Destroy

helloworld 람다와 관련된 모든 리소스를 제거 합니다. 

```
terraform -chdir=helloworld destroy -var-file=../terraform.tfvars -auto-approve && \
terraform -chdir=alb destroy -var-file=../terraform.tfvars -auto-approve && \
terraform -chdir=vpc destroy -var-file=../terraform.tfvars -auto-approve
```


## Appendix

- [도메인 발급 및 Route53 구성](https://symplesims.github.io/devops/route53/acm/hosting/2022/01/11/aws-route53.html)
