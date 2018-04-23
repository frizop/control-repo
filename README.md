# Control Repo

This is a testing control repo which I'm using to test stuff. For now, I'm working on getting the testing components properly setup.

# Setup of testing

The expectation here is to be doing all testing inside of a container

## Jenkins

The `Jenkinsfile` included can get you setup if you've bound the docker socket into the jenkins container. I used the following command to launch it:

    docker run -u root -d -p 8080:8080 -p 50000:50000 \
        --env JAVA_OPTS="-Xmx1024m -XX:MaxPermSize=512m" \
        --name jenkins -v /mnt/config/jenkins:/var/jenkins_home \
        -v /var/run/docker.sock:/var/run/docker.sock \
        jenkinsci/blueocean

Create a new project, and then point the project at this repo. That should be all you need to do, as the `Jenkinsfile` has the setup to get things situated.

Just to note here, the contents of the Jenkinsfile expects to be able to build docker containers, without that there will be a bunch of manual work converting the repo over.

## Building without jenkins

If however, you want to build this locally without Jenkins `sudo docker build -t "local/puppet-rake" .` will get you a locally built image that you can run like this in the base of this control-repo: `docker run -it --rm -v "$PWD":/usr/src local/puppet-rake /bin/bash` 
From inside the image go ahead and `cd /usr/src` and now you can run your `bundle exec rake -T` or whatever you want to test for.

Also, if you're running selinux, you might need to set svirt_sandbox_file_t on the repo's root `sudo chcon -Rt svirt_sandbox_file_t .`

# Test Cases

## Rubocop

## RSpec

## Puppet Lint

## Puppet Parser Validate