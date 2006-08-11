Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k7BDYN07003505
	for <selinux@tycho.nsa.gov>; Fri, 11 Aug 2006 09:34:24 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id k7BDY57f019164
	for <selinux@tycho.nsa.gov>; Fri, 11 Aug 2006 13:34:06 GMT
Subject: [PATCH 3/3] Separate local file contexts into file_contexts.local
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: SELinux Mail List <selinux@tycho.nsa.gov>
Content-Type: text/plain
Date: Fri, 11 Aug 2006 09:34:28 -0400
Message-Id: <1155303269.8722.64.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Semanage was looking at the main file contexts in some cases, since the
local file contexts were merged into the main file contexts.  This patch
fixes the code to look at the appropriate file context databases.

 policycoreutils/semanage/seobject.py |   24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --exclude .svn -urN trunk/policycoreutils/semanage/seobject.py fc-local-fix/policycoreutils/semanage/seobject.py
--- trunk/policycoreutils/semanage/seobject.py	2006-07-31 16:41:07.033676000 -0400
+++ fc-local-fix/policycoreutils/semanage/seobject.py	2006-08-10 09:57:09.205707250 -0400
@@ -1085,13 +1085,13 @@
 		if rc < 0:
 			raise ValueError(_("Could not create a key for %s") % target)
 
-		(rc,exists) = semanage_fcontext_exists(self.sh, k)
+		(rc,exists) = semanage_fcontext_exists_local(self.sh, k)
 		if rc < 0:
 			raise ValueError(_("Could not check if file context for %s is defined") % target)
 		if not exists:
 			raise ValueError(_("File context for %s is not defined") % target)
 		
-		(rc,fcontext) = semanage_fcontext_query(self.sh, k)
+		(rc,fcontext) = semanage_fcontext_query_local(self.sh, k)
 		if rc < 0:
 			raise ValueError(_("Could not query file context for %s") % target)
 
@@ -1124,17 +1124,17 @@
 		if rc < 0:
 			raise ValueError(_("Could not create a key for %s") % target)
 
-		(rc,exists) = semanage_fcontext_exists(self.sh, k)
-		if rc < 0:
-			raise ValueError(_("Could not check if file context for %s is defined") % target)
-		if not exists:
-			raise ValueError(_("File context for %s is not defined") % target)
-		
 		(rc,exists) = semanage_fcontext_exists_local(self.sh, k)
 		if rc < 0:
 			raise ValueError(_("Could not check if file context for %s is defined") % target)
 		if not exists:
-			raise ValueError(_("File context for %s is defined in policy, cannot be deleted") % target)
+			(rc,exists) = semanage_fcontext_exists(self.sh, k)
+			if rc < 0:
+				raise ValueError(_("Could not check if file context for %s is defined") % target)
+			if exists:
+				raise ValueError(_("File context for %s is defined in policy, cannot be deleted") % target)
+			else:
+				raise ValueError(_("File context for %s is not defined") % target)
 
 		rc = semanage_begin_transaction(self.sh)
 		if rc < 0:
@@ -1156,6 +1156,12 @@
 		if rc < 0:
 			raise ValueError(_("Could not list file contexts"))
 
+		(rc, fclocal) = semanage_fcontext_list_local(self.sh)
+		if rc < 0:
+			raise ValueError(_("Could not list local file contexts"))
+
+		self.flist += fclocal
+
 		for fcontext in self.flist:
 			expr = semanage_fcontext_get_expr(fcontext)
 			ftype = semanage_fcontext_get_type(fcontext)


-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
