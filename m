Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id JAA04448
	for <selinux@tycho.nsa.gov>; Thu, 29 Mar 2001 09:54:51 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id OAA19308
	for <selinux@tycho.nsa.gov>; Thu, 29 Mar 2001 14:54:37 GMT
Received: from e1.ny.us.ibm.com (e1.ny.us.ibm.com [32.97.182.101])
	by jazzswing.ncsc.mil  with ESMTP id OAA19304
	for <selinux@tycho.nsa.gov>; Thu, 29 Mar 2001 14:54:36 GMT
Received: from northrelay02.pok.ibm.com (northrelay02.pok.ibm.com [9.117.200.22])
	by e1.ny.us.ibm.com (8.9.3/8.9.3) with ESMTP id JAA80952
	for <selinux@tycho.nsa.gov>; Thu, 29 Mar 2001 09:53:30 -0500
Received: from d01ml244.pok.ibm.com (d01ml244.pok.ibm.com [9.117.200.44])
	by northrelay02.pok.ibm.com (8.8.8m3/NCO v4.95) with ESMTP id JAA42166
	for <selinux@tycho.nsa.gov>; Thu, 29 Mar 2001 09:50:24 -0500
Subject: error while building initial policy
To: selinux@tycho.nsa.gov
Message-ID: <OF063C958F.83A691A3-ON85256A1E.00515858@pok.ibm.com>
From: "Rajan Ravindran" <rajancr@us.ibm.com>
Date: Thu, 29 Mar 2001 09:54:46 -0500
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I had a problem while building initial policy (make initpolicy)
on Redhat 7.0. The error it showed was
---------------------------------------------------------------------------------------------
error: unknown class file system used in rule.
../kernel/security/checkpolicy: error(s) encountered
while parsing configuration.
make: *** [initpolicy] error 1
--------------------------------------------------------------------------------------------
Do I need to modify anything in my file system policy file?

Rajan


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
