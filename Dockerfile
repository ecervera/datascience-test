FROM jupyter/datascience-notebook:lab-4.0.7

# Python packages
RUN pip install linearmodels==5.4

# R packages
RUN R -e "install.packages(c('methods','rstatix','estimatr'),dependencies=TRUE, repos='http://cran.rstudio.com/')"

# Make sure the contents of our repo are in ${HOME}
COPY . ${HOME}
USER root
RUN chown -R ${NB_UID} ${HOME}
USER ${NB_USER}
