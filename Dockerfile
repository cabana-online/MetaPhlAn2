FROM cabanaonline/miniconda:1.0

LABEL base.image="cabanaonline/miniconda:1.0"
LABEL description="A MetaPhlAn2 container."
LABEL maintainer="Alejandro Madrigal Leiva"
LABEL maintainer.email="me@alemadlei.tech"

ARG USER=cabana

ENV HOME /home/$USER

USER root

RUN \
    apt-get update && \
    apt-get install -y build-essential bowtie2;

RUN \
    pip install numpy matplotlib==1.5.3 biopython==1.76 && \
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
    rm 2.8.1.tar.gz && \
    cd MetaPhlAn-2.8.1/utils && \
    wget https://raw.githubusercontent.com/biobakery/MetaPhlAn/2.8/utils/metaphlan_hclust_heatmap.py && \
    chmod +x metaphlan_hclust_heatmap.py;

RUN \
    cd $HOME/tools && \
    git clone https://github.com/LangilleLab/microbiome_helper.git

RUN \
    conda install -c bioconda krona

# Adds the package to the path for easy access.
ENV PATH="${HOME}/tools/MetaPhlAn-2.8.1/:${PATH}"
ENV PATH="${HOME}/tools/MetaPhlAn-2.8.1/utils:${PATH}"
ENV PATH="${HOME}/tools/microbiome_helper/:${PATH}"

# Entrypoint to keep the container running.
ENTRYPOINT ["tail", "-f", "/dev/null"]
