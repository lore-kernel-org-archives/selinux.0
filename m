Message-ID: <438452BD.30101@cornell.edu>
Date: Wed, 23 Nov 2005 06:30:05 -0500
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov, Stephen Smalley <sds@tycho.nsa.gov>
Subject: [ SEPOL ] Check if policy file is MLS enabled
Content-Type: multipart/mixed;
 boundary="------------010509070803080401040402"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------010509070803080401040402
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit



--------------010509070803080401040402
Content-Type: text/x-patch;
 name="libsepol.mls_enabled.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libsepol.mls_enabled.diff"

diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude policycoreutils --exclude libsemanage --exclude 'booleans_kernel.*' --exclude 'database_pserver.*' old/libsepol/include/sepol/policydb.h new/libsepol/include/sepol/policydb.h
--- old/libsepol/include/sepol/policydb.h	2005-10-18 10:08:39.000000000 -0400
+++ new/libsepol/include/sepol/policydb.h	2005-11-23 05:54:09.000000000 -0500
@@ -53,6 +53,14 @@ extern void sepol_policy_file_set_fp(sep
 extern void sepol_policy_file_set_handle(sepol_policy_file_t *pf,
 					 sepol_handle_t *handle);
 
+/*
+ * Check if the policy file enables MLS
+ */
+
+extern int sepol_policy_file_mls_enabled(
+	sepol_policy_file_t* spf,
+	int* mls_enabled);
+
 /* Policydb public interfaces. */
 
 /* Create and free memory associated with a policydb. */
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude policycoreutils --exclude libsemanage --exclude 'booleans_kernel.*' --exclude 'database_pserver.*' old/libsepol/src/policydb_public.c new/libsepol/src/policydb_public.c
--- old/libsepol/src/policydb_public.c	2005-11-01 17:32:59.000000000 -0500
+++ new/libsepol/src/policydb_public.c	2005-11-23 05:57:42.000000000 -0500
@@ -1,6 +1,8 @@
 #include <stdlib.h>
 
+#include "handle.h"
 #include "debug.h"
+#include "private.h"
 #include <sepol/policydb/policydb.h>
 #include "policydb_internal.h"
 
@@ -60,6 +62,64 @@ void sepol_policy_file_free(sepol_policy
 	free(pf);
 }
 
+int sepol_policy_file_mls_enabled(
+	sepol_policy_file_t* spf,
+        int* mls_enabled)  {
+
+	sepol_handle_t* handle = spf->pf.handle;
+	struct policy_file* pf = &spf->pf;
+	unsigned int policy_type;
+	uint32_t *buf;
+
+	/**
+	 * 4 bytes magic
+	 * 4 bytes ID length x
+	 * x bytes ID string
+	 * (modules only): 4 bytes module type
+	 * 4 bytes policy version
+	 * 4 bytes mls status */
+
+	/* Magic, ID length */
+	if (!(buf = next_entry(pf, sizeof(uint32_t)*2)))
+		goto err;
+
+	/* Check policy type */
+	buf[0] = le32_to_cpu(buf[0]);
+	if (buf[0] == POLICYDB_MAGIC)
+		policy_type = POLICY_KERN;
+        else if (buf[0] == POLICYDB_MOD_MAGIC)
+		policy_type = POLICY_MOD;
+        else {
+                ERR(handle, "policydb magic number %#08x does not "
+			"match expected magic number %#08x or %#08x",
+			buf[0], POLICYDB_MAGIC, POLICYDB_MOD_MAGIC);
+		return STATUS_ERR;
+	}
+
+	/* Skip ID string */
+	buf[1] = le32_to_cpu(buf[1]);
+	if (!next_entry(pf, buf[1]))
+		goto err;
+
+	/* Skip module type */
+	if (policy_type == POLICY_MOD &&
+		!next_entry(pf, sizeof(uint32_t)))
+		goto err;
+
+	/* Skip policy version */
+	if (!(buf = next_entry(pf, sizeof(uint32_t)*2)))
+		goto err;
+
+	/* Is MLS enabled? */
+	buf[1] = le32_to_cpu(buf[1]);
+	*mls_enabled = (buf[1] & POLICYDB_CONFIG_MLS)? 1:0;
+	return STATUS_SUCCESS;
+
+	err:
+	ERR(handle, "truncated policy file - could not check MLS status");
+	return STATUS_ERR;
+}
+
 /* Policydb interfaces. */
 
 int sepol_policydb_create(sepol_policydb_t **sp)
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude policycoreutils --exclude libsemanage --exclude 'booleans_kernel.*' --exclude 'database_pserver.*' old/libsepol/src/user_record.c new/libsepol/src/user_record.c
--- old/libsepol/src/user_record.c	2005-11-19 00:51:25.000000000 -0500
+++ new/libsepol/src/user_record.c	2005-11-23 05:58:22.000000000 -0500
@@ -271,7 +271,7 @@ int sepol_user_get_roles(
 hidden_def(sepol_user_get_roles)
 
 void sepol_user_del_role(
-	sepol_handle_t* handle,	
+	sepol_handle_t* handle,
 	sepol_user_t* user, 
 	const char* role) {
 

--------------010509070803080401040402--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
