### HostPath Volume Demo

Step 1: Create a Folder on the Kubernetes Node

    mkdir -p /mnt/data/vol

    chmod 777 /mnt/data/vol

Step 2: Create a Persistent Volume

    kubectl create -f 01-Persistent-Volume.yaml

Step 3: Verify the Volumes

    kubectl get pv

Step 4: Show more details about the Volume

    kubectl get pv vol -o yaml

Step 5: Create Persistent Volume

    kubectl apply -f 02-Persistent-Volume-Claim.yaml

Step 6: Verify the PVC Status

    kubectl get pvc

Step 7: Describe and Verify the PVC

    kubectl describe pvc http-claim

Step 8: Create and Run the application pod

    kubectl apply -f 03-app.yaml

Step 9: Add data to the Volume

    echo "Hello Team, How are you Doing" > /mnt/data/vol/index.html

Step 10: Now try to access the pod and see the application

Step 11: Now Lets change the Value, by being inside the container

    echo "Changed the content from container" > /usr/share/nginx/html/index.html

Step 12: Lets Delete the Pod and see weather data persists or not

    kubectl delete pod www

Step 13: Check PVC

    kubectl get pvc

Step 14: Create a new pod with older Volume

    kubectl apply -f 04-newpod.yaml

Step 16: Verify weather we are able to read the index.html using the new pod

    kubectl logs centos
