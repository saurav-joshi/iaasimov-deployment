Instructions
============

1. Copy the mysql db scripts from the iaasimov repo (iaasimov/srcmainresources/db_scripts) into the iaasimov-db directory.
2. Build and copy the iaasimov grok jar into the iaasimov-grok directory.
3. Run the following commands:
     docker-compose -f iaasimov-dockercompose.yml build
     docker-compose -f iaasimov-dockercompose.yml up -d

