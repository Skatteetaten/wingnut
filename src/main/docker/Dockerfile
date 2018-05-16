FROM aurora/turbo:feature_ATO_172_Turbo-SNAPSHOT
ARG javaMajorVersion=8
ARG javaMinorVersion
ARG javaBuildVersion
ARG jolokiaVersion
ARG baseImageVersion
ARG tini_version=0.18.0

LABEL maintainer="The Norwegian Tax Administration <utvpaas@skatteetaten.no>" \
      java=openjdk-${JAVA_VERSION_MAJOR}u${JAVA_VERSION_MINOR}-b${JAVA_VERSION_BUILD} \
      jolokia=${JOLOKIA_VERSION} \
      version=${BASE_IMAGE_VERSION}


ENV JAVA_HOME="/usr/lib/jvm/java-1.${javaMajorVersion}-openjdk"

ENV JAVA_VERSION_MAJOR=${javaMajorVersion} \
    JAVA_VERSION_MINOR=${javaMinorVersion} \
    JAVA_VERSION_BUILD=${javaBuildVersion} \
    JAVA_PACKAGE="java-1.${javaMajorVersion}.0-openjdk-1:1.${javaMajorVersion}.0.${javaMinorVersion}-${javaBuildVersion}.x86_64" \
    PATH=${PATH}:$JAVA_HOME/jre/bin \
    JOLOKIA_VERSION=${jolokiaVersion} \
    JOLOKIA_PATH=/opt/jolokia/jolokia-jvm-${jolokiaVersion}-agent.jar \
    BASE_IMAGE_VERSION=${baseImageVersion} \
    TRUST_STORE=$JAVA_HOME/jre/lib/security/cacerts

ADD http://repo1.maven.org/maven2/org/jolokia/jolokia-jvm/${JOLOKIA_VERSION}/jolokia-jvm-${JOLOKIA_VERSION}-agent.jar /opt/jolokia

RUN chmod a=rwx /opt/jolokia && \
    microdnf install --nodocs ${JAVA_PACKAGE}

# Use tini as subreaper in Docker container to adopt zombie processes
ADD https://github.com/krallin/tini/releases/download/v${tini_version}/tini_${tini_version}-amd64.rpm /tmp/
RUN rpm -i /tmp/tini_${tini_version}-amd64.rpm

ADD bin $HOME/bin
WORKDIR ${HOME}
RUN chmod -R a=rwx ${HOME}

ENTRYPOINT ["/usr/bin/tini", "--"]
CMD ["/u01/bin/run"]
