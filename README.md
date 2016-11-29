JBoss BPM Suite Install Demo
=============================
Project to automate the installation of this product without preconfiguration beyond a single admin user.

There are four options available to you for using this demo; local, Openshift Online, Red Hat CDK OpenShift Enterprise and
Containerized.

Software
--------
The following software is required to run this demo:
- JBoss EAP 7.0 installer: https://developers.redhat.com/download-manager/file/jboss-eap-7.0.0-installer.jar
- JBoss BPM Suite 6.4.0.GA deployable for EAP 7:
- 7-Zip (Windows only): to overcome the Windows 260 character path length limit, we need 7-Zip to unzip the BPM Suite deployable: http://www.7-zip.org/download.html


Option 1 - Install on your machine
----------------------------------
1. [Download and unzip.](https://github.com/jbossdemocentral/bpms-install-demo/archive/master.zip)

2. Add the EAP installer and BPM Suite deployable to installs directory.

3. Run 'init.sh' or 'init.ps1' file.

4. Start the runtime: `./target/jboss-eap-7.0/bin/standalone.sh'` or `.\target\jboss-eap-7.0\bin\standalone.ps1`

5. Login to http://localhost:8080/business-central  (u:bpmsAdmin / p:bpmsuite1!)

6. Enjoy installed and configured JBoss BPM Suite.


Option 2 - Run in Docker
----------------------------------------------
The following steps can be used to configure and run the demo in a Docker container

1. [Download and unzip.](https://github.com/jbossdemocentral/bpms-install-demo/archive/master.zip)

2. Add the EAP installer and BPM Suite deployable to installs directory.

3. Run the 'init-docker.sh' or 'init-docker.ps1' file.

4. Start the container: `docker run -it -p 8080:8080 -p 9990:9990 jbossdemocentral/bpms-install-demo`

5. Login to http://localhost:8080/business-central (u:bpmsAdmin / p:bpmsuite1!)

6. Enjoy installed and configured JBoss BPM Suite.

Additional information can be found in the jbossdemocentral docker [developer repository](https://github.com/jbossdemocentral/docker-developer)


Option 3 - Install with one click in xPaaS (bpmPaaS)
----------------------------------------------------
After clicking button, ensure `Gear` size is set to `medium`:

[![Click to install OpenShift](http://launch-shifter.rhcloud.com/launch/light/Install bpmPaaS.svg)](https://openshift.redhat.com/app/console/application_type/custom?&cartridges[]=https://raw.githubusercontent.com/jbossdemocentral/cartridge-bpmPaaS/master/metadata/manifest.yml&name=bpmpaas&gear_profile=medium&initial_git_url=)

Once installed you can use the JBoss BPM Suite login:

   * u:erics   p: bpmsuite  (admin)

   * u: alan   p: bpmsuite  (analyst)

   * u: daniel p: bpmsuite (developer)

   * u: ursla  p: bpmsuite (user)

   * u: mary   p: bpmsuite (manager)

Current hosting of bpmPaaS is on JBoss BPM Suite 6.0.2 in OpenShift Online.


Option 4 - Install on Red Hat CDK OpenShift Enterprise image
------------------------------------------------------------
The following steps can be used to install this demo on OpenShift Enterprise using the
Red Hat Container Development Kit (CDK)

1. [App Dev Cloud with JBoss BPM Suite Install Demo](https://github.com/redhatdemocentral/rhcs-bpms-install-demo)


Supporting Articles
-------------------
- [Quick Tour #4: Start your first JBoss BPM Suite project (video)](http://www.schabell.org/2015/09/quick-tour-4-start-first-bpms-project.html)

- [Quick Tour #3: How to install JBoss BPM Suite (video)](http://www.schabell.org/2015/09/quick-tour-3-howto-install-jboss-bpms.html)

- [Quick Tour #2: Where to get JBoss BPM Suite product (video)](http://www.schabell.org/2015/09/quick-tour-2-get-jboss-bpmsuite-product.html)

- [Quick Tour #1: JBoss BPM Suite the Basic Install Project (video)](http://www.schabell.org/2015/09/quick-tour-1-jboss-bpmsuite-basic-install-project-video.html)

- [7 Steps to Your First Process with JBoss BPM Suite Starter Kit](http://www.schabell.org/2015/08/7-steps-first-process-jboss-bpmsuite-starter-kit.html)

- [3 shockingly easy ways into JBoss rules, events, planning & BPM](http://www.schabell.org/2015/01/3-shockingly-easy-ways-into-jboss-brms-bpmsuite.html)

- [Jump Start Your Rules, Events, Planning and BPM Today](http://www.schabell.org/2014/12/jump-start-rules-events-planning-bpm-today.html)

- [5 Handy Tips From JBoss BPM Suite For Release 6.0.3](http://www.schabell.org/2014/10/5-handy-tips-from-jboss-bpmsuite-release-603.html)

- [Red Hat JBoss BPM Suite - all product demos updated for version 6.0.2.GA release](http://www.schabell.org/2014/07/redhat-jboss-bpmsuite-product-demos-6.0.2-updated.html)


Released versions
-----------------
See the tagged releases for the following versions of the product:

- v2.3 - JBoss BPM Suite 6.4.0.GA, JBoss EAP 7.0.0.GA and running on Red Hat CDK using OpenShift Enterprise image.

- v2.2 - JBoss BPM Suite 6.2.0-BZ-1299002, JBoss EAP 6.4.4 and running on Red Hat CDK using OpenShift Enterprise image.

- v2.1 - JBoss BPM Suite 6.2.0-BZ-1299002 installed on JBoss EAP 6.4.4.

- v2.0 - JBoss BPM Suite 6.2.0, JBoss EAP 6.4.4 and OSE aligned containerization.

- v1.9 - JBoss BPM Suite 6.2.0 installed on JBoss EAP 6.4.4.

- v1.8 - JBoss BPM Suite 6.1 installed on JBoss EAP 6.4.

- v1.7 - JBoss BPM Suite 6.0.3 with email configuration for task notifications and reassignments.

- v1.6 - JBoss BPM Suite 6.0.3 with optional containerized installation.

- v1.5 - moved to JBoss Demo Central, updated windows init.bat support and one click install button.

- v1.4 - JBoss BPM SUite 6.0.3 installer on JBoss EAP 6.1.1.

- v1.3 - JBoss BPM SUite 6.0.2 installer used to setup basic product installation on JBoss EAP 6.1.1.

- v1.2 - JBoss BPM Suite 6.0.2 installed on JBoss EAP 6.1.1.

- v1.1 - JBoss BPM Suite 6.0.1 installed on JBoss EAP 6.1.1.

- v1.0 - JBoss BPM Suite 6.0.0 installed on JBoss EAP 6.1.1.

- v0.4 - JBoss BPM Suite 6.0.0.CR2 installed on JBoss EAP 6.1.1.

- v0.3 - JBoss BPM Suite 6.0.0.CR1 installed on JBoss EAP 6.1.1 with optional mock data.

- v0.2 - JBoss BPM Suite 6.0.0.Beta installed on JBoss EAP 6.1.1 with mock data.

- v0.1 - JBoss BPM Suite 6.0.0.Beta installed on JBoss EAP 6.1.1.


![BPM Suite](https://raw.githubusercontent.com/jbossdemocentral/bpms-install-demo/master/docs/demo-images/bpmsuite.png)
