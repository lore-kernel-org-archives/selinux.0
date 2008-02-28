Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m1SFA8ie001263
	for <selinux@tycho.nsa.gov>; Thu, 28 Feb 2008 10:10:09 -0500
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m1SFA73D012225
	for <selinux@tycho.nsa.gov>; Thu, 28 Feb 2008 15:10:07 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id m1SF9xwd017751
	for <selinux@tycho.nsa.gov>; Thu, 28 Feb 2008 10:10:00 -0500
Received: from pobox.corp.redhat.com (pobox.corp.redhat.com [10.11.255.20])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id m1SF9xvl002642
	for <selinux@tycho.nsa.gov>; Thu, 28 Feb 2008 10:09:59 -0500
Received: from [10.11.14.203] (vpn-14-203.rdu.redhat.com [10.11.14.203])
	by pobox.corp.redhat.com (8.13.1/8.13.1) with ESMTP id m1SF9xgs013014
	for <selinux@tycho.nsa.gov>; Thu, 28 Feb 2008 10:09:59 -0500
Subject: [PATCH] Refpolicy: Add new permissions for open perms
From: Eric Paris <eparis@redhat.com>
To: selinux <selinux@tycho.nsa.gov>
Content-Type: text/plain
Date: Thu, 28 Feb 2008 10:09:58 -0500
Message-Id: <1204211398.3206.68.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Add new permissions for open permissions.  This patch does not enable or
make use of those new permissions.  I'll leave that for a future patch
from the policy people.

-Eric

---

diff -Naupr serefpolicy-3.3.0.orig/policy/flask/access_vectors serefpolicy-3.3.0/policy/flask/access_vectors
--- serefpolicy-3.3.0.orig/policy/flask/access_vectors	2008-02-25 17:00:34.000000000 -0500
+++ serefpolicy-3.3.0/policy/flask/access_vectors	2008-02-26 17:36:05.000000000 -0500
@@ -125,6 +125,7 @@ inherits file
 	reparent
 	search
 	rmdir
+	open
 }
 
 class file
@@ -133,6 +134,7 @@ inherits file
 	execute_no_trans
 	entrypoint
 	execmod
+	open
 }
 
 class lnk_file
@@ -144,16 +146,23 @@ inherits file
 	execute_no_trans
 	entrypoint
 	execmod
+	open
 }
 
 class blk_file
 inherits file
+{
+	open
+}
 
 class sock_file
 inherits file
 
 class fifo_file
 inherits file
+{
+	open
+}
 
 class fd
 {



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
