# PowerShell Script to Bootstrap Terraform State
$BUCKET_NAME = "prod-furever-terraform-state"
$TABLE_NAME = "prod-furever-terraform-locks"
$REGION = "us-east-1"

Write-Host "Creating S3 Bucket: $BUCKET_NAME..."
aws s3api create-bucket --bucket $BUCKET_NAME --region $REGION
aws s3api put-bucket-versioning --bucket $BUCKET_NAME --versioning-configuration Status=Enabled

Write-Host "Creating DynamoDB Table: $TABLE_NAME..."
aws dynamodb create-table `
    --table-name $TABLE_NAME `
    --attribute-definitions AttributeName=LockID, AttributeType=S `
    --key-schema AttributeName=LockID, KeyType=HASH `
    --provisioned-throughput ReadCapacityUnits=1, WriteCapacityUnits=1 `
    --region $REGION

Write-Host "Bootstrap Complete!"
Write-Host "You can now uncomment the backend block in infra/terraform/environments/prod/main.tf"
