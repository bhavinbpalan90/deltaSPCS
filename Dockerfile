FROM spark:3.5.3-scala2.12-java17-python3-ubuntu

USER root

# Update apt repositories and install curl
RUN apt-get update && apt-get install -y curl

# Install required Python packages
RUN pip install delta-spark==3.2.1
RUN pip install deltalake==0.21.0
RUN pip install jupyterlab
RUN pip install jupyter
RUN pip install pandas numpy

# Download the AWS SDK JAR and place it in the $SPARK_HOME/jars directory
RUN curl -L https://repo1.maven.org/maven2/com/amazonaws/aws-java-sdk-bundle/1.12.774/aws-java-sdk-bundle-1.12.774.jar -o $SPARK_HOME/jars/aws-java-sdk-bundle-1.12.774.jar

# Copy any other necessary JARs (if applicable)
COPY ./*.jar $SPARK_HOME/jars/

# Set working directory and copy notebooks
WORKDIR /bpalan
COPY ./*.ipynb /bpalan/

# Set environment variable for Delta version (optional)
ENV DELTA_PACKAGE_VERSION=delta-spark_2.12:3.2.0

# Start JupyterLab
CMD jupyter-lab --allow-root --no-browser --ip=0.0.0.0 --NotebookApp.token='' --NotebookApp.password=''
