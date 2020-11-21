FROM cabanaonline/python:1.0

LABEL base.image="cabanaonline/python:1.0"
LABEL description="A MetaPhlAn2 container."
LABEL maintainer="Alejandro Madrigal Leiva"
LABEL maintainer.email="me@alemadlei.tech"

ARG USER=cabana

ENV HOME /home/$USER

RUN \
    cd $HOME && \
    mkdir .cache && \
    chown -R $USER:$USER .cache

USER root

RUN \
    pip3 install numpy;

USER cabana

RUN \
    cd $HOME/tools && \
    wget https://github.com/biobakery/MetaPhlAn/archive/2.7.8.tar.gz && \
    tar xvzf 2.7.8.tar.gz && \
    rm 2.7.8.tar.gz;

# Adds the package to the path for easy access.
ENV PATH="${HOME}/tools/MetaPhlAn-2.7.8/:${PATH}"

# Entrypoint to keep the container running.
ENTRYPOINT ["tail", "-f", "/dev/null"]
