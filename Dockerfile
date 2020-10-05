FROM debian:10

ENV DEBIAN_FRONTEND=noninteractive

# Install system libraries required for python and R installations
RUN apt-get update && apt-get install -y --no-install-recommends build-essential apt-utils ca-certificates zlib1g-dev gfortran locales libxml2-dev libcurl4-openssl-dev libssl-dev libzmq3-dev libreadline6-dev xorg-dev libcairo-dev libpango1.0-dev libbz2-dev liblzma-dev libffi-dev libsqlite3-dev nodejs npm

# Install common linux tools
RUN apt-get update && apt-get install -y --no-install-recommends wget curl htop less nano vim emacs git

# Configure default locale
RUN echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen \
    && locale-gen en_US.utf8 \
    && /usr/sbin/update-locale LANG=en_US.UTF-8


# Download and compile R from source
WORKDIR /opt/R
RUN wget https://cran.rstudio.com/src/base/R-3/R-3.6.3.tar.gz
RUN tar xvfz R-3.6.3.tar.gz && rm R-3.6.3.tar.gz

WORKDIR /opt/R/R-3.6.3
RUN ./configure --enable-R-shlib --with-cairo --with-libpng --prefix=/opt/R/
RUN make && make install

WORKDIR /opt/R
RUN rm -rf /opt/R/R-3.6.3
ENV PATH="/opt/R/bin:${PATH}"
ENV LD_LIBRARY_PATH="/opt/R/lib/R/lib:${LD_LIBRARY_PATH}"

RUN Rscript -e "update.packages(ask=FALSE, repos='https://ftp.gwdg.de/pub/misc/cran/')"
RUN Rscript -e "install.packages(c('devtools', 'gam', 'RColorBrewer', 'BiocManager', 'IRkernel'), repos='https://ftp.gwdg.de/pub/misc/cran/')"
RUN Rscript -e "devtools::install_github(c('patzaw/neo2R', 'patzaw/BED'))"
RUN Rscript -e "BiocManager::install(c('scran','MAST','monocle','ComplexHeatmap','limma','slingshot','clusterExperiment','DropletUtils'), version = '3.10')"
RUN Rscript -e 'writeLines(capture.output(sessionInfo()), "../package_versions_r.txt")' --default-packages=scran,RColorBrewer,slingshot,monocle,gam,clusterExperiment,ggplot2,plyr,MAST,DropletUtils,IRkernel


# Download and compile python from source
WORKDIR /opt/python
RUN wget https://www.python.org/ftp/python/3.7.7/Python-3.7.7.tgz
RUN tar zxfv Python-3.7.7.tgz && rm Python-3.7.7.tgz

WORKDIR /opt/python/Python-3.7.7
RUN ./configure --enable-optimizations --with-lto --prefix=/opt/python/
RUN make && make install

WORKDIR /opt/python
RUN rm -rf /opt/python/Python-3.7.7
RUN ln -s /opt/python/bin/python3 /opt/python/bin/python
RUN ln -s /opt/python/bin/pip3 /opt/python/bin/pip
ENV PATH="/opt/python/bin:${PATH}"

RUN pip install --no-cache-dir -U pip wheel setuptools cmake
RUN pip install --no-cache-dir -U scanpy==1.4.6 python-igraph==0.8.0 louvain==0.6.1 jupyterlab=2.1.0 cellxgene==0.15.0 rpy2==3.2.7 anndata2ri==1.0.2 leidenalg==0.7.0 fa2==0.3.5 MulticoreTSNE==0.1 scvelo==0.1.25 diffxpy==0.7.4 tables==3.5.1 ipywidgets==7.5.1 jupyter_contrib_nbextensions==0.5.1 gprofiler-official==1.0.0 scrublet==0.2.1 xlsxwriter xlrd==1.2.0 tensorflow==2.1.0 tensorflow-probability==0.9.0
RUN pip install --no-cache-dir git+https://github.com/le-ander/epiScanpy.git
RUN jupyter contrib nbextension install --system
RUN jupyter nbextension enable --py widgetsnbextension

RUN pip freeze > ../package_versions_py.txt

RUN Rscript -e "IRkernel::installspec(user = FALSE)"

COPY .bashrc_docker /root/.bashrc
COPY .profile_docker /root/.profile

RUN apt-get clean -y && apt-get autoremove -y
