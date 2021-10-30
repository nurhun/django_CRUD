#!/bin/bash -x

getCommitSHA() {

     sha=$(git rev-parse --short HEAD, returnStdout: true)
     return sha
}

getCommitSHA 
