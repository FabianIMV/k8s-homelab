# Lab 01: Pods

## 🎯 Objetivos
- Entender qué es un Pod
- Crear pods simples y multi-container
- Usar init containers
- Debuggear pods

## 📝 Ejercicios

### Ejercicio 1: Pod Simple
```bash
kubectl apply -f pod-simple.yaml
kubectl get pods
kubectl describe pod nginx-simple
kubectl logs nginx-simple
```

### Ejercicio 2: Pod Multi-Container
```bash
kubectl apply -f pod-multi-container.yaml
kubectl logs multi-container -c nginx
kubectl logs multi-container -c sidecar
```

### Ejercicio 3: Init Container
```bash
kubectl apply -f pod-init-container.yaml
kubectl get pods -w  # Watch hasta que esté Ready
```

### Ejercicio 4: Pod con Resources
```bash
kubectl apply -f pod-resources.yaml
kubectl describe pod nginx-resources | grep -A5 "Limits\|Requests"
```

## 🧹 Limpieza
```bash
kubectl delete -f .
```

## 📚 Conceptos Clave

- **Pod**: Unidad mínima de despliegue en Kubernetes
- **Multi-container**: Containers que comparten recursos
- **Init container**: Se ejecutan antes de los containers principales
- **Resources**: Límites y requests de CPU/memoria
