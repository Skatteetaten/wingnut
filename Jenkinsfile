#!groovy

node {

  def openshift, git
  fileLoader.withGit('https://git.sits.no/git/scm/ao/aurora-pipeline-scripts.git', 'v3.1.0') {
    openshift = fileLoader.load('openshift/openshift');
    git = fileLoader.load('git/git');
  }


  stage('Checkout') {
    checkout scm
  }


  stage('Bygg OpenShift-image') {
    def commitId = git.getCommitId()
    openshift.buildImage('wingnut', commitId)
  }

}
