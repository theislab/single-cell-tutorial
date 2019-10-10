# 1. Install miniconda or anaconda with python version 3.6 or above.

# 2. Run the following commands for conda and pip

    conda update --all
    conda install r-essentials r-rgl
    conda install pandas numpy scipy scikit-learn jupyter gsl tzlocal simplegeneric natsort h5py tqdm patsy llvmlite numba networkx joblib numexpr pytables seaborn statsmodels pip
    conda install -c conda-forge python-igraph louvain
    
    pip install --upgrade pip
    pip install MulticoreTSNE anndata anndata2ri fa2 gprofiler-official scanpy rpy2

`MulticoreTSNE` is optional and just for speed, so leave it out if you run into problems installing it.

# 3. Start R and run the following commands:

    install.packages(c('devtools', 'gam', 'RColorBrewer', 'BiocManager'))
    update.packages(ask=F)
    BiocManager::install(c("scran","MAST","monocle","ComplexHeatmap","slingshot"), version = "3.8")
