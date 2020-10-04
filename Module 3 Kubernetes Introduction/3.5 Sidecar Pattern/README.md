# Kubernetes-Advanced-Microfocus

Example YAML configuration for the sidecar pattern.
It defines a main application container which writes the current date to a log file every five seconds.
The sidecar container is nginx serving that log file.

In practice, your sidecar is likely to be a log collection container that uploads to external storage

Step 1: Run the Pod Manifest file

    `kubectl apply -f sidecar-pattern.yaml`

Note - Ensure Once the pod is running

Step 2: Connect to the sidecar pod

`kubectl exec pod-with-sidecar -c busyboxplus -it bash`

Step 3: Access the log file via the sidecar

    `curl 'http://localhost:80/app.txt'`
