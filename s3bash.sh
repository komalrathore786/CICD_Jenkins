S3_BUCKET="devops111"

if [ $(aws s3 ls "s3://$S3_BUCKET" | grep 'NoSuchBucket' &> /dev/null) == 0 ]
then
  echo "$S3_BUCKET doesn\'t exist please check again"
else
  echo "bucket exists"
fi
