.PHONY: check clean reset basic intermediate monitoring argocd help

# Colors
GREEN := \033[0;32m
YELLOW := \033[0;33m
RED := \033[0;31m
NC := \033[0m

help: ## Show this help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "$(GREEN)%-15s$(NC) %s\n", $$1, $$2}'

check: ## Check cluster status
	@echo "$(YELLOW)Checking Kubernetes cluster...$(NC)"
	@kubectl cluster-info && echo "$(GREEN)✓ Cluster is running$(NC)" || echo "$(RED)✗ Cluster is not running$(NC)"
	@echo ""
	@kubectl get nodes

clean: ## Remove all lab resources
	@echo "$(YELLOW)Cleaning up all lab resources...$(NC)"
	-kubectl delete -f 01-basic/ -R --ignore-not-found
	-kubectl delete -f 02-intermediate/ -R --ignore-not-found
	-kubectl delete -f 03-advanced/ -R --ignore-not-found
	-kubectl delete -f apps/ -R --ignore-not-found
	@echo "$(GREEN)✓ Cleanup complete$(NC)"

reset: clean ## Reset cluster (clean + delete namespaces)
	@echo "$(YELLOW)Resetting cluster...$(NC)"
	-kubectl delete ns lab-basic lab-intermediate lab-advanced --ignore-not-found
	@echo "$(GREEN)✓ Reset complete$(NC)"

# Basic Labs
basic: ## Deploy all basic labs
	@echo "$(YELLOW)Deploying basic labs...$(NC)"
	kubectl apply -f 01-basic/ -R
	@echo "$(GREEN)✓ Basic labs deployed$(NC)"

pods: ## Deploy pods lab
	kubectl apply -f 01-basic/01-pods/

deployments: ## Deploy deployments lab
	kubectl apply -f 01-basic/02-deployments/

services: ## Deploy services lab
	kubectl apply -f 01-basic/03-services/

# Intermediate Labs
intermediate: ## Deploy all intermediate labs
	@echo "$(YELLOW)Deploying intermediate labs...$(NC)"
	kubectl apply -f 02-intermediate/ -R
	@echo "$(GREEN)✓ Intermediate labs deployed$(NC)"

ingress: ## Install NGINX Ingress Controller
	@echo "$(YELLOW)Installing NGINX Ingress Controller...$(NC)"
	kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.8.2/deploy/static/provider/cloud/deploy.yaml
	@echo "$(GREEN)✓ Ingress Controller installed$(NC)"

# Advanced Labs
monitoring: ## Deploy Prometheus + Grafana
	@echo "$(YELLOW)Installing monitoring stack...$(NC)"
	helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
	helm repo update
	helm upgrade --install monitoring prometheus-community/kube-prometheus-stack \
		--namespace monitoring --create-namespace \
		--set grafana.adminPassword=admin
	@echo "$(GREEN)✓ Monitoring stack installed$(NC)"
	@echo "$(YELLOW)Grafana: kubectl port-forward svc/monitoring-grafana 3000:80 -n monitoring$(NC)"

argocd: ## Install ArgoCD
	@echo "$(YELLOW)Installing ArgoCD...$(NC)"
	kubectl create namespace argocd --dry-run=client -o yaml | kubectl apply -f -
	kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
	@echo "$(GREEN)✓ ArgoCD installed$(NC)"
	@echo "$(YELLOW)Get password: kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath='{.data.password}' | base64 -d$(NC)"
	@echo "$(YELLOW)Port-forward: kubectl port-forward svc/argocd-server -n argocd 8080:443$(NC)"

# Utilities
status: ## Show status of all resources
	@echo "$(YELLOW)=== Pods ===$(NC)"
	@kubectl get pods -A --field-selector=status.phase!=Succeeded
	@echo ""
	@echo "$(YELLOW)=== Services ===$(NC)"
	@kubectl get svc -A
	@echo ""
	@echo "$(YELLOW)=== Deployments ===$(NC)"
	@kubectl get deployments -A

forward-grafana: ## Port-forward Grafana
	kubectl port-forward svc/monitoring-grafana 3000:80 -n monitoring

forward-argocd: ## Port-forward ArgoCD
	kubectl port-forward svc/argocd-server -n argocd 8080:443
