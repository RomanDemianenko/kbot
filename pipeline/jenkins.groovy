pipeline {
    agent any
    
    parameters {

        choice(name: 'OS', choices: ['linux', 'darwin', 'windows', 'all'], description: 'Pick OS')
        choice(name: 'ARCH', choices: ['amd64', 'arm64', 'all'], description: 'Pick ARCH')

    }
    
    environment {
        REPO = 'https://github.com/RomanDemianenko/kbot'
        BRANCH = 'master'
    }
    stages {
        
        stage("clone") {
            steps {
            echo "CLONE REPOSITORY"
              git branch: "${BRANCH}", url: "${REPO}"
            }
        }
        
        stage("test") {
            steps {
                echo "TEST EXUCUTION STARTED"
                sh 'make test'
            }
        }
        
        stage("build") {
            steps {
                echo "Build for platform ${params.OS}"
                echo "Build for arch: ${params.ARCH}"
                sh 'make build'
            }
        }
        
        stage("image") {
            steps {
                script {
                    echo "Build for platform ${params.OS}"
                    echo "Build for arch: ${params.ARCH}"
                    echo "IMAGE EXUCUTION STARTED"
                    sh 'make image'
                }
            }
        }
        
        stage("push") {
            steps {
                script {
                    docker.withRegistry( '', 'dockerhub' ) {
                    sh 'make push'
                    }
                }
            }
        }
    }
}