# What
## Update and use this script to catalog a postgressql database and turn the metadata into RDF (knowledge graph) format
# Steps
## Start with this provided script
## Once you have uploaded to data.world and notified them
## and the catalog has been enriched and validated
## we can automate (scheduled or event trigger) the collection of metadata
## and building of your metadata catalog in data.world

## If running Windows please remove sudo

sudo docker run -it --rm \
--mount type=bind,source="$(pwd)"/dwcc-export,target=/dwcc-output \
--mount type=bind,source="$(pwd)"/dwcc-export,target=/app/log \
datadotworld/dwcc:2.36 \
catalog-sqlserver -A -i -a <account> -d <database> \
-n <catalogName> -o "/dwcc-output" -p <port> \
-s <server> -u <user> 

# help - https://docs.data.world/en/59261-59392-Connect-to-data.html#UUID-0165d63b-dcaa-6c0d-4c08-e063e93eb1a0
# Create and Executable script to run dwcc - https://docs.data.world/en/59261-59277-Quickstarts-and-tutorials.html#UUID-c22d3138-ae67-050c-30d7-eb1f51888159
# Run and Validate the script - https://docs.data.world/en/59261-59277-Quickstarts-and-tutorials.html#UUID-6dd410f1-5c3f-d003-bb44-ac39dcaa0c82

# docker commands
## docker run = Tell docker to run/start
## -it = name the docker run
## --rm = remove any mounts when done (Clean up)
## datadotworld/dwcc:2.36 = use the data.world dwcc v3.36 docker container on dockerhub
## --mount = map the existing folder /dwcc-output inside the dwcc docker container to the dwcc-export folder inside the folder I executed this script from
## --mount = map the existing folder /app/log inside the dwcc docker container to the dwcc-export folder inside the folder I executed this script from

# dwcc commands
## catalog-sqlserver = tell dwcc to catalog a postgressql database
## -A = catalog all the databases the user provided has access to
## -i = request the user to input the database user's password interactively when run (do not add password to script)
## -a = data.world orgId - Please add fl-<agency_acronym> and replace the <agency_acronym> with your agency's acronym
### example fl-dmv
## -d = name of the database being cataloged
## -n = name of the catalog.  Could be a specific dataset, topic, domain if using the schema flag.
### Or what do users request access to?  Postgres Prod or Data Lake or Auto Manufactur Analytics
### This will be a catalog in the data.world UI and what we will ask you to denote what data is Restricted to Public Disclosure
### And provide a data dictionary, metrics, or terms associated with this data.
## -o = output directory of the cataloged database in RDF knowledge graph format - please leave as "/dwcc-output"
## -p = port of the database server being cataloged
## -s = the host name of the database server being cataloged
## -u = The username of a user of the database server being cataloged with access to the data you wish to be cataloged