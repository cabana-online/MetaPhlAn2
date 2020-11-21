FROM cabanaonline/miniconda:1.0

LABEL base.image="cabanaonline/miniconda:1.0"
LABEL description="A MetaPhlAn2 container."
LABEL maintainer="Alejandro Madrigal Leiva"
LABEL maintainer.email="me@alemadlei.tech"

ARG USER=cabana

ENV HOME /home/$USER

USER root

RUN \
    apt-get install -y build-essential bowtie2;

RUN \
    pip install numpy biopython==1.76 && \
    pip install biom-format==2.1.7

RUN \
    apt-get remove -y build-essential && \
    apt-get clean -y && \
    apt-get autoclean -y;

USER cabana

RUN \
    cd $HOME/tools && \
    wget https://github.com/biobakery/MetaPhlAn/archive/2.8.1.tar.gz && \
    tar xvzf 2.8.1.tar.gz && \
    rm 2.8.1.tar.gz

# Adds the package to the path for easy access.
ENV PATH="${HOME}/tools/MetaPhlAn-2.8.1/:${PATH}"

# Entrypoint to keep the container running.
ENTRYPOINT ["tail", "-f", "/dev/null"]
