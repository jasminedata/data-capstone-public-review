# DATA_CAPSTONE-PROJECT

Terraform-based AWS 3-tier infrastructure for the capstone environment.

## Architecture Overview
- Public entry: Application Load Balancer (ALB)
- App tier: Frontend Auto Scaling Group (private subnets)
- Service tier: Backend Auto Scaling Group behind internal Network Load Balancer (NLB)
- Admin access: Bastion host (public subnet)
- Network: VPC with 2 public + 2 private subnets across 2 AZs
- Outbound private egress: NAT Gateway
- S3 private access from private subnets: S3 Gateway Endpoint
- Terraform state: S3 backend (native lockfile)

## Repository Structure
- `bootstrap/` : provisions Terraform backend S3 bucket
- `envs/dev/` : environment orchestration (module wiring)
- `modules/` : reusable Terraform modules (`vpc`, `security_groups`, `load_balancers`, `launch_templates`, `autoscaling`, `iam`, `s3_gateway_endpoint`)

## Prerequisites
- Terraform `>= 1.10.0`
- AWS credentials configured in shell/profile
- Existing EC2 key pair name for bastion/private SSH path

## Backend and Initialization
1. Bootstrap backend resources first:
```powershell
cd bootstrap
terraform init
terraform plan
terraform apply
```

2. Initialize dev stack with local backend config:
```powershell
cd ..\envs\dev
terraform init -reconfigure -backend-config=".\s3backend.hcl"
```

## Deploy / Update
From `envs/dev`:
```powershell
terraform plan
terraform apply
```

## Useful Outputs
From `envs/dev`:
```powershell
terraform output
```
Includes:
- `frontend_alb_dns_name`
- `backend_nlb_dns_name`
- `bastion_public_ip`

## Security Group Access Model
- ALB SG: HTTP 80 from internet
- Bastion SG: SSH 22 from `bastion_allowed_cidr`
- Frontend SG: SSH 22 from Bastion SG, HTTP 80 from ALB SG
- Backend SG: SSH 22 from Bastion SG, HTTP 80 from Frontend SG + private subnet CIDRs (internal NLB path/health)

## Scaling and Health Settings
- Frontend ASG: `min 2`, `desired 2`, `max 4`
- Backend ASG: `min 2`, `desired 2`, `max 4`
- Bastion ASG: `min/desired/max = 1`
- CPU scale out: `>= 40` (1 datapoint in 1 minute)
- CPU scale in: `<= 10` (1 datapoint in 1 minute)
- ASG grace period: `180s`
- TG health checks:
  - Frontend TG: interval `30s`, unhealthy threshold `2`
  - Backend TG: interval `30s`, unhealthy threshold `3`

## Demo / Test Commands
Stress CPU (on target instance via SSH/SSM):
```bash
sudo dnf install -y stress-ng
stress-ng --cpu 2 --timeout 120s --metrics-brief
```

Unhealthy replacement test (frontend/backend instance):
```bash
sudo systemctl stop httpd
```
Then check Target Group health and ASG activity.

## Troubleshooting
- Lock error: ensure no active Terraform run, then `terraform force-unlock <LOCK_ID>` if stale.
- Module-not-installed after refactor: run `terraform init`.
- Bastion SSH timeout: verify VPN IP matches `bastion_allowed_cidr`, correct key, route/SG.
- Frontend cannot reach backend: verify backend TG health, backend SG rules, backend service status.

## Notes
- `*.tfvars` and local backend config (`s3backend.hcl`) are intentionally gitignored.
- Keep secrets out of repository.
