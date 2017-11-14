#!/bin/bash

./gradlew testOutputImage

./gradlew pushImage -Dregistry=${REGISTRY}
