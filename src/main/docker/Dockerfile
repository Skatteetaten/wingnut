FROM aurora/turbo:0.1.0-beta
ARG javaMajorVersion=8
ARG javaMinorVersion
ARG javaBuildVersion
ARG jolokiaVersion
ARG baseImageVersion
ARG dumbInitVersion=1.2.1

LABEL maintainer="The Norwegian Tax Administration <utvpaas@skatteetaten.no>" \
      java=openjdk-${JAVA_VERSION_MAJOR}u${JAVA_VERSION_MINOR}-b${JAVA_VERSION_BUILD} \
      jolokia=${JOLOKIA_VERSION} \
      version=${BASE_IMAGE_VERSION} \
      www.skatteetaten.no-imageArchitecture=java

ENV JAVA_HOME=/usr/lib/jvm/jre

ENV JAVA_VERSION_MAJOR=${javaMajorVersion} \
    JAVA_VERSION_MINOR=${javaMinorVersion} \
    JAVA_VERSION_BUILD=${javaBuildVersion} \
    # For Fedora-minimal
    # JAVA_PACKAGE="java-1.${javaMajorVersion}.0-openjdk-headless-1:1.${javaMajorVersion}.0.${javaMinorVersion}-${javaBuildVersion}.x86_64" \
    #JAVA_PACKAGE="1:java-1.${javaMajorVersion}.0-openjdk-headless-1.${javaMajorVersion}.0.${javaMinorVersion}-${javaBuildVersion}.x86_64" \
    JAVA_PACKAGE="java-1.8.0-openjdk-headless" \
    PATH=${PATH}:$JAVA_HOME/jre/bin \
    JOLOKIA_VERSION=${jolokiaVersion} \
    JOLOKIA_PATH=/opt/jolokia/jolokia-jvm-${jolokiaVersion}-agent.jar \
    BASE_IMAGE_VERSION=${baseImageVersion} \
    TRUST_STORE=$JAVA_HOME/jre/lib/security/cacerts \
    LOGBACK_FILE=${HOME}/config/logback.xml

ADD http://repo1.maven.org/maven2/org/jolokia/jolokia-jvm/${JOLOKIA_VERSION}/jolokia-jvm-${JOLOKIA_VERSION}-agent.jar ${JOLOKIA_PATH}


RUN chmod go=u /opt/jolokia && \
    microdnf install --nodocs --enablerepo rhel-7-server-rpms tar curl gzip \
      ${JAVA_PACKAGE} && \
    update-ca-trust extract

RUN mkdir -p /u01/bin && \ 
    curl http://aurora.skead.no/nexus/service/local/repositories/releases/content/ske/aurora/openshift/radish/0.0.6/radish-0.0.6.tar.gz | tar -xz -C /u01/bin && \
    microdnf remove tar gzip && \
    microdnf clean all


ADD resources/config ${HOME}/config
WORKDIR ${HOME}
RUN chmod -R go=u ${HOME}

CMD ["/u01/bin/radish", "runJava", "radish.json"]
