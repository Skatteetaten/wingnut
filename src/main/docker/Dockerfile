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
      version=${BASE_IMAGE_VERSION}

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
    TRUST_STORE=$JAVA_HOME/jre/lib/security/cacerts

ADD http://repo1.maven.org/maven2/org/jolokia/jolokia-jvm/${JOLOKIA_VERSION}/jolokia-jvm-${JOLOKIA_VERSION}-agent.jar ${JOLOKIA_PATH}

# RPM packages for dumb-init is not avialable for RHEL
ADD https://github.com/Yelp/dumb-init/releases/download/v${dumbInitVersion}/dumb-init_${dumbInitVersion}_amd64 /usr/bin/dumb-init

RUN chmod go=u /opt/jolokia && \
    chmod a+x /usr/bin/dumb-init && \
    microdnf -h ; \
    microdnf install --nodocs --enablerepo rhel-7-server-rpms \
      # For fedora-minimal: dumb-init && \
      ${JAVA_PACKAGE} && \
    microdnf clean all && \
    update-ca-trust extract

ADD resources/bin ${HOME}/bin
ADD resources/config ${HOME}/config
WORKDIR ${HOME}
RUN chmod -R go=u ${HOME} && \
    chmod a+x ${HOME}/bin/run

ENTRYPOINT ["/usr/bin/dumb-init", "--"]
CMD ["/u01/bin/run"]
