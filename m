Received: from [144.51.25.121] (moss-spartans [144.51.25.121])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m1SJQtOs012118
	for <selinux@tycho.nsa.gov>; Thu, 28 Feb 2008 14:26:55 -0500
Subject: [patch] libsepol:  accept Flask as string identifier in policy
From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Content-Type: text/plain
Date: Thu, 28 Feb 2008 14:26:55 -0500
Message-Id: <1204226815.31790.204.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

SELinux binary policies presently use "SE Linux" as the string
identifier in the header.  Other Flask/TE implementations would like to
use a more general identifier while preserving compatibility with
SELinux policy tools.  Thus, extend the libsepol policy reading code to
accept "Flask" as an alternate identifier.  This allows checkpolicy and
setools to read such policies when rebuilt against the updated libsepol.

Signed-off-by:  Stephen Smalley <sds@tycho.nsa.gov>

---

 libsepol/include/sepol/policydb/policydb.h |    1 +
 libsepol/src/policydb.c                    |    9 ++++++---
 2 files changed, 7 insertions(+), 3 deletions(-)

Index: trunk/libsepol/include/sepol/policydb/policydb.h
===================================================================
--- trunk/libsepol/include/sepol/policydb/policydb.h	(revision 2817)
+++ trunk/libsepol/include/sepol/policydb/policydb.h	(working copy)
@@ -617,6 +617,7 @@
 
 #define POLICYDB_MAGIC SELINUX_MAGIC
 #define POLICYDB_STRING "SE Linux"
+#define POLICYDB_ALT_STRING "Flask"
 #define POLICYDB_MOD_MAGIC SELINUX_MOD_MAGIC
 #define POLICYDB_MOD_STRING "SE Linux Module"
 
Index: trunk/libsepol/src/policydb.c
===================================================================
--- trunk/libsepol/src/policydb.c	(revision 2817)
+++ trunk/libsepol/src/policydb.c	(working copy)
@@ -2980,7 +2980,7 @@
 	unsigned int i, j, r_policyvers;
 	uint32_t buf[5], config;
 	size_t len, nprim, nel;
-	char *policydb_str, *target_str = NULL;
+	char *policydb_str, *target_str = NULL, *alt_target_str = NULL;
 	struct policydb_compat_info *info;
 	unsigned int policy_type, bufindex;
 	ebitmap_node_t *tnode;
@@ -2998,6 +2998,7 @@
 	if (buf[0] == POLICYDB_MAGIC) {
 		policy_type = POLICY_KERN;
 		target_str = POLICYDB_STRING;
+		alt_target_str = POLICYDB_ALT_STRING;
 	} else if (buf[0] == POLICYDB_MOD_MAGIC) {
 		policy_type = POLICY_MOD;
 		target_str = POLICYDB_MOD_STRING;
@@ -3009,7 +3010,8 @@
 	}
 
 	len = buf[1];
-	if (len != strlen(target_str)) {
+	if (len != strlen(target_str) &&
+	    (!alt_target_str || len != strlen(alt_target_str))) {
 		ERR(fp->handle, "policydb string length %zu does not match "
 		    "expected length %zu", len, strlen(target_str));
 		return POLICYDB_ERROR;
@@ -3028,7 +3030,8 @@
 		return POLICYDB_ERROR;
 	}
 	policydb_str[len] = 0;
-	if (strcmp(policydb_str, target_str)) {
+	if (strcmp(policydb_str, target_str) &&
+	    (!alt_target_str || strcmp(policydb_str, alt_target_str))) {
 		ERR(fp->handle, "policydb string %s does not match "
 		    "my string %s", policydb_str, target_str);
 		free(policydb_str);

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
