
#!/usr/bin/env groovy

node('master') {
 try {
  stage('build'){
   checkout scm
   env.TF_HOME="${tool 'terraform_0.11.7'}"   
   env.PATH="${env.TF_HOME}:${env.WORKSPACE}:${env.PATH}"
   withCredentials([usernamePassword(credentialsId: 'aws-keys', passwordVariable: 'AWS_SECRET_ACCESS_KEY', usernameVariable: 'AWS_ACCESS_KEY_ID')]) {
    sh "terraform init -input=false"
   }
  }
  
  stage ('plan'){
   withCredentials([usernamePassword(credentialsId: 'aws-keys', passwordVariable: 'AWS_SECRET_ACCESS_KEY', usernameVariable: 'AWS_ACCESS_KEY_ID')]) {
    sh "terraform plan -out plan.plan"
   }
  }
  
  stage ('show-plan'){
   withCredentials([usernamePassword(credentialsId: 'aws-keys', passwordVariable: 'AWS_SECRET_ACCESS_KEY', usernameVariable: 'AWS_ACCESS_KEY_ID')]) {
    sh "terraform show plan.plan"
   }
  }  
  
 } catch(error) {
  throw error
 } finally {
  // Recursively delete all files and folders in the workspace
  // using the built-in pipeline command
  deleteDir()
 }
}
