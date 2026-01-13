# Lab 01: Ingress

## 🎯 Objetivos
- Instalar NGINX Ingress Controller
- Configurar routing basado en path y host
- Usar TLS

## 📝 Ejercicios

### Ejercicio 1: Instalar Ingress Controller
```bash
# Usando Makefile
make ingress

# O manualmente
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.8.2/deploy/static/provider/cloud/deploy.yaml

# Esperar a que esté listo
kubectl wait --namespace ingress-nginx \
  --for=condition=ready pod \
  --selector=app.kubernetes.io/component=controller \
  --timeout=120s
```

### Ejercicio 2: Path-based Routing
```bash
kubectl apply -f ingress-path.yaml

# Probar
curl localhost/app1
curl localhost/app2
```

### Ejercicio 3: Host-based Routing
```bash
kubectl apply -f ingress-host.yaml

# Agregar a /etc/hosts
# 127.0.0.1 app1.local app2.local

# Probar
curl app1.local
curl app2.local
```

## 🧹 Limpieza
```bash
kubectl delete -f .
```

## 📚 Tips
- En Docker Desktop, Ingress usa localhost
- Los hosts virtuales requieren modificar /etc/hosts
