# Lab 03: Helm

## 🎯 Objetivos
- Instalar y usar Helm
- Desplegar charts existentes
- Crear tu propio chart

## 📝 Ejercicios

### Ejercicio 1: Instalar Helm
```bash
# Mac
brew install helm

# Verificar
helm version
```

### Ejercicio 2: Usar chart existente
```bash
# Agregar repositorio
helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo update

# Buscar charts
helm search repo nginx

# Instalar
helm install my-nginx bitnami/nginx

# Ver releases
helm list

# Desinstalar
helm uninstall my-nginx
```

### Ejercicio 3: Crear chart propio
```bash
# Crear estructura
helm create my-app

# Ver estructura
tree my-app/

# Instalar chart local
helm install my-release ./my-app

# Upgrade con valores
helm upgrade my-release ./my-app --set replicaCount=3
```

### Ejercicio 4: Usar el chart de ejemplo
```bash
cd helm-chart-example
helm install demo .
kubectl get all -l app.kubernetes.io/instance=demo
```

## 🧹 Limpieza
```bash
helm uninstall demo
helm uninstall my-release
```
