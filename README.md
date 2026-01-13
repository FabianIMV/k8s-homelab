# 🐳 Kubernetes Homelab

[![Kubernetes](https://img.shields.io/badge/Kubernetes-326CE5?style=for-the-badge&logo=kubernetes&logoColor=white)](https://kubernetes.io/)
[![Docker](https://img.shields.io/badge/Docker-2496ED?style=for-the-badge&logo=docker&logoColor=white)](https://www.docker.com/)

Un laboratorio completo de Kubernetes para práctica diaria usando Docker Desktop.

## 📋 Prerequisitos

- [Docker Desktop](https://www.docker.com/products/docker-desktop/) con Kubernetes habilitado
- [kubectl](https://kubernetes.io/docs/tasks/tools/)
- [Helm](https://helm.sh/docs/intro/install/) (para labs intermedios/avanzados)

## 🚀 Quick Start

```bash
# 1. Clonar el repositorio
git clone https://github.com/FabianIMV/k8s-homelab.git
cd k8s-homelab

# 2. Verificar que Kubernetes está corriendo
make check

# 3. Comenzar con el primer lab
kubectl apply -f 01-basic/01-pods/
```

## 📚 Estructura del Lab

### 🟢 Basic (01-basic/)
| Lab | Descripción |
|-----|-------------|
| [01-pods](./01-basic/01-pods/) | Ciclo de vida, multi-container, init containers |
| [02-deployments](./01-basic/02-deployments/) | Scaling, rolling updates, rollbacks |
| [03-services](./01-basic/03-services/) | ClusterIP, NodePort, LoadBalancer |
| [04-configmaps-secrets](./01-basic/04-configmaps-secrets/) | Configuración y secretos |
| [05-namespaces](./01-basic/05-namespaces/) | Aislamiento y resource quotas |

### 🟡 Intermediate (02-intermediate/)
| Lab | Descripción |
|-----|-------------|
| [01-ingress](./02-intermediate/01-ingress/) | NGINX Ingress, routing |
| [02-persistent-storage](./02-intermediate/02-persistent-storage/) | PV, PVC, StorageClasses |
| [03-helm](./02-intermediate/03-helm/) | Creación de charts, values |
| [04-statefulsets](./02-intermediate/04-statefulsets/) | Aplicaciones stateful |
| [05-jobs-cronjobs](./02-intermediate/05-jobs-cronjobs/) | Tareas batch y programadas |

### 🔴 Advanced (03-advanced/)
| Lab | Descripción |
|-----|-------------|
| [01-monitoring](./03-advanced/01-monitoring/) | Prometheus + Grafana |
| [02-argocd](./03-advanced/02-argocd/) | GitOps deployment |
| [03-security](./03-advanced/03-security/) | RBAC, NetworkPolicies |
| [04-service-mesh](./03-advanced/04-service-mesh/) | Istio basics |

## 🛠️ Comandos Útiles

```bash
make check          # Verificar estado del cluster
make clean          # Limpiar todos los recursos del lab
make reset          # Reset completo del lab

# Labs específicos
make basic          # Desplegar todos los labs básicos
make intermediate   # Desplegar todos los labs intermedios
make monitoring     # Desplegar stack de monitoreo
make argocd         # Instalar ArgoCD
```

## 📖 Comandos kubectl Esenciales

```bash
# Pods
kubectl get pods -A                    # Ver todos los pods
kubectl describe pod <name>            # Detalles de un pod
kubectl logs <pod> -f                  # Ver logs en tiempo real
kubectl exec -it <pod> -- /bin/sh      # Entrar al pod

# Deployments
kubectl scale deployment <name> --replicas=3
kubectl rollout status deployment <name>
kubectl rollout undo deployment <name>

# Debugging
kubectl get events --sort-by='.lastTimestamp'
kubectl top pods                       # Uso de recursos
```

## 🗂️ Aplicaciones de Ejemplo

En `apps/` encontrarás aplicaciones listas para practicar:
- **nginx-demo**: Servidor web estático
- **flask-api**: API REST en Python
- **redis-cluster**: Aplicación stateful

## 🧹 Limpieza

```bash
# Eliminar recursos de un lab específico
kubectl delete -f 01-basic/01-pods/

# Eliminar todo
make clean
```

## 📝 Tips

1. **Siempre verifica** que Docker Desktop Kubernetes esté habilitado
2. **Usa namespaces** para aislar tus experimentos
3. **Guarda tus cambios** antes de hacer rollback
4. **Monitorea recursos** con `kubectl top nodes`

---

Made with ❤️ for learning Kubernetes