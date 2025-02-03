# Simple azure infra with vms
1. Create a new resource group
2. Create a new virtual network
3. Create a new subnet
4. Create a new network security group with rules to allow traffic from load balancer
5. Create nsg and subnet association
6. Create vm scale set with autoscale rules
7. Create a load balancer with vm scaleset as the backend pool on probe port 80
8. Create a public ip for the load balancer which allow inbound traffic from the internet
8. Create a NAT gateway to allow traffic from VMs to the internet.