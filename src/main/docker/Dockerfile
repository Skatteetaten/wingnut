FROM alpine:3.6
ARG javaMajorVersion=8
ARG javaMinorVersion
ARG javaBuildVersion
ARG jolokiaVersion
ARG baseImageVersion
ARG buildDate
ARG gitSha

MAINTAINER The Norwegian Tax Administration <utvpaas@skatteetaten.no>

LABEL java=openjdk-${JAVA_VERSION_MAJOR}u${JAVA_VERSION_MINOR}-b${JAVA_VERSION_BUILD} \
      alpine=3.6 \
      jolokia=${JOLOKIA_VERSION} \
      version=${BASE_IMAGE_VERSION} \
      org.label-schema.build-date=${buildDate} \
      org.label-schema.name="Wingnut" \
      org.label-schema.description="Cloud Ready Openshift OpenJDK baseimage" \
      org.label-schema.usage="https://github.com/skatteetaten/wingnut" \
      org.label-schema.vcs-ref=${gitSha} \
      org.label-schema.schema-version = "1.0" \
      org.label-schema.version= "${baseImageVersion}" \
      org.label-schema.vendor = "Skatteetaten SITS/The Norwegian Tax Administration"
      org.label-schema.vcs-url="https://github.com/skatteetaten/wingnut"

ENV JAVA_HOME /usr/lib/jvm/java-1.${javaMajorVersion}-openjdk

ENV JAVA_VERSION_MAJOR=${javaMajorVersion} \
    JAVA_VERSION_MINOR=${javaMinorVersion} \
    JAVA_VERSION_BUILD=${javaBuildVersion} \
    JAVA_PACKAGE=openjdk${javaMajorVersion}-jre \
    PATH=${PATH}:$JAVA_HOME/jre/bin \
    LANG=C.UTF-8 \
    HOME=/u01 \
    JOLOKIA_VERSION=${jolokiaVersion} \
    JOLOKIA_PATH=/opt/jolokia/jolokia-jvm-${jolokiaVersion}-agent.jar \
    BASE_IMAGE_VERSION=${baseImageVersion} \
    ALPINE_VERSION=3.6\
    TRUST_STORE=$JAVA_HOME/jre/lib/security/cacerts

ADD jolokia /opt/jolokia

RUN chmod -R 777 /opt/jolokia && \
    apk add "openjdk8-jre=${JAVA_VERSION_MAJOR}.${JAVA_VERSION_MINOR}.${JAVA_VERSION_BUILD}" -f --update-cache --repository http://nl.alpinelinux.org/alpine/edge/community && \
    apk add --no-cache \
      dumb-init \
      drill \
      tcpdump \
      ngrep \
      bash \
      tzdata && \
    mkdir $HOME

ADD bin $HOME/bin

RUN chmod -R 777 $HOME

WORKDIR ${HOME}

ENTRYPOINT ["/usr/bin/dumb-init", "--"]

CMD ["/u01/bin/run"]
