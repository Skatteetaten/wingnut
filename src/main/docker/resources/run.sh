#!/bin/sh

$(/u01/bin/radish generateEnvScript)

/u01/bin/radish generateSplunkStanzas -o /u01/logs

exec /u01/bin/radish runJava /u01/radish.json
