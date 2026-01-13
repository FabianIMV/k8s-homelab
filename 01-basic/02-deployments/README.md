# Lab 02: Deployments

## 🎯 Objetivos
- Crear y gestionar Deployments
- Escalar aplicaciones
- Realizar rolling updates
- Hacer rollbacks

## 📝 Ejercicios

### Ejercicio 1: Deployment Básico
```bash
kubectl apply -f deployment-basic.yaml
kubectl get deployments
kubectl get pods
kubectl describe deployment nginx-deployment
```

### Ejercicio 2: Scaling
```bash
# Escalar manualmente
kubectl scale deployment nginx-deployment --replicas=5
kubectl get pods -w

# Volver a 3 replicas
kubectl scale deployment nginx-deployment --replicas=3
```

### Ejercicio 3: Rolling Update
```bash
# Actualizar imagen
kubectl set image deployment/nginx-deployment nginx=nginx:1.25

# Ver progreso
kubectl rollout status deployment/nginx-deployment

# Ver historial
kubectl rollout history deployment/nginx-deployment
```

### Ejercicio 4: Rollback
```bash
# Hacer rollback a versión anterior
kubectl rollout undo deployment/nginx-deployment

# Rollback a revisión específica
kubectl rollout undo deployment/nginx-deployment --to-revision=1
```

### Ejercicio 5: Estrategias de Deploy
```bash
kubectl apply -f deployment-strategies.yaml
# Observar diferencia entre RollingUpdate y Recreate
```

## 🧹 Limpieza
```bash
kubectl delete -f .
```
