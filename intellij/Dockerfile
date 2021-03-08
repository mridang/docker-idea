FROM openjdk:8u151-jdk
# PLUGIN_IDS is a whitespace separated list of plugins to install
ARG PLUGIN_IDS
ARG IDEA_VERSION=2020.3
ARG IDEA_RELEASE=ideaIC-$IDEA_VERSION

RUN        apt-get update
RUN        apt-get install -y --no-install-recommends vim wget maven groovy jq

# Clean the APT cache to reduce the size of the container. This step is for
# hygiene and can be omitted if needed.
RUN        apt-get clean
RUN        rm -rf /var/lib/apt/lists/*

RUN        curl https://download-cf.jetbrains.com/idea/${IDEA_RELEASE}.tar.gz > /tmp/ideaIC-jdk.tar.gz

RUN        mkdir /opt/ide
RUN        tar -x -C /opt/ide --strip-components=1 -z -f /tmp/ideaIC-jdk.tar.gz
RUN        ls -lah /opt/ide/
RUN        rm /tmp/ideaIC-jdk.tar.gz

ENV IDEA_HOME="/opt/ide"

# Set idea plugin property to point to $PLUGINS_DIR and install given plug-ins.
# The sed trick is based on this https://fabianlee.org/2019/10/05/bash-setting-and-replacing-values-in-a-properties-file-use-sed/
# See also https://www.jetbrains.com/help/idea/2019.3/tuning-the-ide.html?_ga=2.47595233.757054247.1589007044-1999420621.1579768200#common-platform-properties
ENV PLUGINS_DIR="/opt/plugins"
WORKDIR    /opt
COPY       install-plugin.sh .
RUN        mkdir -p /opt/plugins && \
           sed -ir "s_^[#]*\s*idea.plugins.path=.*_idea.plugins.path=${PLUGINS_DIR}_" $IDEA_HOME/bin/idea.properties && \
           for ID in $PLUGIN_IDS; do ./install-plugin.sh $IDEA_VERSION $ID $PLUGINS_DIR; done

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
# Hardcode scope to "classes"
RUN        echo "-Didea.analyze.scope=classes" >> /opt/ide/bin/idea64.vmoptions
RUN        echo "-Didea.analyze.scope=classes" >> /opt/ide/bin/idea.vmoptions
# Increase max java memory
RUN        sed -i "s|-Xmx512m|-Xmx1024m|g" /opt/ide/bin/idea.vmoptions
RUN        sed -i "s|-Xmx750m|-Xmx2048m|g" /opt/ide/bin/idea64.vmoptions

WORKDIR    /home/jetbrains
ENTRYPOINT ["/opt/ide/bin/inspect.sh"]
