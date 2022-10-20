# 1. Install miniconda or anaconda with python version 3.8 or above.

# 2. Run the following commands for conda and pip

    conda update --all
    conda install r-essentials r-rgl
    conda install pandas numpy scipy scikit-learn jupyter gsl tzlocal simplegeneric natsort h5py tqdm patsy llvmlite numba networkx joblib numexpr pytables seaborn statsmodels pip
    conda install -c conda-forge python-igraph louvain leidenalg
    
    pip install --upgrade pip
    pip install MulticoreTSNE anndata anndata2ri fa2 gprofiler-official scanpy rpy2 scrublet

`MulticoreTSNE` is optional and just for speed, so leave it out if you run into problems installing it.


# 3. Start R and run the following commands:

    install.packages(c('devtools', 'gam', 'RColorBrewer', 'BiocManager'))
    update.packages(ask=F)
    BiocManager::install(c("scran","MAST","monocle","ComplexHeatmap","slingshot", "DropletUtils"), version = "3.15")

The version of the `BiocManager` may depend on the installed R version (here `R>=4.2`).  

# Troubleshooting

## MulticoreTSNE
A current workaround (as of 23/09/2022) to install `MulticoreTSNE` is to clone the `git` repository, adjust the `setup.py` and install manually as follows (solution provided by [Lisa Barros](https://github.com/lisa-sousa)):

```
git clone https://github.com/DmitryUlyanov/Multicore-TSNE.git
```
Then open the `setup.py` and replace `self.cmake_args or "--",` by `self.cmake_args or "",`. 

Then install via
```
python setup.py install
```
