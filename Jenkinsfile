#!/usr/bin/env groovy

def openshift, git
def version='v3.0.0'
fileLoader.withGit('https://git.aurora.skead.no/scm/ao/aurora-pipeline-scripts.git', version) {
      openshift = fileLoader.load('openshift/openshift');
      git = fileLoader.load('git/git');
}

node {
  stage('Checkout') {
    checkout scm
  }

  stage('Build') {
    sh "./gradlew clean upload"
  }


  stage('Build Docker image') {
    openshift.buildImage('wingnut', git.getCommitId())
  }
}