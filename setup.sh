#!/bin/bash

# Colors
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
RED='\033[0;31m'
NC='\033[0m'

echo "🐳 Kubernetes Homelab Setup"
echo "==========================="
echo ""

# Check Docker
echo -n "Checking Docker... "
if command -v docker &> /dev/null && docker info &> /dev/null; then
    echo -e "${GREEN}✓ Docker is running${NC}"
else
    echo -e "${RED}✗ Docker is not running${NC}"
    echo "Please start Docker Desktop first"
    exit 1
fi

# Check kubectl
echo -n "Checking kubectl... "
if command -v kubectl &> /dev/null; then
    echo -e "${GREEN}✓ kubectl installed${NC}"
else
    echo -e "${RED}✗ kubectl not found${NC}"
    echo "Installing kubectl..."
    if [[ "$OSTYPE" == "darwin"* ]]; then
        brew install kubectl
    else
        echo "Please install kubectl manually: https://kubernetes.io/docs/tasks/tools/"
        exit 1
    fi
fi

# Check Kubernetes cluster
echo -n "Checking Kubernetes cluster... "
if kubectl cluster-info &> /dev/null; then
    echo -e "${GREEN}✓ Cluster is running${NC}"
else
    echo -e "${RED}✗ Cluster is not running${NC}"
    echo ""
    echo "Please enable Kubernetes in Docker Desktop:"
    echo "1. Open Docker Desktop"
    echo "2. Go to Settings > Kubernetes"
    echo "3. Check 'Enable Kubernetes'"
    echo "4. Click 'Apply & Restart'"
    exit 1
fi

# Check Helm
echo -n "Checking Helm... "
if command -v helm &> /dev/null; then
    echo -e "${GREEN}✓ Helm installed${NC}"
else
    echo -e "${YELLOW}⚠ Helm not found (optional, needed for intermediate/advanced labs)${NC}"
    read -p "Install Helm? (y/n) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        if [[ "$OSTYPE" == "darwin"* ]]; then
            brew install helm
        else
            curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash
        fi
    fi
fi

echo ""
echo -e "${GREEN}✓ Setup complete!${NC}"
echo ""
echo "Next steps:"
echo "  1. Run 'make check' to verify cluster status"
echo "  2. Start with: kubectl apply -f 01-basic/01-pods/"
echo "  3. Check resources: kubectl get pods"
echo ""
