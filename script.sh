CODEBUILD_GIT_BRANCH="feature/api-integration"
BUCKET_NAME=${CODEBUILD_GIT_BRANCH////-}
echo $BUCKET_NAME
echo "Checking S3 bucket exists..."                                                                                                                                                                                                           
BUCKET_EXISTS=true                                                                                                                                                                                                                            
S3_CHECK=$(aws s3 ls "s3://${BUCKET_NAME}" 2>&1)                                                                                                                                                 

#Some sort of error happened with s3 check                                                                                                                                                                                                    
if [ $? != 0 ]                                                                                                                                                                                                                                
then                                                                                                                                                                                                                                          
  NO_BUCKET_CHECK=$(echo $S3_CHECK | grep -c 'NoSuchBucket')                                                                                                                                                                                     
  if [ $NO_BUCKET_CHECK = 1 ]; then                                                                                                                                                                                                              
    echo "Bucket does not exist" 	
    BUCKET_EXISTS=false 
    echo "creating a bucket"
    aws s3 mb s3://${BUCKET_NAME} --region us-east-1
	aws s3 sync s3://${BUCKET_NAME} 
  else                                                                                                                                                                                                                                        
    echo "Error is checking for S3 Bucket"  	
    echo "$S3_CHECK"                                                                                                                                                                                                                          
    exit 1                                                                                                                                                                                                                                    
  fi 
else                                                                                                                                                                                                                                         
  echo "Bucket is exists and start for deployment"
  aws s3 sync s3://${BUCKET_NAME}
fi                      