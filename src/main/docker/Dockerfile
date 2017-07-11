FROM alpine:3.6
# cannot set this as buildArg
# see https://github.com/docker-library/openjdk/blob/master/8-jre/alpine/Dockerfile

ARG alpineVersion
ARG javaMajorVersion=8
ARG javaMinorVersion
ARG javaBuildVersion
ARG jolokiaVersion
ARG baseImageVersion
ARG buildDate
ARG gitSha

MAINTAINER The Norwegian Tax Administration <utvpaas@skatteetaten.no>

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
    ALPINE_VERSION=${alpineVersion} \
    TZ="Europe/Oslo"

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


LABEL java=openjdk-${JAVA_VERSION_MAJOR}u${JAVA_VERSION_MINOR}-b${JAVA_VERSION_BUILD} \
      alpine=${ALPINE_VERSION} \
      jolokia=${JOLOKIA_VERSION} \
      version=${BASE_IMAGE_VERSION} \
      org.label-schema.build-date=${buildDate} \
      org.label-schema.docker.dockerfile="/Dockerfile" \
      org.label-schema.license="Apache License - Version 2.0" \
      org.label-schema.name="Wingnut - Cloud Ready Openshift OpenJDK baseimage " \
      org.label-schema.vcs-ref=${gitSha} \
      org.label-schema.vcs-type="Github" \
      org.label-schema.vcs-url="https://github.com/skatteetaten/wingnut"