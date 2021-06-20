### Local Persistent Volume Demo

Step 1: Create a Volume

    mkdir -p /mnt/disk/vol1

Step 2: Give permissions

    chmod 777 /mnt/disk/vol1

Step 3:

    kubectl apply -f 02-lpv.yaml

Step 4:

    kubectl apply -f 03-lvpc.yaml

Step 5: Persistent volume claim is not bound to the persistent volume automatically.
Instead, it will remain „Available“ until the first consumer shows up:

    kubectl get pv

Step 6:

kubectl create -f 04-app.yaml

kubectl get pv

kubectl get pods

echo "Hello local persistent volume" > /mnt/disk/vol1/index.html

kubectl delete pod www

Look at PV status is still „Bound“, even though the POD is gone.

kubectl logs centos-local-volume

Verifying Multiple Read Access
