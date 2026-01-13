#!/bin/bash

# Verificar estado del cluster de Kubernetes
# Uso: ./check-cluster.sh

GREEN='\033[0;32m'
YELLOW='\033[0;33m'
RED='\033[0;31m'
NC='\033[0m'

echo "🔍 Kubernetes Cluster Health Check"
echo "===================================="
echo ""

# Check cluster
echo -e "${YELLOW}1. Cluster Info${NC}"
kubectl cluster-info 2>/dev/null
if [ $? -ne 0 ]; then
    echo -e "${RED}✗ Cannot connect to cluster${NC}"
    exit 1
fi
echo ""

# Check nodes
echo -e "${YELLOW}2. Nodes${NC}"
kubectl get nodes
echo ""

# Check system pods
echo -e "${YELLOW}3. System Pods${NC}"
kubectl get pods -n kube-system --field-selector=status.phase!=Running 2>/dev/null | grep -v "No resources"
if [ $? -eq 0 ]; then
    echo -e "${RED}⚠ Some system pods are not running${NC}"
else
    echo -e "${GREEN}✓ All system pods are running${NC}"
fi
echo ""

# Resource usage
echo -e "${YELLOW}4. Resource Usage${NC}"
kubectl top nodes 2>/dev/null || echo "Metrics server not installed"
echo ""

# Storage
echo -e "${YELLOW}5. Storage${NC}"
kubectl get pv,pvc -A 2>/dev/null || echo "No persistent volumes"
echo ""

echo -e "${GREEN}✓ Health check complete${NC}"
