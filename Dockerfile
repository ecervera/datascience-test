FROM jupyter/datascience-notebook:lab-4.0.7

# Python packages
RUN pip install linearmodels==5.4

# R packages
RUN R -e "require(devtools)\ninstall_version('estimatr', '1.0.2', repos='http://cran.rstudio.com/')"
RUN R -e "require(devtools)\ninstall_version('plm', '2.6-3', repos='http://cran.rstudio.com/')"
RUN R -e "require(devtools)\ninstall_version('rstatix', '0.7.2', repos='http://cran.rstudio.com/')"

# Make sure the contents of our repo are in ${HOME}
COPY . ${HOME}
USER root
RUN chown -R ${NB_UID} ${HOME}
USER ${NB_USER}
