FROM openjdk:8u151-jdk
ARG IDEA_VERSION=ideaIC-2018.1.8

RUN        apt-get update
RUN        apt-get install -y --no-install-recommends vim
RUN        apt-get install -y --no-install-recommends wget
RUN        apt-get install -y --no-install-recommends maven
RUN        apt-get install -y --no-install-recommends groovy

# Clean the APT cache to reduce the size of the container. This step is for
# hygiene and can be omitted if needed.
RUN        apt-get clean
RUN        rm -rf /var/lib/apt/lists/*

RUN        curl https://download-cf.jetbrains.com/idea/${IDEA_VERSION}-no-jdk.tar.gz > /tmp/ideaIC-jdk.tar.gz

RUN        mkdir /opt/ide
RUN        tar -x -C /opt/ide --strip-components=1 -z -f /tmp/ideaIC-jdk.tar.gz
RUN        ls -lah /opt/ide/
RUN        rm /tmp/ideaIC-jdk.tar.gz

ENV IDEA_HOME="/opt/ide"

RUN        groupadd -r jetbrains
RUN        useradd --no-log-init --gid jetbrains --home-dir /home/jetbrains --create-home jetbrains

WORKDIR    /home/jetbrains
USER       jetbrains:jetbrains

COPY --chown=jetbrains:jetbrains jdk.table.xml /etc/idea/config/options/
COPY --chown=jetbrains:jetbrains jdk.table.xml /home/jetbrains/.IdeaIC2018.1/config/options/jdk.table.xml

USER       root

# Configure the path of the idea properties. IDEA uses this property to deduce
# where it should look for the jdk.table.xml file. If this property isn't set,
# it won't be able to find the jdk.table.xml file and it crashes and burns with
# all sorts of gibberish errors.
RUN        echo idea.config.path=/etc/idea/config >> /opt/ide/bin/idea.properties

# Set the permissions of the IDEA directory for hygiene purposes.
RUN        chmod -R 777 /etc/idea

WORKDIR    /home/jetbrains
ENTRYPOINT ["/opt/ide/bin/inspect.sh"]
