# Use jbossdemocentral/developer as the base
FROM jbossdemocentral/developer

# Maintainer details
MAINTAINER Andrew Block <andy.block@gmail.com>

# Environment Variables 
ENV BPMS_HOME /opt/jboss/bpms
ENV BPMS_VERSION_MAJOR 6
ENV BPMS_VERSION_MINOR 0
ENV BPMS_VERSION_MICRO 3

# ADD Installation Files
COPY support/installation-bpms support/installation-bpms.variables installs/jboss-bpms-installer-$BPMS_VERSION_MAJOR.$BPMS_VERSION_MINOR.$BPMS_VERSION_MICRO.GA-redhat-1.jar  /opt/jboss/

# Prepare and run installer and cleanup installation components
RUN sed -i "s:<installpath>.*</installpath>:<installpath>$BPMS_HOME</installpath>:" /opt/jboss/installation-bpms \
	&& java -jar /opt/jboss/jboss-bpms-installer-$BPMS_VERSION_MAJOR.$BPMS_VERSION_MINOR.$BPMS_VERSION_MICRO.GA-redhat-1.jar  /opt/jboss/installation-bpms -variablefile /opt/jboss/installation-bpms.variables \
	&& rm -rf /opt/jboss/jboss-bpms-installer-$BPMS_VERSION_MAJOR.$BPMS_VERSION_MINOR.$BPMS_VERSION_MICRO.GA-redhat-1.jar /opt/jboss/installation-bpms /opt/jboss/installation-bpms.variables $BPMS_HOME/jboss-eap-6.1/standalone/configuration/standalone_xml_history/

# Add support files
COPY support/application-roles.properties support/standalone.xml $BPMS_HOME/jboss-eap-6.1/standalone/configuration/

# Swtich back to root user to perform cleanup
USER root

# Fix permissions on support files
RUN chown -R jboss:jboss $BPMS_HOME/jboss-eap-6.1/standalone/configuration/standalone.xml

# Run as JBoss 
USER jboss

# Expose Ports
EXPOSE 9990 9999 8080

# Run BPMS
CMD ["/opt/jboss/bpms/jboss-eap-6.1/bin/standalone.sh","-c","standalone.xml","-b", "0.0.0.0","-bmanagement","0.0.0.0"]
