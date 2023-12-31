# Kubernetes Architecture Planning Guide:

## Technical Requirements:

1.  Third Party Apps
2.  Reliability
3.  Security
4.  Team Readiness

##  Responsibilities:

###  Leadership

1.  Highly scalable
2.  Cost Optimization
3.  Resource Optimization
4.  Customer Happiness

###  Technical

1.  Redundancy
2.  Highly Available
3.  Backups
4.  Proper Monitoring and Observability

##  Architecture Planning Phase 1:

1.  Protocols
2.  Planning
3.  Architecture
4.  Design 
5.  Communication

###  Proper Point of Contacts

1.  IT - Uptime, Monitoring, Alarms, Alerts
2.  Dev - Deployments, GitOps, AI, Containers
3.  Security - RBAC, Policy Enforcement, OPA
4.  Platform Engineering (DevOps/SRE) -  

###  Proper Access

1.  IT - Access to AWS
2.  Dev - Terraform (Access to Github)
3.  Security - OIDC, User Access (IAM)

##  Security Planning

1. Network Isolation and encryption (CNI -> Cilium, Service Mesh -> Istio)
2. Namespaces with proper RBAC (Setup proper sevice account for deployment)
3. Limits, Requests and Quotas (Setup limit on memory, cpu, pods etc)
4. Network Policies (Ingress and Egress traffic inside or outside namespace to be manged by network policies)
5. OPA (Setting up best practice. Container images can't run latest in production)
6. Audit logging (Even though we don't manage control plane on cloud but we can access the logs)
7. Resource Scanning (Cluster, Pods, K8s manifests scanning - Tool used Kubescape by ARMO)
8. OIDC - Authentication and Authorization

##  AWS and Azure

###  Build Production grade architecture

https://blog.gruntwork.io/how-to-build-an-end-to-end-production-grade-architecture-on-aws-part-1-eae8eeb41fec

https://aws.github.io/aws-eks-best-practices/

###  Setup RBAC on EKS and AKS

Azure:
1. Select IAM on Kubernetes Cluster 
2. Select Role Assignment -> Add role assignment -> Select roles (eg. Reader) -> Add role assignment
3. Assign Access to (Select Member)

AWS:
1. Copy url link on (OpenID connect provider URL) on EKS cluster
2. Go to IAM - Select Identity Provider - Add Provider - Select OpenID Connect -> Add Provider URL -> Get Thumbprint -> Audience (sts.amazonaws.com)

https://docs.aws.amazon.com/eks/latest/userguide/security-iam.html

Connect Azure AD to authenticate EKS:
https://aws.amazon.com/blogs/containers/using-azure-active-directory-to-authenticate-to-amazon-eks

##  Platform and Tools:

###  AutoScaler 
      * Karpenter

###  Service Mesh 
      * Istio

###  Monitoring and Observability
      * Datadog for all things
          * Monitoring
          * Logging
          * Traces
          * Metrics
          * API

###  OIDC
      * AWS IAM

###  Cluster Deployment
      * Terraform

###  App Deployment
      * GitOps (ArgoCD)

###  Secrets Manager
      * HashiCorp Vault

###  Cluster Deployment
      * Terraform

###  Failover and DR
      * Velero or EBS snapshot

###  Scanner
      * Kubescape

###  Cost and Resource Optimization
      * Sosivio
      * Cast.ai


##  Best Practices:

###  Security
 1. AWS Security: https://aws.amazon.com/compliance/shared-responsibility-model/
 2. CIS Standard  

Proper scanning of cluster and container images.

With the AWS Shared Responsiblity Mode, engineers are responsible for:
 * Identity and Access Management (IAM)
 * Pod Security (Scanning/Vulnerablities)
 * Network Security
 * Multi Tenancy
 * Data Encryption and Secrets Management
 * Compliance
 * Incident Response
 * Container Image Security


 OWASP Top 10 for Kubernetes: https://owasp.org/www-project-kubernetes-top-ten/

 ### Multitenancy 
  1. https://kubernetes.io/docs/concepts/security/multi-tenancy/
  2. https://loft.sh/blog/10-essentials-for-kubernetes-multi-tenancy/
  3. https://dzone.com/articles/kubernetes-multi-tenancy-best-practices-with-amazon-eks
  4. https://medium.com/codex/setup-kubernetes-cluster-multi-tenancy-with-aws-eks-93561442aaeb

  * Seperate different customer environment in K8S cluster using Network Policies, Namespace, OPA, RBAC


### Scalability
 1. Karpenter for autoscaling
 2. Ensure that proper Requests, Quotas and Limits are set

 The maximum number of Pods per Worker Node depends on the node type and ranges from 4 to 737

 Karpenter recommends a maximum number of 110 pods per node.
 https://kubernetes.io/docs/setup/best-practices/cluster-large/

 If we decide to go with cluster autoscaler, it has been tested for 1000 nodes and upto 30 pods per node.
 https://github.com/kubernetes/autoscaler/blob/master/cluster-autoscaler/proposals/scalability_tests.md

The maximum number of services in namespaces is 5000 and maximum number of services in cluster is 10000. To help organoze workload and services, increase performance, and to avoid cascading impact for namespace scoped resources we recommend limiting the number of services per namespace to 500


### Reliability
 1. Run Kubernetes Metrics Servers: https://docs.aws.amazon.com/eks/latest/userguide/metrics-server.html
 2. Set proper replica sets(this will likely be done via Karpenter autoscaling)
 3. Proper rollback strategies (application level)
 4. Proper upgrade strategies (application level - canary deployments)
 5. Proper upgrade strategies (cluster level)
 6. Liveness probes and Readiness probes (application level)

 
### Networking
1. Use Cilium with eBPF (turn off kube proxy) for security, observability and reliability. Cilium has the ability to implement security protocols (like encrypting traffic) and eBPF removes the need to worry about ip tables
2. VPC and network consideration best practices: https://aws.github.io/aws-eks-best-practices/networking/subnets/


### Testing
 1. Chaos Engineering (Cluster and Pods)
 2. Performance Testing (Cluster and Pods)
 3. Cluster, container image, Pod and Manifests scanning


