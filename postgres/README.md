# Creating RDS with Terraform

With this *Terraform* code we create:
- Amazon Relational Database Service
- Secret Manager
- Secret (password for rds)

Commands to use:
...
terraform init
terraform plan
terraform apply
...
# Steps
- Go --> backend folder and run terrafrom commands(init,plan,apply)
- Go --> backend folder and run terrafrom commands(init,plan,apply)
- To get password we need to open SecretsManager from AWS Console and retrieve it from there 


# Logging into the database manual
1. create a bastion host (make sure to add bastion security group into the db security group and open your db port)
2. SSH into the bastion host
3. Install _psql_client [https://unix.stackexchange.com/questions/249494/install-postgresql-client-psql-only-on-centos]
4. Use the following command to log into the database
   
   psql --host="DB instance endpoint" --port="port" --username="username" --"password" --dbname="database name"

   More info about how to log into the database [https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_ConnectToPostgreSQLInstance.html]


# Requirements
1. Must create s3 bucket first before sending your backend
2. Backend needs to be hardcoded, otherwise it won't work with terraform

# Issues
1. My database was unreachable because I forgot to open 5432 port (postgres port)
2. When I tried to create secret password it showed me an error. An issue is you can NOT create secret with the same name(You must create it a new name,because when it's deleted it takes 7 days for AWS to remove it)