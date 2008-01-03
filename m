Message-Id: <20080103184515.268146258@tresys.com>
References: <20080103184331.485176161@tresys.com>
Date: Thu, 03 Jan 2008 13:43:32 -0500
From: tmiller@tresys.com
To: selinux@tycho.nsa.gov
Cc: method@madmethod.com, sds@tycho.nsa.gov
Subject: [patch 1/7] quiet checkpolicy warnings
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Fix shadowed variable in dispol/dismod
Use bison instead of yacc to avoid an unused label warning.

---
 checkpolicy/Makefile      |    2 ++
 checkpolicy/test/dismod.c |    8 ++++----
 checkpolicy/test/dispol.c |    8 ++++----
 3 files changed, 10 insertions(+), 8 deletions(-)

Index: trunk/checkpolicy/Makefile
===================================================================
--- trunk.orig/checkpolicy/Makefile
+++ trunk/checkpolicy/Makefile
@@ -8,6 +8,8 @@ LIBDIR ?= $(PREFIX)/lib
 INCLUDEDIR ?= $(PREFIX)/include
 TARGETS = checkpolicy checkmodule
 
+YACC = bison -y
+
 CFLAGS ?= -g -Wall -O2 -pipe -fno-strict-aliasing
 
 override CFLAGS += -I. -I${INCLUDEDIR}
Index: trunk/checkpolicy/test/dismod.c
===================================================================
--- trunk.orig/checkpolicy/test/dismod.c
+++ trunk/checkpolicy/test/dismod.c
@@ -666,13 +666,13 @@ int display_avblock(int field, uint32_t 
 	return 0;
 }
 
-int display_handle_unknown(policydb_t * policydb, FILE * out_fp)
+int display_handle_unknown(policydb_t * p, FILE * out_fp)
 {
-	if (policydb->handle_unknown == ALLOW_UNKNOWN)
+	if (p->handle_unknown == ALLOW_UNKNOWN)
 		fprintf(out_fp, "Allow unknown classes and perms\n");
-	else if (policydb->handle_unknown == DENY_UNKNOWN)
+	else if (p->handle_unknown == DENY_UNKNOWN)
 		fprintf(out_fp, "Deny unknown classes and perms\n");
-	else if (policydb->handle_unknown == REJECT_UNKNOWN)
+	else if (p->handle_unknown == REJECT_UNKNOWN)
 		fprintf(out_fp, "Reject unknown classes and perms\n");
 	return 0;
 }
Index: trunk/checkpolicy/test/dispol.c
===================================================================
--- trunk.orig/checkpolicy/test/dispol.c
+++ trunk/checkpolicy/test/dispol.c
@@ -274,13 +274,13 @@ int display_cond_expressions(policydb_t 
 	return 1;
 }
 
-int display_handle_unknown(policydb_t * policydb, FILE * out_fp)
+int display_handle_unknown(policydb_t * p, FILE * out_fp)
 {
-	if (policydb->handle_unknown == ALLOW_UNKNOWN)
+	if (p->handle_unknown == ALLOW_UNKNOWN)
 		fprintf(out_fp, "Allow unknown classes and permisions\n");
-	else if (policydb->handle_unknown == DENY_UNKNOWN)
+	else if (p->handle_unknown == DENY_UNKNOWN)
 		fprintf(out_fp, "Deny unknown classes and permisions\n");
-	else if (policydb->handle_unknown == REJECT_UNKNOWN)
+	else if (p->handle_unknown == REJECT_UNKNOWN)
 		fprintf(out_fp, "Reject unknown classes and permisions\n");
 	return 0;
 }

-- 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
