# Lab 04: ConfigMaps y Secrets

## 🎯 Objetivos
- Externalizar configuración con ConfigMaps
- Manejar datos sensibles con Secrets
- Montar como variables de entorno o archivos

## 📝 Ejercicios

### Ejercicio 1: ConfigMap desde literal
```bash
kubectl create configmap app-config --from-literal=APP_ENV=production --from-literal=LOG_LEVEL=info
kubectl get configmap app-config -o yaml
```

### Ejercicio 2: ConfigMap desde archivo
```bash
kubectl apply -f configmap.yaml
kubectl describe configmap nginx-config
```

### Ejercicio 3: Secret
```bash
kubectl apply -f secret.yaml

# Ver secret (base64 encoded)
kubectl get secret db-credentials -o yaml

# Decodificar
kubectl get secret db-credentials -o jsonpath='{.data.password}' | base64 -d
```

### Ejercicio 4: Usar en Pod
```bash
kubectl apply -f pod-with-config.yaml
kubectl exec pod-with-config -- env | grep -E 'DB_|APP_'
kubectl exec pod-with-config -- cat /etc/config/nginx.conf
```

## 🔒 Buenas Prácticas

- Nunca guardes secrets en git
- Usa herramientas como sealed-secrets o external-secrets en producción
- Configura RBAC para limitar acceso a secrets

## 🧹 Limpieza
```bash
kubectl delete -f .
kubectl delete configmap app-config
```
