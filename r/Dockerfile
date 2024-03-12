FROM jupyter/datascience-notebook:lab-4.0.7

# Install pre-requisites for building R packages
USER root
RUN apt-get update \
 && apt-get install -y --no-install-recommends cmake=3.22.1-1ubuntu1.22.04.2 \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*
USER ${NB_USER}

# R packages
RUN R -e "require(devtools)\ninstall_version('estimatr', '1.0.2', repos='https://cran.r-project.org/')"
RUN R -e "require(devtools)\ninstall_version('plm', '2.6-3', repos='https://cran.r-project.org/')"
RUN R -e "require(devtools)\ninstall_version('rstatix', '0.7.2', repos='https://cran.r-project.org/')"

# Make sure the contents of our repo are in ${HOME}
COPY Litigation_R.ipynb litigation.csv ${HOME}
USER root
RUN chown -R ${NB_UID} ${HOME}
USER ${NB_USER}
RUN jupyter labextension disable "@jupyterlab/apputils-extension:announcements"
CMD ["start-notebook.sh", "--no-browser", \
     "--NotebookApp.token=''", "--NotebookApp.password=''"]
