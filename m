Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i0GL3iRb012428
	for <selinux@tycho.nsa.gov>; Fri, 16 Jan 2004 16:03:44 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i0GL2Xxr024221
	for <selinux@tycho.nsa.gov>; Fri, 16 Jan 2004 21:02:33 GMT
Received: from mailB.its.uidaho.edu (mailB.its.uidaho.edu [129.101.155.251])
	by jazzswing.ncsc.mil  with ESMTP id i0GL2WYc024218
	for <selinux@tycho.nsa.gov>; Fri, 16 Jan 2004 21:02:33 GMT
Received: from cyclone (cyclone.csrv.uidaho.edu [129.101.163.54])
 by mailB.its.uidaho.edu (Go Vandals!)
 with ESMTP id <0HRL0009WP65VJ@mailB.its.uidaho.edu> for selinux@tycho.nsa.gov;
 Fri, 16 Jan 2004 13:03:41 -0800 (PST)
Date: Fri, 16 Jan 2004 13:03:41 -0800 (PST)
From: Thomas DuBuisson <dubu0874@uidaho.edu>
Subject: Trival relabel Problem
In-reply-to: <1074277054.24719.113.camel@moss-spartans.epoch.ncsc.mil>
To: SE Linux <selinux@tycho.nsa.gov>
Message-id: <Pine.GSO.4.56.0401161244200.29958@cyclone.csrv.uidaho.edu>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
References: <200310111435.46684.russell@coker.com.au>
 <1066134168.5054.11.camel@moss-spartans.epoch.ncsc.mil>
 <3F8C46E4.1030403@tresys.com>
 <1074177115.17320.32.camel@moss-spartans.epoch.ncsc.mil>
 <1074271807.23661.119.camel@colossus.columbia.tresys.com>
 <1074277054.24719.113.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I looked at the other relabel threads, they didn't seem to address my
issue.  But if I missed something, sorry if this is a repeat.  I am fairly
certain this is trivial but I am lost.

My problem:
-----------------------
root@blacktower:/etc/security/selinux/src/policy# execcon \
root:sysadm_r:sysadm_t make relabel

/usr/sbin/setfiles:  read 425 specifications
/usr/sbin/setfiles:  labeling files under /
/: Operation not supported
/usr/sbin/setfiles:  unable to obtain attribute for file /
/usr/sbin/setfiles:  error while labeling files under /
----------------------------------------------------

My setup
-----------------------------------
Enforcing: 0
Base System: Slackware 9.1
Kernel: 2.6.1-mm2
FS: reiserfs (I did edit the Makefile changing ext[23])
PAM.77
selinux-usr: 1.4
----------------------------------

So, any pointers on how to get this fs labeled?  What am I missing?

Thanks,
Thomas DuBuisson

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
