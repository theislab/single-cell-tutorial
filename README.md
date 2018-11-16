# Scripts for "Best-practices in single-cell RNA-seq: a tutorial"

This repository contains the scripts used to generate the figures in the manuscript M. D. Luecken and F. J. Theis., "Best practices in single-cell RNA-seq analysis: a tutorial".

The main part of this repository is a case study where the best-practices established in the manuscript are applied to a mouse intestinal epithelium regions dataset from Haber et al., Nature 2018 available from the GEO under GSE92332.

The other scripts available here reproduce the figures that are shown in the manuscript and the supplementary material. These scripts contain comments to explain each step.

In case of questions or issues, please get in touch by posting an issue.



## Case study

To run the single cell tutorial from start to finish, several requirements must be met.

### Requirements

General:
- Jupyter notebook
- IRKernel
- rpy2
- R >= 3.4.3
- Python >= 3.5

Python:
- scanpy
- numpy
- pandas
- louvain>=0.6
- python-igraph
- mbuttner/maren_codes/combat.py

R:
- scater
- MAST
- gam
- slingshot (change DESCRIPTION file for R version 3.4.3)
- RColorBrewer
- clusterExperiment
- ggplot2

#### Application notes:

When using Slingshot in R 3.4.3, you must pull a local copy of slingshot via the github repository and change the `DESCRIPTION` file to say `R>=3.4.3` instead of `R>=3.5.0`.
