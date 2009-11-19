Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id nAJKphwX013476
	for <selinux@tycho.nsa.gov>; Thu, 19 Nov 2009 15:51:43 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id nAJKod3x005966
	for <selinux@tycho.nsa.gov>; Thu, 19 Nov 2009 20:50:39 GMT
Received: from localhost.localdomain (f10 [127.0.0.1])
	by localhost.localdomain (8.14.3/8.14.3) with ESMTP id nAJKpgqa005599
	for <selinux@tycho.nsa.gov>; Thu, 19 Nov 2009 15:51:42 -0500
From: Chad Sellers <csellers@tresys.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH] Fix bug in semanage fcontext
Date: Thu, 19 Nov 2009 15:51:42 -0500
Message-Id: <1258663902-5569-1-git-send-email-csellers@tresys.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Apparently I failed to split out the whitespace changes from a
previous patchset, and a bit of the equivalence patch of the
day snuck in. This causes a stack trace when you execute
semanage fcontext -l. This patch reverts the accidentally
included code.

Signed-off-by: Chad Sellers <csellers@tresys.com>
---
 policycoreutils/semanage/seobject.py |    6 ------
 1 files changed, 0 insertions(+), 6 deletions(-)

diff --git a/policycoreutils/semanage/seobject.py b/policycoreutils/semanage/seobject.py
index 3c9b09f..b7d257b 100644
--- a/policycoreutils/semanage/seobject.py
+++ b/policycoreutils/semanage/seobject.py
@@ -1575,12 +1575,6 @@ class fcontextRecords(semanageRecords):
 					print "%-50s %-18s %s:%s:%s " % (k[0], k[1], fcon_dict[k][0], fcon_dict[k][1],fcon_dict[k][2])
 			else:
 				print "%-50s %-18s <<None>>" % (k[0], k[1])
-                if len(self.equiv.keys()) > 0:
-                       if heading:
-                              print _("\nSELinux fcontext Equivalence \n")
-                       
-                       for src in self.equiv.keys():
-                              print "%s == %s" % (src, self.equiv[src])
 				
 class booleanRecords(semanageRecords):
 	def __init__(self, store = ""):
-- 
1.6.2.5


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
