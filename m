Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r9OHFvDK010458
	for <selinux@tycho.nsa.gov>; Thu, 24 Oct 2013 13:16:01 -0400
Received: from vms170025pub.verizon.net ([unknown] [192.168.1.50])
 by vms173007.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTP id <0MV6004MONYNJ860@vms173007.mailsrvcs.net> for
 selinux@tycho.nsa.gov; Thu, 24 Oct 2013 12:15:59 -0500 (CDT)
Date: Thu, 24 Oct 2013 12:15:59 -0500 (CDT)
From: Don Hoefer <don.hoefer@verizon.net>
Reply-to: hoefer@ieee.org
To: selinux@tycho.nsa.gov
Message-id: <24396153.302492.1382634959317.JavaMail.root@vms170025>
Subject: Need information on building embedded systems.
MIME-version: 1.0
Content-type: text/plain; charset=UTF-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

 We are building an embedded system where the customer requires SELinux. It is our own hardware so we build our own kernel and drivers and use the ext2, jfs and tempfs file systems. This is not new for us, but incorporating SELinux is.

Does anyone know of a good knowledge resource for building embedded systems with SELinux?

We are currently plowing through a frustrating step ahead/step back process. We are either unable to build a policy, or a minimal policy we build often causes the development system to fail to boot. Any policy we get onto the embedded system appears to fail to load properly. We think that some pieces may be missing but we are unable to debug due to lack of knowledge.

I suspect that our boot process with SELinux is incomplete and that we are missing some libraries, for example:

root@generic-powerpc:~#semanage
Traceback (most recent call last):
 File "/usr/sbin/semanage", line 24, in <module>
 import seobject
 File "/usr/lib/python2.7/site-packages/seobject.py", line 24,in <module>
 import pwd, grp, string, selinux, tempfile, os, re, sys,stat
ImportError: No module named selinux

Also, the selinux fs is not mounted and policies are not loaded during boot.  We can do this with init scripts but isn't it too late by then?

Any help would be welcome.

 Don Hoefer


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
