Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iBGJ8iIi026819
	for <selinux@tycho.nsa.gov>; Thu, 16 Dec 2004 14:08:44 -0500 (EST)
Received: from hawaii.grays-systems.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id iBGJ71NH001528
	for <selinux@tycho.nsa.gov>; Thu, 16 Dec 2004 19:07:01 GMT
Received: (from nick@localhost)
	by hawaii.grays-systems.com (8.13.1/8.13.1/Submit) id iBGJ8lFd003456
	for selinux@tycho.nsa.gov; Thu, 16 Dec 2004 13:08:47 -0600
Subject: Tomcat policy
From: Nick Gray <nick-lists@austin.rr.com>
To: SELinux ML <selinux@tycho.nsa.gov>
Content-Type: text/plain
Date: Thu, 16 Dec 2004 13:08:47 -0600
Message-Id: <1103224127.32688.49.camel@hawaii.grays-systems.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I have written a policy for Tomcat that works. And surprise it actually
works (on my development system) If anyone is interested, I can post it
up to the list after giving myself a chance to smooth it out a bit.

I have a few questions. regarding policies in general and how they
applied to my case in point.


#1

The installation of tree for tomcat looks something like 

/usr/local/tomcat/5.0.28 
/usr/local/tomcat/5.0.28/conf
/usr/local/tomcat/5.0.28/logs
/usr/local/tomcat/5.0.28/...

I also defined

daemon_domain(tomcat)
type tomcat_config_t, file_type, sysadmfile;
type tomcat_log_t, file_type, sysadmfile;

If I am correct in my assumption that the "daemon_domain(tomcat)"
defines the tomcat_t type, I thought I could do the following in
the tomcat.fc

/usr/local/tomcat/5.0.28/logs(/.*)?    system_u:object_r:tomcat_log_t
/usr/local/tomcat/5.0.28/conf(/.*)?    system_u:object_r:tomcat_config_t
# This does not work ??
#/usr/local/tomcat/5.0.28(/.*)?         system_u:object_r:tomcat_t

The logs and conf work like I thought, but when the system trys to label
the others it gets permission denied. I don't believe it is a permision
problem since I accidentally tried this and it worked

/usr/local/tomcat/5.0.28(/.*)?    system_u:object_r:tomcat_log_t

So why can't I use tomcat_t to label directories?


#2

I think I understand how to protect the daemon from the system, how do I
protect the system from the daemon.

The example I can come up with is a jsp page that opens
the /etc/passwd/file and prints it. I want to keep the tomcat process
encapsulated in it own space

It seems I would want a restricted user "tomcat"! Since daemon does a
check that it is being started by the unix user "tomcat", a natural
extension of this would be to ensure that the user process has no access
to the system other than what I have determined,


Thanks

-- 

Nick Gray
Senior Systems Engineer
Bruzenak Inc
Office: 512-331-7998
Cell: 512-630-7009

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
