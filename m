Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id PAA26619
	for <selinux@tycho.nsa.gov>; Tue, 5 Mar 2002 15:43:52 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id UAA12181
	for <selinux@tycho.nsa.gov>; Tue, 5 Mar 2002 20:42:52 GMT
Received: from jsmith.org (pool-141-158-42-229.phil.east.verizon.net [141.158.42.229])
        by jazzband.ncsc.mil  with ESMTP id UAA12177 for <selinux@tycho.nsa.gov>; Tue, 5 Mar 2002 20:42:51 GMT
Subject: Odd acces denied messages
From: Justin Smith <jsmith@mcs.drexel.edu>
To: selinux@tycho.nsa.gov
Content-Type: text/plain
Date: 05 Mar 2002 15:44:27 -0500
Message-Id: <1015361067.29041.1.camel@jsmith.org>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I get the following messages (have all along) and wonder what they mean:

avc:  denied  { write } for  pid=1339 exe=/sbin/insmod
path=/sys/kernel/tainted dev=00:03 ino=4144
scontext=system_u:system_r:kmod_t
tcontext=system_u:object_r:sysctl_kernel_t tclass=file

avc:  denied  { write } for  pid=1340 exe=/sbin/insmod
path=/sys/kernel/tainted dev=00:03 ino=4144
scontext=system_u:system_r:kmod_t
tcontext=system_u:object_r:sysctl_kernel_t tclass=file

These messages come from my home computers (which has an nvidia card and
driver). The one in my office does not have this card but still produces
these messages.

-- 

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
