### Adapter pattern example

Example YAML configuration for the adapter pattern.

It defines a main application container which writes the current date and system usage information to a log file
every five seconds.

The adapter container reads what the application has written and reformats it into a structure that a hypothetical monitoring service requires.

Step 1: Apply the Adapter Pattern Manifest File

    kubectl apply -f pod.yaml

Note: Ensure the Pod is running

Step 2: Connect to the application pod

    kubectl exec pod-with-adapter -c app-container -it sh

Step 3: Take a look at what the application is writing

    cat /var/log/top.txt

Step 4: Take a look at what the adapter has reformatted it to

    cat /var/log/status.txt
