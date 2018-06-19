#!groovy

node {
  def openshift, git
  def version="feature/AOT-177"
  fileLoader.withGit('https://git.aurora.skead.no/scm/ao/aurora-pipeline-scripts.git', version) {
    openshift = fileLoader.load('openshift/openshift');
    git = fileLoader.load('git/git');
  }

  stage('Checkout') {
    checkout scm
  }

  stage('Bygg OpenShift-image') {
    def commitId = git.getCommitId()
    openshift.buildImageWithCredentials('wingnut', commitId, 'github')
  }

}
