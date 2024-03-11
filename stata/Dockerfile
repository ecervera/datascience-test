FROM dataeditors/stata18:2023-12-20

USER root

RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get upgrade -y  \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y \
         python3 \
         python3-pip \
    && rm -rf /var/lib/apt/lists/* \
    && localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8

RUN pip install stata_kernel

RUN python3 -m stata_kernel.install

RUN pip install jupyterlab

RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get upgrade -y  \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y \
         curl \
    && rm -rf /var/lib/apt/lists/* \
    && localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8

RUN curl -fsSL https://deb.nodesource.com/setup_21.x | bash - \
    && apt-get install -y nodejs

RUN pip install jupyterlab-stata-highlight2

RUN pip install notebook

COPY stata_session.py  /usr/local/lib/python3.10/dist-packages/stata_kernel/stata_session.py

USER statauser:stata

ENTRYPOINT ["jupyter", "lab", "--no-browser", "--ip", "0.0.0.0"]

