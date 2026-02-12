FROM ibmjava:11-jdk

WORKDIR /tmp

# use jar to unzip file in order to avoid having to install more dependencies
RUN jar -xvf hermeto-output/deps/generic/dependency-check.zip

RUN chmod +x dependency-check/bin/dependency-check.sh

ENTRYPOINT ["/tmp/dependency-check/bin/dependency-check.sh", "--version"]