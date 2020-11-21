FROM cabanaonline/miniconda:1.0

LABEL base.image="cabanaonline/miniconda:1.0"
LABEL description="A MetaPhlAn2 container."
LABEL maintainer="Alejandro Madrigal Leiva"
LABEL maintainer.email="me@alemadlei.tech"

ARG USER=cabana

ENV HOME /home/$USER

RUN \
    cd $HOME/tools && \
    wget https://github.com/biobakery/MetaPhlAn/archive/2.7.8.tar.gz && \
    tar xvzf 2.7.8.tar.gz && \
    rm 2.7.8.tar.gz

RUN \
    pip install numpy

# Adds the package to the path for easy access.
ENV PATH="${HOME}/tools/MetaPhlAn-2.7.8/:${PATH}"

# Entrypoint to keep the container running.
ENTRYPOINT ["tail", "-f", "/dev/null"]
