FROM ubuntu:16.04

RUN apt-get update && apt-get install -y openssh-server git npm nodejs curl nano

RUN mkdir /var/run/sshd
RUN echo 'root:password' | chpasswd
RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile
# RUN git clone https://github.com/finkegabriel/elasticNode.git 

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]


ENV NVM_DIR ~/.nvm # or ~/.nvm , depending
# ENV NODE_VERSION 0.10.33

# Install nvm with node and npm
RUN git clone https://raw.githubusercontent.com/creationix/nvm/v0.20.0/install.sh | bash \
    # && . $NVM_DIR/nvm.sh \
    # && nvm install $NODE_VERSION \
    # && nvm alias default $NODE_VERSION \
    # && nvm use default

# ENV NODE_PATH $NVM_DIR/v$NODE_VERSION/lib/node_modules
# ENV PATH      $NVM_DIR/v$NODE_VERSION/bin:$PATH