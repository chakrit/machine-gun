#!/usr/local/bin/docker
FROM centos
RUN yum groupinstall -y --setopt=group_package_types=mandatory,default,optional 'Development Tools'
RUN yum install -y git wget ruby ruby-devel libffi-devel

# install go 1.5.2 from release tarball.
RUN cd /tmp && wget https://storage.googleapis.com/golang/go1.5.2.linux-amd64.tar.gz
RUN tar -C /usr/local -xzf /tmp/go1.5.2.linux-amd64.tar.gz
RUN ln -s /usr/local/go/bin/go /usr/local/bin/go

RUN gem install bundler
