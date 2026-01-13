# Lab 05: Jobs y CronJobs

## 🎯 Objetivos
- Ejecutar tareas batch con Jobs
- Programar tareas recurrentes con CronJobs
- Manejar paralelismo y completions

## 📝 Ejercicios

### Ejercicio 1: Job Simple
```bash
kubectl apply -f job-simple.yaml
kubectl get jobs
kubectl get pods

# Ver logs
kubectl logs job/hello-job
```

### Ejercicio 2: Job con Completions
```bash
kubectl apply -f job-parallel.yaml

# Ver progreso
kubectl get pods -w

# Ver resultado
kubectl describe job parallel-job
```

### Ejercicio 3: CronJob
```bash
kubectl apply -f cronjob.yaml

# Ver cronjobs
kubectl get cronjobs

# Ver jobs creados
kubectl get jobs -w

# Ver último job
kubectl get pods --sort-by=.metadata.creationTimestamp
```

### Ejercicio 4: Suspender CronJob
```bash
kubectl patch cronjob hello-cron -p '{"spec":{"suspend":true}}'
```

## 🧹 Limpieza
```bash
kubectl delete -f .
```

## 📚 Cron Syntax
```
┌───────────── minuto (0 - 59)
│ ┌───────────── hora (0 - 23)
│ │ ┌───────────── día del mes (1 - 31)
│ │ │ ┌───────────── mes (1 - 12)
│ │ │ │ ┌───────────── día de la semana (0 - 6)
│ │ │ │ │
* * * * *

Ejemplos:
*/5 * * * *    # Cada 5 minutos
0 * * * *      # Cada hora
0 0 * * *      # Medianoche
0 9 * * 1-5    # 9am Lun-Vie
```
