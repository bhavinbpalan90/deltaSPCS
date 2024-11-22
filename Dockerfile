FROM  spark:3.5.3-scala2.12-java17-python3-ubuntu

USER root
RUN apt-get update

RUN pip install delta-spark==3.2.1
RUN pip install deltalake==0.21.0
RUN pip install jupyterlab
RUN pip install jupyter

ENV DELTA_PACKAGE_VERSION=delta-spark_2.12:3.2.0
CMD jupyter-lab --allow-root --no-browser --ip=0.0.0.0