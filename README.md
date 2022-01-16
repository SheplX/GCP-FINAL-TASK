# GCP-FINAL-TASK
- Hey everyone ! i hope everything is okey :)
- Today i had deployed a python app using terraform, docker and GCP services 
- This app created & Dockerized with a Dockerfile & some structure files, u can check them from [here](https://github.com/SheplX/GCP-FINAL-TASK/tree/main/DevOps-Challenge-Demo-Code-master)
- Sure u can try it, so lets start :D

# Requirements :

- GNU/Linux
- `python` >= 3.7
- `pip` >= 9.0
- `redis` >= 5.0

# Installation :

# Step 1 : Setting up & building the required infrastrature :

- Lets say that u already have an configured GCP account
- Download the source code
- Navigate to [Terraform-Files](https://github.com/SheplX/GCP-FINAL-TASK/tree/main/Terraform-Files) folder run the following commands :
```
terraform init
terraform plan
terraform apply
```
# Step 2 : Connect to ur environment :

- After u apply terraform files, navigate to GCP and check ur project > instances
- Ssh the private instance using iap tunnel connection
- Try to connect the created cluster inside it

# Step 3 : Setting up kubectl tool & applying deployment files & launching ur application :

- First u need to install kubectl at ur new machine using this command :
```
sudo apt-get install kubectl
```
- Move to [Deployment-Files](https://github.com/SheplX/GCP-FINAL-TASK/tree/main/Deploymet-Files) and apply all the files there using this command :
```
kubectl apply -f <file_name>
```
- U can check if everything is ok and running by using this command :
```
watch kubectl get all
```
- In services field u can check lb-services line in External-ip just take it and switch it on port 8000

# Grats & Cheers !

- [Here](https://github.com/SheplX/GCP-FINAL-TASK/tree/main/ScreenShots) is some screenshots during my project steps, plz feel free to check them.

![Image](https://github.com/SheplX/GCP-FINAL-TASK/blob/main/ScreenShots/Screenshot%20from%202022-01-15%2004-59-24.png)

