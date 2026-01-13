# SRE-Simulation

# Phase 1 — Corporate Linux Environment

# Goals: Build a mini enterprise Linux environment to simulate real-world SRE tasks, including monitoring, identity management, and basic troubleshooting.

# Components Deployed
Ubuntu Server 24.04.3 LTS on VMware
Docker installed and configured for containerized applications
Prometheus deployed and service activated for metrics collection
Node Exporter running in Docker, exposing system metrics on port 9100
Grafana installed and grafana-server service activated for visualization
Samba AD / Domain Controller set up with at least one user
SimpleSAMLphp installed for SAML-based authentication
LDAP + Apache2 configured for user authentication interface
Auth configuration (authsources.php & config.php) updated to allow external SSO-like connections (e.g., AWS Cognito simulation)

# Skills Demonstrated
Linux system administration
Docker container management
Monitoring & observability (Prometheus + Node Exporter + Grafana)
Networking troubleshooting (ping, curl, ss -tulpen)
Identity & access management (Samba AD, LDAP, SimpleSAMLphp)
Service configuration & management (systemctl enable/start/stop)

# Notes / Issues
Grafana dashboards are ready but still need data source configuration and custom dashboards
Prometheus successfully scrapes Node Exporter metrics
LDAP + SimpleSAMLphp configured but full cloud federation integration pending (Phase 2)

