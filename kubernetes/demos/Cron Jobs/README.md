# Create a Cron job
```
kubectl create -f cron-job.yaml
```

# view cronjobs
```
kubectl get cronjob
NAME      SCHEDULE      SUSPEND   ACTIVE    LAST SCHEDULE   AGE
date      */1 * * * *   False     1         Mon, 19 Feb 2018 15:28:00 -0800
```

# view jobs
```
kubectl get jobs
NAME              DESIRED   SUCCESSFUL   AGE
date-1519082820   1         1            2m
date-1519082880   1         1            1m
date-1519082940   1         0            2s
```

# view pods running the job
```
kubectl get pods -a |grep date
date-1519082820-8kjn5   0/1       Completed   0          3m
date-1519082880-kf996   0/1       Completed   0          2m
date-1519082940-6t8gg   0/1       Completed   0          1m
date-1519083000-nk98x   1/1       Running     0          5s
```

# view pods logs
```
kubectl logs date-1519083000-nk98x
Mon Feb 19 23:30:09 UTC 2018
```

# delete cronjob
```
kubectl delete cronjob date
cronjob "date" deleted
```
