FROM ubuntu:20.04

RUN apt-get update && apt-get install -y \
    openjdk-11-jdk \
    git \
    curl \
    wget \
    gnupg2 \
    unzip \
    openssh-server \
    sudo \
    docker.io \
    && apt-get clean

RUN useradd -m -s /bin/bash jenkins && echo "jenkins:jenkins" | chpasswd && adduser jenkins sudo
RUN echo 'jenkins ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

RUN mkdir /var/run/sshd \
    && mkdir /home/jenkins/.ssh && \
    echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCOXYKNtbWCQfVWZ71GO84P08cXFAWgFSt+e2hrhoCvC3P5EVBZnMPByRqTMz8W/y28g1cTg4PYTms5SjR58TrFYfnod9LhNlWZOc/rv004wqZAhaWTEkvvV7U4PBfqvUHi9+bEi+oF4J3wdFl3vjJXBZ4+9gQ/EMzSacK8rdFKsnqJ6FRrHJ5b/OSLZ/Ep47CXFGbcIhEb8qWQWC+lOXjLls1FlKn/CtgdHvLXdkhausPYorUw/ILtFA8z75y0Knh9BLucAIknmJcQbsxhTKEKH/Csvy5AjuUBfc26vw6MAqBVhsRY0T147EqLMTumeVgpW3MySVhH9HMh4JvetCEt " \
    >> /home/jenkins/.ssh/authorized_keys && \
    && chmod 700 /home/jenkins/.ssh \ 


RUN chown -R jenkins:jenkins /home/jenkins/.ssh && chmod 600 /home/jenkins/.ssh/authorized_keys

EXPOSE 22

USER jenkins

CMD ["/usr/sbin/sshd", "-D"]
