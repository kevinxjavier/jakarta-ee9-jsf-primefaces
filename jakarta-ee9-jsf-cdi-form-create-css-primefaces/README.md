## Version
- java 18+
- java version "20.0.1" 2023-04-18
- apache-tomcat-10.1.10 (not using this config)
- wildfly-33.0.2.Final  (using this config)
- maven-3.8.701.20230209-1606
- mysql-8.0.33

# CONFIGURE TOMCAT
```
	// Adding user admin
	$ vi $TOMCAT_HOME/conf/tomcat-users.xml
		<user username="admin" password="admin" roles="admin,manager-gui,manager-script"/>

	// Change Port to 9000
	$  vi $TOMCAT_HOME/conf/server.xml
		<Connector port="9000" protocol="HTTP/1.1"
               connectionTimeout="20000"
               redirectPort="8443"
               maxParameterCount="1000"
               />

	// Access out of localhost
	$ vi $TOMCAT_HOME/webapps/manager/META-INF/context.xml
		//Replace
			allow="127\.\d+\.\d+\.\d+|::1|0:0:0:0:0:0:0:1"
		//with
			allow=".*"
			
	// To watch logs TOMCAT
	$ tail -100f $TOMCAT_HOME/logs/catalina.out
	
	// To watch logs TOMCAT Listeners
	$ tail -100f $TOMCAT_HOME/localhost.2023-07-17.log
```

# CONFIGURE TOMCAT WITH MySQL
```
	// From Maven we get data to download MySQL Java Connector
	<!-- https://mvnrepository.com/artifact/mysql/mysql-connector-java -->
	<dependency>
	    <groupId>mysql</groupId>
	    <artifactId>mysql-connector-java</artifactId>
	    <version>8.0.33</version>
	</dependency>

	// Download MySQL Java Conneector
	$ mvn org.apache.maven.plugins:maven-dependency-plugin:2.4:get \
	-DremoteRepositories=http://download.java.net/maven/2 \
	-Dartifact=mysql:mysql-connector-java:8.0.33 \
	-Ddest=./mysql-connector-java.jar
	
	$ cp ./mysql-connector-java.jar $TOMCAT_HOME/lib
```

# CONFIGURE TOMCAT WITH DATASOURCE MySQL
```
	$ mkdir jakarta-ee9-webapp-cdi/src/main/webapp/META-INF/context.xml
		<Resource name="jdbc/MySQLDB" auth="Container"
			type="javax.sql.DataSource" maxTotal="100" maxIdle="30"
			maxWaitMillis="10000" username="root" password="123456"
			driverClassName="com.mysql.cj.jdbc.Driver"
			url="jdbc:mysql://localhost:3306/enterprise?serverTimezone=Europe/Madrid" />
	$ mkdir jakarta-ee9-webapp-cdi/src/main/webapp/WEB-INF/web.xml
		<resource-ref>
			<description>DB Connection</description>
			<res-ref-name>jdbc/MySQLDB</res-ref-name>
			<res-type>javax.sql.DataSource</res-type>
			<res-auth>Container</res-auth>
		</resource-ref>
```

# START/STOP TOMCAT
```
	$ sh $TOMCAT_HOME/bin/startup.sh
	$ sh $TOMCAT_HOME/bin/shutdown.sh
```

# CONFIGURE MAVEN to execute on console
```
    $ vi $MAVEN_HOME/conf/settings.xml
        <pluginGroups>
            <pluginGroup>org.apache.tomcat.maven</pluginGroup>
        </pluginGroups>
```

# CONFIGURE INTELLIJ IDEA
```
    Watch How To Run in IntelliJ: "Run - IntelliJ.png"
```

# Configure Project in Eclipse
```
	$ mvn eclipse:eclipse
```

# RUN
```
    $ mvn tomcat7:redeploy
```

# CONFIGURE WILDFlY
```
# Create a User

    $ $WILDFLY_HOME/bin/add-user.sh     # Select Manage User, leave groups blank and won't go to to be used for one AS process
    
# Access out of localhost
    # First Way (Executing)
        $ sh $WILDFLY_HOME/bin/standalone.sh -b 0.0.0.0 -bmanagement 0.0.0.0 &

    # Sencond Way (Configuring)
        $ vi $WILDFLY_HOME/standalone/configuration/standalone.xml
            <!-- // Replace this: -->
                <interfaces>
                    <interface name="management">
                        <inet-address value="${jboss.bind.address.management:127.0.0.1}"/>
                    </interface>
                    <interface name="public">
                        <inet-address value="${jboss.bind.address:127.0.0.1}"/>
                    </interface>
                </interfaces>
            
            <!-- // With this: -->   
                <interfaces>         
                    <interface name="management">
                        <any-address/>
                    </interface>
                    <interface name="public">
                        <any-address/>
                    </interface>
                </interfaces>

        $ sh $WILDFLY_HOME/bin/jboss-cli.sh --connect --command=:reload

# Change Port 8081
    # First Way (Executing)
        $ sh $WILDFLY_HOME/bin/standalone.sh -Djboss.http.port=8081

    # Sencond Way (Configuring)
        $ vi $WILDFLY_HOME/standalone/configuration/standalone.xml

            <!-- // Replace this: -->
                <socket-binding-group name="standard-sockets" default-interface="public" port-offset="${jboss.socket.binding.port-offset:0}">

            <!-- // With this: The port will be 8180 -->
                <socket-binding-group name="standard-sockets" default-interface="public" port-offset="${jboss.socket.binding.port-offset:100}">
                // The port-offset attribute lets you modify all the ports wildfly uses, by adding the number you specify.
                // For example, the default value is 0, which means that http port will be 8080, remoting 4447, etc.
                // If you use ${jboss.socket.binding.port-offset:100}, http port will be 8180 (8080+100), remoting 4547 (4447+100), etc.

            // Or change this for 8081

            <!-- // Replace this: -->
                <socket-binding name="http" port="${jboss.http.port:8080}"/>

            <!-- // With this: -->
                <socket-binding name="http" port="${jboss.http.port:8081}"/>

# To watch logs WILDFLY
    $ tail -100f $WILDFLY_HOME/standalone/log/server.log
```

# START WILDFlY
```
# From Wildfly Application Server
$ cd <WILDFLY_SERVER>/bin
$ ./standalone.sh
```

# WILDFLY DATASOURCE MySQL
```
# Download MySQL Driver
    $ mvn dependency:copy \
      -Dartifact=mysql:mysql-connector-java:8.0.33 \
      -DoutputDirectory=/home/kevin

$ curl http://127.0.0.1:9990
        # Deployments   >       Upload Deployments  >   mysql-connector-java:8.0.33.jar
        # Configuration >       Subsystems  >   Datasources & Drivers   > JDBC Drivers  >   mysql-connector-j-8.0.33.jar
        # Configuration >       Subsystems  >   Datasources & Drivers   > Datasources   >   Add Datasource  > MySQL > [copy JNDI Name] -> *next...
            Attributes
                Name: MySqlDS
                JNDI Name: java:/MySqlDS
            JDBC Driver
                Driver Name: mysql-connector-j-8.0.33.jar
                Driver Class Name: com.mysql.cj.jdbc.Driver
            Connection
                Connection URL: jdbc:mysql://localhost:3306/enterprise
```

# START WILDFlY FROM MAVEN & DEPLOY
```
$ mvn wildfly:start  # Only start Wildfly does not deploy our war.
$ mvn wildfly:run    # Start Wildfly and deploy our war.
$ mvn wildfly:shutdown

$ mvn wildfly:deploy # Same as $ mvn wildfly:redeploy
$ mvn wildfly:undeploy
```

# COMPILE
```
$ mvn clean compile package
$ mvn clean compile package -U       # -U means force update of snapshot dependencies

# If your local repository is somehow mucked up for release jars as opposed to snapshots (-U and --update-snapshots only update snapshots), you can purge the local repo using the following:
$ mvn dependency:purge-local-repository

# You probably then want to clean and install again (to solve the problem):
$ mvn dependency:purge-local-repository clean install
```

# DEPLOY
```
	$ curl http://localhost:9990/console/
	
	$ curl http://localhost:8080/jakarta-ee9-jsf-cdi-form-create/
	
	$ curl http://localhost:8080/jakarta-ee9-jsf-cdi-form-create/kevin.jsf
```

# DEBUG REMOTELY TOMCAT
```
	1) Start Tomcat in debug mode
		$ su // log as root
		$ vi $TOMCAT_HOME/bin/catalina.sh jpda start

		   By default JPDA_ADDRESS is defined as "localhost:8000" in catalina.sh
		   Change to a different port as need or localhost to 0.0.0.0 for remote debug
		   
			if [ -z "$JPDA_ADDRESS" ]; then
				JPDA_ADDRESS="0.0.0.0:8000"
		  	fi
		  	
	  	$ sh $TOMCAT_HOME/bin/catalina.sh jpda start

	2.1) In IntelliJ 
		Click Run > Edit Configurations
		Click + icon on the top-left toolbar
		Click Remote
		Enter a name you want in Name input box
		Enter 8000 in Port input box under Settings section and the Host
		Click Apply, then OK
		Run > Debug..., Click the configuration you just created

	2.2) In Eclipse
		Watch How To Configure in Eclipse: Debug - Eclipse.png
```