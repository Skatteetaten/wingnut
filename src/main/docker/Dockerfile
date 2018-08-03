FROM aurora/turbo:0.1.0-beta
ARG javaMajorVersion=8
ARG javaMinorVersion
ARG javaBuildVersion
ARG jolokiaVersion
ARG baseImageVersion
ARG dumbInitVersion=1.2.1
ARG radishVersion=0.0.7

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
    JAVA_TOOL_OPTIONS="-Dfile.encoding=UTF-8 -Djava.net.preferIPv4Stack=true" \
    PATH=${PATH}:$JAVA_HOME/jre/bin \
    JOLOKIA_VERSION=${jolokiaVersion} \
    JOLOKIA_PATH=/opt/jolokia/jolokia-jvm-${jolokiaVersion}-agent.jar \
    BASE_IMAGE_VERSION=${baseImageVersion} \
    TRUST_STORE=$JAVA_HOME/jre/lib/security/cacerts \
    LOGBACK_FILE=${HOME}/config/logback.xml

ADD http://repo1.maven.org/maven2/org/jolokia/jolokia-jvm/${JOLOKIA_VERSION}/jolokia-jvm-${JOLOKIA_VERSION}-agent.jar ${JOLOKIA_PATH}


RUN chmod -R go+r /opt/jolokia && \
    microdnf install --nodocs --enablerepo rhel-7-server-rpms tar curl gzip \
      ${JAVA_PACKAGE} && \
    update-ca-trust extract

RUN mkdir -p /u01/bin && \ 
    curl http://aurora.skead.no/nexus/service/local/repositories/releases/content/ske/aurora/openshift/radish/${radishVersion}/radish-${radishVersion}.tar.gz | tar -xz -C /u01/bin && \
    microdnf remove tar gzip && \
    microdnf clean all

ADD resources/run.sh /u01/bin/run.sh
ADD resources/config ${HOME}/config
# TODO: This is to wide... Fix old sins!
RUN chmod -R go=u ${HOME}

WORKDIR ${HOME}/application
CMD ["/u01/bin/run.sh"]
