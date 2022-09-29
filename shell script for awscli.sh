echo "List of Running instances"
for REGION in $(aws ec2 describe-regions --output text --query 'Regions[].[RegionName]') ; do echo $REGION && aws ec2 describe-instances --query "Reservations[*].Instances[*].{PublicIP:PublicIpAddress,PrivateIP:PrivateIpAddress,Name:Tags[?Key=='Name']|[0].Value,Type:InstanceType,Status:State.Name,VpcId:VpcId}" --filters Name=instance-state-name,Values=running --region $REGION; done
echo "list of stopped instances"
for REGION in $(aws ec2 describe-regions --output text --query 'Regions[].[RegionName]') ; do echo $REGION && aws ec2 describe-instances --query "Reservations[*].Instances[*].{PublicIP:PublicIpAddress,PrivateIP:PrivateIpAddress,Name:Tags[?Key=='Name']|[0].Value,Type:InstanceType,Status:State.Name,VpcId:VpcId}" --filters Name=instance-state-name,Values=stopped --region $REGION; done

echo "List of IAM users"
aws iam list-users --output text | cut -f 6

echo "List of IAM Users with ID"
aws iam list-users

echo "List of access key"

aws iam list-access-keys

echo "List of Groups names"
aws iam list-groups

echo "List of security group"

#aws ec2 describe-security-groups

echo "List all AMI"
aws ec2 describe-images --filter "Name=is-public,Values=false" \--query 'Images[].[ImageId, Name]' \--output text | sort -k2

echo "Lis of all EBS volume"

for REGION in $(aws ec2 describe-regions --output text --query 'Regions[].[RegionName]') ; do echo $REGION && aws ec2 describe-volumes --filter "Name=status,Values=in-use" --query 'Volumes[*].{VolumeID:VolumeId,Size:Size,Type:VolumeType,AvailabilityZone:AvailabilityZone}' --region $REGION; done

echo "List of ec2"

for REGION in $(aws ec2 describe-regions --output text --query 'Regions[].[RegionName]') ; do echo $REGION && aws ec2 describe-instances     --filters Name=tag-key,Values=Name     --query 'Reservations[*].Instances[*].{Instance:InstanceId,AZ:Placement.AvailabilityZone,Name:Tags[?Key==`Name`]|[0].Value}'   --region $REGION; done

echo "Snap shot list"

aws ec2 describe-snapshots --owner-ids self  --query 'Snapshots[]'


echo "List of Cloud Frount"
#An error occurred (AccessDenied) when calling the ListDistributions operation: User: arn:aws:iam::539355717448:user/Ashok.k is not authorized to perform: cloudfront:ListDistributions because no identity-based policy allows the cloudfront:ListDistributions action
#aws cloudfront list-distributions
