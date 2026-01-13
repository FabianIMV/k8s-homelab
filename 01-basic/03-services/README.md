# Lab 03: Services

## 🎯 Objetivos
- Entender los tipos de Services
- Exponer aplicaciones internamente y externamente
- DNS interno de Kubernetes

## 📝 Ejercicios

### Ejercicio 1: ClusterIP (interno)
```bash
kubectl apply -f service-clusterip.yaml
kubectl get svc

# Probar desde dentro del cluster
kubectl run curl --image=curlimages/curl --rm -it -- curl nginx-clusterip
```

### Ejercicio 2: NodePort (externo)
```bash
kubectl apply -f service-nodeport.yaml
kubectl get svc

# Acceder desde el navegador
# http://localhost:<nodeport>
```

### Ejercicio 3: LoadBalancer
```bash
kubectl apply -f service-loadbalancer.yaml
kubectl get svc -w  # Esperar EXTERNAL-IP

# En Docker Desktop, será localhost:<port>
```

### Ejercicio 4: DNS interno
```bash
# Los servicios crean registros DNS automáticamente
# Formato: <service-name>.<namespace>.svc.cluster.local

kubectl run curl --image=curlimages/curl --rm -it -- \
  curl nginx-clusterip.default.svc.cluster.local
```

## 🧹 Limpieza
```bash
kubectl delete -f .
```

## 📚 Conceptos Clave

| Tipo | Uso | Acceso |
|------|-----|--------|
| ClusterIP | Interno | Solo dentro del cluster |
| NodePort | Testing | IP del nodo + puerto |
| LoadBalancer | Production | IP externa |
