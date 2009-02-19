Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n1JJMPuG013553
	for <selinux@tycho.nsa.gov>; Thu, 19 Feb 2009 14:22:25 -0500
Received: from qw-out-1920.google.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id n1JJJ2fw008899
	for <selinux@tycho.nsa.gov>; Thu, 19 Feb 2009 19:19:02 GMT
Received: by qw-out-1920.google.com with SMTP id 5so240683qwf.30
        for <selinux@tycho.nsa.gov>; Thu, 19 Feb 2009 11:22:24 -0800 (PST)
From: Bill Chimiak <wch1m1@gmail.com>
To: SELinux <selinux@tycho.nsa.gov>
Subject: VMware-server 2.0 and selinux
Date: Thu, 19 Feb 2009 14:21:09 -0500
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200902191421.10047.w.chimiak@ieee.org>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I cannot get VMware-server 2.0 working with selinux.
If I boot with selinux=0, all things work.

Running
# setenforce=0
does not work.

In the web form, when I attempt to log in I get:
	The server is not responding. Please check that the server is running and
	accepting connections.

When I query on the web, the response is to turn off selinux.

My question is how do I get this to work WITH selinux?

- - - - 
Some information:
I am running FC 9 
kernel 2.6.27.12-78.2.8.fc9.x86_64
 VMware-server2.0.0-122956

The /etc/init.d/vmware hangs on 
Stopping VMware autostart virtual machines:
   Virtual machines
In PERMISSIVE MODE!
I need to do a pkill -9 vmware to even bring down the vmware application.
When I do that
# audit2allow -i [avc information file]
        produces the output
#============= ifconfig_t ==============
allow ifconfig_t security_t:dir { search getattr };
allow ifconfig_t security_t:file read;
allow ifconfig_t security_t:filesystem getattr;
allow ifconfig_t selinux_config_t:dir search;
allow ifconfig_t selinux_config_t:file { read getattr };


When I start vmware, 
# audit2allow -i [avc information file]
        produces the output

#============= ifconfig_t ==============
#allow ifconfig_t security_t:file read;
#allow ifconfig_t security_t:filesystem getattr;
#
##============= pam_t ==============
#allow pam_t initrc_var_run_t:file write;


When I start the vmware program as a user, and when I try to log into
the server, 
# audit2allow -i [avc information file]
        produces the output

#============= system_chkpwd_t ==============
allow system_chkpwd_t security_t:dir { search getattr };
allow system_chkpwd_t security_t:file read;
allow system_chkpwd_t security_t:filesystem getattr;

When I run id on the vmware server administrator, I get
# id virtualRoot
uid=737(virtualRoot) gid=737(virtualRoot) groups=737(virtualRoot)
context=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023


When an attempt to login to the server is tried, 
#audit2allow -i [avc information file]
        produces the output

#============= system_chkpwd_t ==============
allow system_chkpwd_t security_t:dir { search getattr };
allow system_chkpwd_t security_t:file read;
allow system_chkpwd_t security_t:filesystem getattr;


-- 
William J. Chimiak
Laboratory for Telecommunication Sciences 
8080 Greenmead Drive,  College Park, MD 20740
301-422-5217

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
