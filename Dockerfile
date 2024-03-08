FROM jupyter/datascience-notebook:lab-4.0.7

pip install linearmodels==5.4

# Make sure the contents of our repo are in ${HOME}
COPY . ${HOME}
USER root
RUN chown -R ${NB_UID} ${HOME}
USER ${NB_USER}
