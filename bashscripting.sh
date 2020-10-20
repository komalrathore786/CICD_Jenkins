#CODEBUILD_GIT_BRANCH="master"
#CODEBUILD_GIT_TAG="qa-002"
#Branch_Name="master"
#Git_Tag="qa-"


#if [[ $CODEBUILD_GIT_BRANCH == $Branch_Name ]];
          #then
           # echo 'master branch confirm'
             if [[ $CODEBUILD_GIT_TAG == $Git_Tag* ]];
             then
               echo 'qa tag is confirmed'
               sam package --template-file template.yaml --output-template-file packaged.yaml --s3-bucket komal-cicd1210
               sam deploy --template-file packaged.yaml --stack-name komalcicd --s3-bucket komal-cicd1210
             else
               echo "this is dev environment"
             fi
#fi