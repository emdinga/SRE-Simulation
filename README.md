# SRE-Project

## Phase 1 — Corporate Linux Environment

**Goals**: Build a mini enterprise Linux environment to simulate real-world SRE tasks, including monitoring, identity management, and basic troubleshooting.

### Components Deployed
**Ubuntu Server 24.04.3 LTS** on VMware

**Docker** installed and configured for containerized applications

**Prometheus** deployed and service activated for metrics collection

**Node Exporter** running in Docker, exposing system metrics on port 9100

**Grafana** installed and grafana-server service activated for visualization

**Samba AD / Domain Controller** set up with at least one user

**SimpleSAMLphp** installed for SAML-based authentication

**LDAP + Apache2** configured for user authentication interface

**Auth configuration (authsources.php & config.php)** updated to allow external SSO-like connections (e.g., AWS Cognito simulation)

### Skills Demonstrated
- Linux system administration
- Docker container management
- Monitoring & observability (Prometheus + Node Exporter + Grafana)
- Networking troubleshooting (ping, curl, ss -tulpen)
- Identity & access management (Samba AD, LDAP, SimpleSAMLphp)
- Service configuration & management (systemctl enable/start/stop)

### Notes / Issues for phase one
- Grafana dashboards are ready but still need data source configuration and custom dashboards
- Prometheus successfully scrapes Node Exporter metrics
- LDAP + SimpleSAMLphp configured but full cloud federation integration pending (Phase 2)

### Phase 2 — On-Prem → AWS SSM Hybrid Activation

**Goals**: Connect on-prem Linux servers to AWS to simulate hybrid cloud management, automated operations, and SRE workflows.

- Created a Hybrid Activation in AWS SSM
- installed Amazon-ssm-agent on my Ubuntu Server
- Registered Ubuntu and Windows Server on-prem VMs with AWS
- Servers now appear in SSM Managed Instances
dc1
root
07:45:42 up  1:15,  1 user,  load average: 0.16, 0.11, 0.11
- Remote command execution tested via SSM Run Command.
- Patch Manager configured: created patch baseline for Ubuntu and performed a scan.
- Automation Runbook created to: Scan and apply patches ,Restart Docker if needed ,Collect logs and system info and Logs streamed to CloudWatch for monitoring and auditing.

**skills Demonstrated** 
- Hybrid Cloud connectivity
- automated SRE workflows
- infrastructure observability.

### Notes and issues for phase two ###
- Amazon-SSM Agent installation via snap had compatibility issues; resolved by downloading the correct .deb for amd64.
- Hybrid Activation successfully created; Ubuntu VM now appears in SSM Managed Instances.
- Runbook creation initially failed due to missing mainSteps and role reference errors; resolved by correctly defining AutomationAssumeRole and actions.
- Patch Manager scan completed successfully; initially had conflicts when modifying patch policies simultaneously.
- CloudWatch logs streaming works, but need to verify full metrics and set up dashboards for alerts.


### Phase 3 — Local Cloud Workloads (Docker + Hybrid AWS Services)

**Goals**:Simulate cloud-native workload deployment locally by containerizing applications, managing multiple services, and integrating AWS cloud functions (like Cognito for authentication) while avoiding cloud compute costs.

- Built lightweight containerized applications (Nginx + sample Flask app).
- Created Dockerfiles and Docker Compose configurations for multi-service setup.
- Deployed containers locally to simulate multiple service workloads.
- Implemented a local load balancer using Nginx reverse proxy to route requests to multiple containers.
- Integrated SimpleSAMLphp with AWS Cognito OIDC for user authentication.
- Configured Flask backend to handle login, authorization, and logout routes with Cognito.
- Simulated application resilience using Docker restart policies.
- Demonstrated hybrid cloud concept by combining local container management with AWS cloud authentication.

**Skills Demonstrated**:
- Local container orchestration and multi-service simulation.
- Load balancing and service routing with Nginx.
- Identity federation using AWS Cognito and SimpleSAMLphp. 
- Docker networking and volume management.
- Hybrid cloud workflows: local workloads + cloud functions.

**Notes / Issues for Phase Three:**
- All workloads run locally; no images pushed to AWS ECR or deployed to ECS Fargate.
- Docker Compose required a separate Dockerfile for Flask backend; initial build failed due to Python werkzeug version conflicts — resolved by updating requirements.txt.
- Nginx proxy configuration had port conflicts initially; resolved by stopping existing containers and mapping correct ports.
- Cognito integration completed, but requires a callback URL; currently using local IP for development.
- SimpleSAMLphp configured to authenticate via Cognito, but production setup will require proper domain and HTTPS certificate.
- Future improvements include adding hybrid features like S3 storage for backups.

### Phase 4 — Enterprise Identity (Cloud Federation & SAML)
**Goals**: Build a full enterprise identity stack to demonstrate real cloud engineering, identity federation, and enterprise authentication architecture.

**Achievements**

- Configured Samba AD with internal corporate users
- Installed and configured SimpleSAMLphp to translate LDAP/AD users to SAML 2.0 assertions
- Provisioned AWS Cognito with Terraform:
     - User Pool
     - SAML Identity Provider linked to SimpleSAMLphp IdP
     - App Client with OAuth callback & logout URLs
- Exposed local SimpleSAMLphp instance via Ngrok HTTPS tunnel for Cognito federation
- Implemented federated login flow:
      - Cloud App redirects to Cognito
      - Cognito redirects to SimpleSAMLphp IdP
      - AD users authenticated via SAML
      - Tokens returned to App Client
- Tested authentication for multiple users

**Skills Demonstrated**
- IAM & Identity Federation: connecting on-prem identity to cloud services
- SAML: configuring IdP → SP authentication
- Enterprise Authentication Architecture: bridging internal corporate users with cloud applications
- Security Mindset: HTTPS tunneling, secure token handling, and federated login flows
- Terraform Automation: managing Cognito resources programmatically
  
**Notes / Issues**
- Callback URLs must use HTTPS to work with Cognito
- Ngrok authtoken needed for external cloud federation testing
- App Client updates (ID & Secret) must match Cognito configuration

### Phase 5 — Container Orchestration & Kubernetes Platform Engineering

**Goals**:Design, deploy, and operate a production container orchestration platform for Kubernetes operations, container lifecycle management, networking, and troubleshooting.

**Achievements**
- Deployed a single-node Kubernetes cluster using MicroK8s to simulate an on-prem / edge production environment
- Built and containerized a Flask backend application using Python 3.11 (slim image)
- Built and deployed an NGINX frontend container for web access and reverse proxying
- Enabled and configured the MicroK8s local container registry
- Managed containerd vs Docker runtime differences, importing images directly into containerd
- Deployed applications using Kubernetes primitives:
     - Deployments with replicas, resource requests, and limits
     - ClusterIP Services for internal service discovery
     - Ingress (NGINX) for external HTTP access using host-based routing
- Implemented host-based routing using /etc/hosts for local DNS resolution
- Successfully exposed the application via Kubernetes Ingress (flask.local)
- Verified service-to-pod communication using in-cluster BusyBox testing
- Performed live debugging and recovery of failed workloads:
     - ErrImagePull, ErrImageNeverPull, ImagePullBackOff
     - Disk pressure scheduling failures
     - 502 Bad Gateway errors at the ingress layer
- Diagnosed and resolved service connectivity issues by validating:
     - Pod labels and service selectors
     - TargetPort vs containerPort alignment
     - Application process listening ports
- Performed rolling restarts and cleanup of orphaned pods and ReplicaSets

**Skills Demonstrated**
- Kubernetes Core Concepts: Pods, Deployments, ReplicaSets, Services, Ingress
- Container Orchestration: managing workloads at scale with declarative manifests
- Container Runtimes: understanding Docker vs containerd behavior in Kubernetes
- Kubernetes Networking: Pod IPs, ClusterIP services, CNI (Calico), ingress routing
- Production Troubleshooting: diagnosing failures across image, network, and runtime layers
- Platform Engineering Mindset: operating Kubernetes as infrastructure, not just deploying apps
- Linux & Systems Knowledge: disk pressure, process inspection, and runtime constraints
- Operational Discipline: iterative debugging using logs, describe, exec, and in-cluster tests

**Notes / Issues**
- MicroK8s uses containerd, not Docker — locally built images must be pushed to a registry or imported into containerd
- Disk pressure can prevent pod scheduling and image garbage collection
- Kubernetes Services require exact label matching to route traffic to pods
- 502 Bad Gateway errors typically indicate backend service or port mismatches]
- Minimal container images may not include common debugging tools (ps, netstat)
- Ingress does not expose services unless the backend application is actively listening on the expected port
- <img width="434" height="173" alt="imagepullbackoff" src="https://github.com/user-attachments/assets/16368eda-3a37-4a29-af70-b683cb1a54cb" />


