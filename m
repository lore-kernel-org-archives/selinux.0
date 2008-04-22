From: eparis@redhat.com
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov, jmorris@namei.org, Eric Paris <eparis@redhat.com>
Subject: [PATCH] SELinux: policydb.h whitespace, syntax, and other cleanups
Date: Tue, 22 Apr 2008 17:46:17 -0400
Message-Id: <1208900778330-git-send-email-eparis@redhat.com>
In-Reply-To: <12089007783524-git-send-email-eparis@redhat.com>
References: <12089007782175-git-send-email-eparis@redhat.com>
 <1208900778580-git-send-email-eparis@redhat.com>
 <12089007782327-git-send-email-eparis@redhat.com>
 <120890077840-git-send-email-eparis@redhat.com>
 <12089007784055-git-send-email-eparis@redhat.com>
 <12089007783451-git-send-email-eparis@redhat.com>
 <12089007782803-git-send-email-eparis@redhat.com>
 <12089007782044-git-send-email-eparis@redhat.com>
 <12089007783524-git-send-email-eparis@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

From: Eric Paris <eparis@redhat.com>

This patch changes policydb.h to fix whitespace and syntax issues.  Things that
are fixed may include (does not not have to include)

spaces followed by tabs
spaces used instead of tabs
location of * in pointer declarations

Signed-off-by: Eric Paris <eparis@redhat.com>
---
 security/selinux/ss/policydb.h |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/security/selinux/ss/policydb.h b/security/selinux/ss/policydb.h
index ba593a3..4253370 100644
--- a/security/selinux/ss/policydb.h
+++ b/security/selinux/ss/policydb.h
@@ -12,12 +12,12 @@
  *
  * Updated: Frank Mayer <mayerf@tresys.com> and Karl MacMillan <kmacmillan@tresys.com>
  *
- * 	Added conditional policy language extensions
+ *	Added conditional policy language extensions
  *
  * Copyright (C) 2004-2005 Trusted Computer Solutions, Inc.
  * Copyright (C) 2003 - 2004 Tresys Technology, LLC
  *	This program is free software; you can redistribute it and/or modify
- *  	it under the terms of the GNU General Public License as published by
+ *	it under the terms of the GNU General Public License as published by
  *	the Free Software Foundation, version 2.
  */
 
@@ -221,7 +221,7 @@ struct policydb {
 	/* type enforcement conditional access vectors and transitions */
 	struct avtab te_cond_avtab;
 	/* linked list indexing te_cond_avtab by conditional */
-	struct cond_node* cond_list;
+	struct cond_node *cond_list;
 
 	/* role allows */
 	struct role_allow *role_allow;
@@ -230,10 +230,10 @@ struct policydb {
 	   TCP or UDP port numbers, network interfaces and nodes */
 	struct ocontext *ocontexts[OCON_NUM];
 
-        /* security contexts for files in filesystems that cannot support
+	/* security contexts for files in filesystems that cannot support
 	   a persistent label mapping or use another
 	   fixed labeling behavior. */
-  	struct genfs *genfs;
+	struct genfs *genfs;
 
 	/* range transitions */
 	struct range_trans *range_tr;
-- 
1.5.2.1


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
