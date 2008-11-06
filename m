Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id mA68Aqga010993
	for <selinux@tycho.nsa.gov>; Thu, 6 Nov 2008 03:10:52 -0500
Received: from mx2.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id mA68Alb3029477
	for <selinux@tycho.nsa.gov>; Thu, 6 Nov 2008 08:10:51 GMT
Message-ID: <4912A65C.7090906@redhat.com>
Date: Thu, 06 Nov 2008 18:10:04 +1000
From: Murray McAllister <mmcallis@redhat.com>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>
CC: Daniel Walsh <dwalsh@redhat.com>, Eric Paris <eparis@redhat.com>,
        James Morris <jmorris@namei.org>
Subject: user guide draft: "Port Numbers"
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I renamed "Booleans for Confined Services" to "How are Confined Services 
Running?", and added a little about port numbers:

[introduction]

Services can be run in a variety of ways. To cater for this, you must 
tell SELinux how you are running services. This can be achieved via 
Booleans that allow parts of SELinux policy to be changed at runtime, 
without any knowledge of SELinux policy writing. This allows changes, 
such as allowing services access to NFS file systems, without reloading 
or recompiling SELinux policy. Also, running services on non-default 
port numbers requires policy configuration to be updated via the 
semanage command.

...

Port Numbers

Depending on policy configuration, services may only be allowed to run 
on certain port numbers. Attempting to change which port a servers runs 
on without changing policy may result in the service failing to start. 
For example, run the semanage port -l | grep http command to list http 
related ports:

[example output]

The http_port_t port type defines which ports the Apache HTTP Server can 
listen on, which in this case, are TCP ports 80, 443, 488, 8008, 8009, 
and 8443. If an administrator configures httpd.conf so that httpd 
listens on port 9876 (Listen 9876), but policy is not updated to reflect 
this, the service httpd start command fails:

[example output]

  An SELinux denial similar to the following is logged to 
/var/log/audit/audit.log:

[example output]

To allow httpd to listen on a port that is not listed for the 
http_port_t port type, run the semanage port command to add it to policy 
configuration[1]:

# /usr/sbin/semanage port -a -t http_port_t -p tcp 9876

The -a option adds a new record; the -t option defines a type; and the 
-p option defines a protocol. The last argument is the port number to add.

Thanks!


[1] The semanage port -a command adds an entry to the 
/etc/selinux/targeted/modules/active/ports.local file. Note: by default, 
this file can only be viewed by the Linux root user.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
