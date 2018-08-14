#!/usr/bin/env groovy

node('master') {
environment {
    AWS_BIN = '/home/tomcat/.local/bin/aws'
}
 try {
  stage('build'){
   checkout scm
   env.TF_HOME="${tool 'terraform_0.11.7'}"   
   env.PATH="${env.TF_HOME}:${env.WORKSPACE}:${env.PATH}"
   withCredentials([[
            $class: 'AmazonWebServicesCredentialsBinding',
            credentialsId: 'aws-keys',
            accessKeyVariable: 'AWS_ACCESS_KEY_ID',
            secretKeyVariable: 'AWS_SECRET_ACCESS_KEY'
   ]]) {
    sh "AWS_DEFAULT_REGION=eu-west-2"
	sh "AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID}"
	sh "AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY}"
	sh "terraform init -input=false"
   }
  }
  
  stage ('plan'){
   env.TF_HOME="${tool 'terraform_0.11.7'}"   
   env.PATH="${env.TF_HOME}:${env.WORKSPACE}:${env.PATH}"
   withCredentials([[
            $class: 'AmazonWebServicesCredentialsBinding',
            credentialsId: 'aws-keys',
            accessKeyVariable: 'AWS_ACCESS_KEY_ID',
            secretKeyVariable: 'AWS_SECRET_ACCESS_KEY'
   ]]) {
    sh "AWS_DEFAULT_REGION=eu-west-2"
	sh "AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID}"
	sh "AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY}"
	sh "terraform plan -out plan.plan"
   }
  }
  
  stage ('show-plan'){
   env.TF_HOME="${tool 'terraform_0.11.7'}"   
   env.PATH="${env.TF_HOME}:${env.WORKSPACE}:${env.PATH}"
   withCredentials([[
            $class: 'AmazonWebServicesCredentialsBinding',
            credentialsId: 'aws-keys',
            accessKeyVariable: 'AWS_ACCESS_KEY_ID',
            secretKeyVariable: 'AWS_SECRET_ACCESS_KEY'
   ]]) {
    sh "AWS_DEFAULT_REGION=eu-west-2"
	sh "AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID}"
	sh "AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY}"
	sh "terraform show plan.plan"
   }
  }  
  
  stage ('apply'){
   env.TF_HOME="${tool 'terraform_0.11.7'}"   
   env.PATH="${env.TF_HOME}:${env.WORKSPACE}:${env.PATH}"
   withCredentials([[
            $class: 'AmazonWebServicesCredentialsBinding',
            credentialsId: 'aws-keys',
            accessKeyVariable: 'AWS_ACCESS_KEY_ID',
            secretKeyVariable: 'AWS_SECRET_ACCESS_KEY'
   ]]) {
    sh "AWS_DEFAULT_REGION=eu-west-2"
	sh "AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID}"
	sh "AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY}"
	sh "terraform apply plan.plan"
   }
  }
 } catch(error) {
  throw error
 } finally {
  // Recursively delete all files and folders in the workspace
  // using the built-in pipeline command
  stage('terminate'){
   env.TF_HOME="${tool 'terraform_0.11.7'}"   
   env.PATH="${env.TF_HOME}:${env.WORKSPACE}:${env.PATH}"
   withCredentials([[
            $class: 'AmazonWebServicesCredentialsBinding',
            credentialsId: 'aws-keys',
            accessKeyVariable: 'AWS_ACCESS_KEY_ID',
            secretKeyVariable: 'AWS_SECRET_ACCESS_KEY'
   ]]) {
    sh "AWS_DEFAULT_REGION=eu-west-2"
	sh "AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID}"
	sh "AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY}"
	sh "terraform destroy -force"
	// Git committer email
    // GIT_COMMIT_EMAIL = sh (
    // script: 'git --no-pager show -s --format=\'%ae\'',
    // returnStdout: true
    // ).trim()
    // echo "Git committer email: ${GIT_COMMIT_EMAIL}"
	// sh "aws ec2 terminate-instances --instance-ids i-07dfb3b74e52ed67b"
   }
   
  }
  deleteDir()
 }
}
