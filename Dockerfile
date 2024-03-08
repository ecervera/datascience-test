FROM jupyter/datascience-notebook:lab-4.0.7

# Python packages
RUN pip install linearmodels==5.4

# R packages
#RUN R -e "install.packages('estimatr', dependencies=TRUE, repos='http://cran.rstudio.com/')"
RUN R -e "install_version('plm', '2.6-3')"
#RUN R -e "install.packages('plm', dependencies=TRUE, repos='http://cran.rstudio.com/')"
#RUN R -e "install.packages('rstatix', dependencies=TRUE, repos='http://cran.rstudio.com/')"

# Make sure the contents of our repo are in ${HOME}
COPY . ${HOME}
USER root
RUN chown -R ${NB_UID} ${HOME}
USER ${NB_USER}
