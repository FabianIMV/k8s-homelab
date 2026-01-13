# Lab 05: Namespaces

## 🎯 Objetivos
- Crear y usar namespaces para aislamiento
- Establecer Resource Quotas
- Configurar LimitRanges

## 📝 Ejercicios

### Ejercicio 1: Crear Namespace
```bash
kubectl create namespace lab-dev
kubectl create namespace lab-prod

# Listar namespaces
kubectl get ns
```

### Ejercicio 2: Desplegar en Namespace
```bash
kubectl apply -f namespace-demo.yaml

# Ver recursos en un namespace específico
kubectl get pods -n lab-demo
kubectl get all -n lab-demo
```

### Ejercicio 3: Resource Quotas
```bash
kubectl apply -f resource-quota.yaml

# Ver quota
kubectl describe quota -n lab-demo

# Intentar exceder quota
kubectl run test --image=nginx -n lab-demo
```

### Ejercicio 4: Cambiar Namespace por defecto
```bash
# Usar namespace temporalmente
kubectl config set-context --current --namespace=lab-demo

# Volver a default
kubectl config set-context --current --namespace=default
```

## 🧹 Limpieza
```bash
kubectl delete ns lab-demo lab-dev lab-prod
```

## 📚 Conceptos Clave

- **Namespace**: Cluster virtual dentro del cluster
- **Resource Quota**: Límites a nivel de namespace
- **LimitRange**: Defaults y límites para pods/containers
