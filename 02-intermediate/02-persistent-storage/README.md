# Lab 02: Persistent Storage

## 🎯 Objetivos
- Entender PersistentVolumes y PersistentVolumeClaims
- Usar StorageClasses
- Persistir datos entre reinicios de pods

## 📝 Ejercicios

### Ejercicio 1: PVC Simple
```bash
kubectl apply -f pvc-simple.yaml
kubectl get pv,pvc

# Ver datos persistidos
kubectl exec pod-with-pvc -- ls /data
kubectl exec pod-with-pvc -- sh -c "echo 'test data' > /data/test.txt"

# Eliminar y recrear pod
kubectl delete pod pod-with-pvc
kubectl apply -f pvc-simple.yaml

# Verificar que los datos persisten
kubectl exec pod-with-pvc -- cat /data/test.txt
```

### Ejercicio 2: StorageClass
```bash
kubectl get storageclass
kubectl describe storageclass hostpath
```

### Ejercicio 3: MySQL con Persistencia
```bash
kubectl apply -f mysql-persistent.yaml

# Conectar a MySQL
kubectl exec -it mysql -- mysql -uroot -ppassword

# Crear datos, eliminar pod, verificar que persisten
```

## 🧹 Limpieza
```bash
kubectl delete -f .
```

## 📚 Conceptos

| Recurso | Descripción |
|---------|-------------|
| PV | Almacenamiento del cluster |
| PVC | Solicitud de almacenamiento |
| StorageClass | Provisioner dinámico |
