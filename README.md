# Wingnut

Cloud ready openjdk base image built using alpine.

## How to use
This base image will trap the running of the script `$HOME/application/bin/start`
If you do not want this behavior then override the CMD directive

The following ENV vars are set that you can use in your JAVA invocation
 - JAVA_DEBUG_ARGS: if `REMOTE_DEBUG` is set we create a remote debugging connection on `DEBUG_PORT`
 - JOLOKIA_PATH: use the following to enable jolokia `-javaagent:\$JOLOKIA_PATH=host=0.0.0.0,port=8778,protocol=https`
 - JAVA_OPTS: contains XMX set to 80% of cgroups memory

see example directory for a very basic Dockerfile that builds a java image

## How to build
./gradlew  buildImage

## How to push to registry
./gradlew pushImage --registry=<registry>

