FROM ubuntu:latest

RUN apt-get update && apt-get install -y \
    openjdk-11-jdk \
    git \
    curl \
    gnupg2 \
    openssh-server \
    sudo \
    && apt-get clean

# Generate default SSH host keys
RUN ssh-keygen -A

# Create Jenkins user
RUN useradd -m -s /bin/bash jenkins && echo "jenkins:jenkins" | chpasswd && adduser jenkins sudo
RUN echo 'jenkins ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

# Setup SSH for Jenkins
RUN mkdir -p /var/run/sshd \
    && mkdir -p /home/jenkins/.ssh \
    && echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCOXYKNtbWCQfVWZ71GO84P08cXFAWgFSt+e2hrhoCvC3P5EVBZnMPByRqTMz8W/y28g1cTg4PYTms5SjR58TrFYfnod9LhNlWZOc/rv004wqZAhaWTEkvvV7U4PBfqvUHi9+bEi+oF4J3wdFl3vjJXBZ4+9gQ/EMzSacK8rdFKsnqJ6FRrHJ5b/OSLZ/Ep47CXFGbcIhEb8qWQWC+lOXjLls1FlKn/CtgdHvLXdkhausPYorUw/ILtFA8z75y0Knh9BLucAIknmJcQbsxhTKEKH/Csvy5AjuUBfc26vw6MAqBVhsRY0T147EqLMTumeVgpW3MySVhH9HMh4JvetCEt" \
    >> /home/jenkins/.ssh/authorized_keys \
    && chmod 700 /home/jenkins/.ssh \
    && chmod 600 /home/jenkins/.ssh/authorized_keys \
    && chown -R jenkins:jenkins /home/jenkins/.ssh

EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]

