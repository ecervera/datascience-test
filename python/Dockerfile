FROM jupyter/datascience-notebook:lab-4.0.7

# Python packages
RUN pip install linearmodels==5.4

# Make sure the contents of our repo are in ${HOME}
COPY Litigation_Python.ipynb litigation.csv ${HOME}

USER root
RUN chown -R ${NB_UID} ${HOME}
USER ${NB_USER}
RUN jupyter labextension disable "@jupyterlab/apputils-extension:announcements"
CMD ["start-notebook.sh", "--no-browser", \
     "--NotebookApp.token=''", "--NotebookApp.password=''"]
