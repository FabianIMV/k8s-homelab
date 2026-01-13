# Lab 03: Security (RBAC y Network Policies)

## 🎯 Objetivos
- Configurar RBAC (Role-Based Access Control)
- Crear ServiceAccounts
- Implementar Network Policies

## 📝 Ejercicios

### Ejercicio 1: ServiceAccount
```bash
kubectl apply -f serviceaccount.yaml
kubectl get serviceaccount
kubectl describe serviceaccount app-service-account
```

### Ejercicio 2: Role y RoleBinding
```bash
kubectl apply -f rbac.yaml

# Probar permisos
kubectl auth can-i get pods --as=system:serviceaccount:default:app-service-account
kubectl auth can-i delete pods --as=system:serviceaccount:default:app-service-account
```

### Ejercicio 3: ClusterRole
```bash
kubectl apply -f clusterrole.yaml

# Ver roles del cluster
kubectl get clusterrole | grep cluster-viewer
```

### Ejercicio 4: Network Policies
```bash
kubectl apply -f network-policy.yaml

# Probar conectividad
kubectl run curl --image=curlimages/curl --rm -it -- curl nginx

# Probar desde otro namespace (debería fallar)
kubectl create ns other
kubectl run curl --image=curlimages/curl -n other --rm -it -- curl nginx.default
```

## 🧹 Limpieza
```bash
kubectl delete -f .
kubectl delete ns other
```

## 📚 Conceptos

| Recurso | Scope | Uso |
|---------|-------|-----|
| ServiceAccount | Namespace | Identidad para pods |
| Role | Namespace | Permisos en un namespace |
| ClusterRole | Cluster | Permisos cluster-wide |
| NetworkPolicy | Namespace | Control de tráfico |
