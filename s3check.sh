BUCKET_NAME="feature/api-integration"
#NewBucketName= echo $BUCKET_NAME | tr '/' '-'
bar=${BUCKET_NAME////-}
#echo "$New_Bucket_Name"
echo $bar
echo "Checking S3 bucket exists..."                                                                                                                                                                                                           
BUCKET_EXISTS=true                                                                                                                                                                                                                            
S3_CHECK=$(aws s3 ls "s3://${bar}" 2>&1)                                                                                                                                                 

#Some sort of error happened with s3 check                                                                                                                                                                                                    
if [ $? != 0 ]                                                                                                                                                                                                                                
then                                                                                                                                                                                                                                          
  NO_BUCKET_CHECK=$(echo $S3_CHECK | grep -c 'NoSuchBucket')                                                                                                                                                                                     
  if [ $NO_BUCKET_CHECK = 1 ]; then                                                                                                                                                                                                              
    echo "Bucket does not exist" 	
    BUCKET_EXISTS=false 
    echo "creating a bucket"
    aws s3 mb s3://${bar} --region us-east-1
  else                                                                                                                                                                                                                                        
    echo "Error checking S3 Bucket"  	
    echo "$S3_CHECK"                                                                                                                                                                                                                          
    exit 1                                                                                                                                                                                                                                    
  fi 
else                                                                                                                                                                                                                                         
  echo "Bucket exists"
fi                      