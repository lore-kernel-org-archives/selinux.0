Message-ID: <43BA42A6.5020609@cornell.edu>
Date: Tue, 03 Jan 2006 04:23:50 -0500
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: SELinux List <SELinux@tycho.nsa.gov>
CC: Stephen Smalley <sds@tycho.nsa.gov>
Subject: [SEMANAGE] Seuser mls validation
Content-Type: multipart/mixed;
 boundary="------------070901020400080600040004"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------070901020400080600040004
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi, the following patch adds seuser mls validation. It makes the 
validate function dependent on policydb, but that's fine, because 
validation will occur in the direct handle only, server-side, against a 
policydb. We won't be doing validation client side in the pserver case.

It also pulls the seuser validate() call out of merge_components, and 
puts it in direct_api.c, which is more correct (because seusers aren't 
really a policy component), and may allow future optimizations (see FIXMEs).

Also, this patch folds the seusers.h header in seuser_internal.h, like 
it was done elsewhere.





--------------070901020400080600040004
Content-Type: text/x-patch;
 name="libsemanage14.seusers_mls_validation.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libsemanage14.seusers_mls_validation.diff"

diff -Naurp --exclude-from excludes old/libsemanage/src/direct_api.c new/libsemanage/src/direct_api.c
--- old/libsemanage/src/direct_api.c	2006-01-01 06:17:57.000000000 -0500
+++ new/libsemanage/src/direct_api.c	2006-01-03 03:50:45.000000000 -0500
@@ -346,8 +346,11 @@ static int semanage_direct_commit(semana
 	modified |= pports->dtable->is_modified(pports->dbase);
 	modified |= pbools->dtable->is_modified(pbools->dbase);
 	modified |= pifaces->dtable->is_modified(pifaces->dbase);
-	/* FIXME: should not be necessary, just for validation */
-	modified |= seusers->dtable->is_modified(seusers->dbase);
+	int seusers_modified = seusers->dtable->is_modified(seusers->dbase);
+
+	/* FIXME: get rid of this, once we support loading the existing policy,
+	 * instead of rebuilding it for seusers */
+	modified |= seusers_modified;
 
 	/* If there were policy changes, or explicitly requested, rebuild the policy */
 	if (sh->do_rebuild || modified) {
@@ -383,7 +386,7 @@ static int semanage_direct_commit(semana
 
 		if (semanage_apply_local_changes(sh, out) < 0)
 			goto cleanup;
-		
+	
 		if (semanage_write_policydb(sh, out) < 0)
 			goto cleanup;
 
@@ -392,6 +395,17 @@ static int semanage_direct_commit(semana
 			goto cleanup;
 	}
 
+	/* FIXME: else if !modified, but seusers_modified, 
+	 * load the existing policy instead of rebuilding */
+
+	/* Validate seusers against policy
+	 * if either policy changed, or seusers changed,
+	 * or we forced a rebuild */
+	if (sh->do_rebuild || modified || seusers_modified) {
+		if (semanage_seuser_validate(sh, out) < 0)
+			goto cleanup;
+	}
+
 	/* Commit changes to components */
 	if (semanage_commit_components(sh) < 0)
 		goto cleanup;
diff -Naurp --exclude-from excludes old/libsemanage/src/policy_components.c new/libsemanage/src/policy_components.c
--- old/libsemanage/src/policy_components.c	2005-12-26 19:12:49.000000000 -0500
+++ new/libsemanage/src/policy_components.c	2006-01-03 03:23:51.000000000 -0500
@@ -5,7 +5,6 @@
 #include "handle.h"
 #include "database.h"
 #include "modules.h"
-#include "seusers.h"
 #include "debug.h"
 
 #define MODE_SET    1
@@ -167,10 +166,6 @@ int semanage_base_merge_components(
 			goto err;
 	}	
 
-	/* Validate seusers against policy */
-	if (semanage_seuser_validate(handle) < 0)
-		goto err;
-	
 	return STATUS_SUCCESS;
 
 	err:
diff -Naurp --exclude-from excludes old/libsemanage/src/seuser_internal.h new/libsemanage/src/seuser_internal.h
--- old/libsemanage/src/seuser_internal.h	2005-12-23 01:38:11.000000000 -0500
+++ new/libsemanage/src/seuser_internal.h	2006-01-03 03:24:38.000000000 -0500
@@ -3,6 +3,7 @@
 
 #include <semanage/seuser_record.h>
 #include <semanage/seusers.h>
+#include <sepol/policydb.h>
 #include "database.h"
 #include "handle.h"
 #include "dso.h"
@@ -32,4 +33,8 @@ extern int seuser_file_dbase_init(
 extern void seuser_file_dbase_release(
 	dbase_config_t* dconfig);
 
+extern int hidden semanage_seuser_validate(
+	semanage_handle_t* handle,
+	sepol_policydb_t* policydb);
+
 #endif
diff -Naurp --exclude-from excludes old/libsemanage/src/seusers.c new/libsemanage/src/seusers.c
--- old/libsemanage/src/seusers.c	2005-12-13 11:08:26.000000000 -0500
+++ new/libsemanage/src/seusers.c	2006-01-03 04:09:33.000000000 -0500
@@ -7,9 +7,10 @@ typedef struct semanage_seuser record_t;
 #define DBASE_RECORD_DEFINED
 
 #include <stddef.h>
+#include <sepol/policydb.h>
+#include <sepol/context.h>
 #include "user_internal.h"
 #include "seuser_internal.h"
-#include "seusers.h"
 #include "handle.h"
 #include "database.h"
 #include "debug.h"
@@ -98,55 +99,87 @@ int semanage_seuser_list(
 
 struct validate_handler_arg {
 	semanage_handle_t* handle;
+	sepol_policydb_t* policydb;
 };
 
 static int validate_handler(
 	semanage_seuser_t* seuser,
 	void* varg) {
 
+	semanage_user_t* user = NULL;
+	semanage_user_key_t* key = NULL;
+	int exists, mls_ok;
+
+	/* Unpack varg */
 	struct validate_handler_arg* arg = 
 		(struct validate_handler_arg*) varg;
+	semanage_handle_t* handle = arg->handle;
+	sepol_policydb_t* policydb = arg->policydb;
 
+	/* Unpack seuser */
 	const char* name = semanage_seuser_get_name(seuser);
 	const char* sename = semanage_seuser_get_sename(seuser);
 	const char* mls_range = semanage_seuser_get_mlsrange(seuser);
+	const char* user_mls_range;
 
-	semanage_user_key_t* key = NULL;
-	int exists;
-	if (semanage_user_key_create(arg->handle, sename, &key) < 0)
-		goto err;
+	/* FIXME: verify that Unix user exists */
 
-	if (semanage_user_exists(arg->handle, key, &exists) < 0)
+	/* Make sure the (SElinux) user exists */
+	if (semanage_user_key_create(handle, sename, &key) < 0)
+		goto err;
+	if (semanage_user_exists(handle, key, &exists) < 0)
 		goto err;
-
 	if (!exists) {
-		ERR(arg->handle, "selinux user %s does not exist", sename);
+		ERR(handle, "selinux user %s does not exist", sename);
 		goto invalid;
 	}
 
-	/* FIXME: check unix user? */
-	/* FIXME: add MLS checks */
+	/* Verify that the mls range is valid, and that it's contained
+	 * within the (SELinux) user mls range */
+	if (mls_range) {
+
+		if (semanage_user_query(handle, key, &user) < 0)
+			goto err;
+		user_mls_range = semanage_user_get_mlsrange(user);
+
+		if (sepol_mls_check(handle->sepolh, policydb, mls_range) < 0)
+			goto invalid;
+		if (sepol_mls_contains(handle->sepolh, policydb, 
+			user_mls_range, mls_range, &mls_ok) < 0)
+			goto err;
+		if (!mls_ok) {
+			ERR(handle, "mls range %s for Unix user %s "
+				"exceeds allowed range %s for SELinux user %s",
+				mls_range, name, user_mls_range, sename);
+			goto invalid;
+		}
+	}
 
 	semanage_user_key_free(key);
+	semanage_user_free(user);
 	return 0;
 
 	err:
-	ERR(arg->handle, "could not check if the seuser mapping "
+	ERR(handle, "could not check if the seuser mapping "
 		"%s -> (%s, %s) is valid", name, sename, mls_range);
 	semanage_user_key_free(key);
+	semanage_user_free(user);
 	return -1;
 
 	invalid:
-	ERR(arg->handle, "seuser mapping %s -> (%s, %s) is invalid",
+	ERR(handle, "seuser mapping %s -> (%s, %s) is invalid",
 		name, sename, mls_range);
 	semanage_user_key_free(key);
+	semanage_user_free(user);
 	return -1;
 }
 
 int hidden semanage_seuser_validate(
-	semanage_handle_t* handle) {
+	semanage_handle_t* handle,	
+	sepol_policydb_t* policydb) {
 
 	struct validate_handler_arg arg;
 	arg.handle = handle;
+	arg.policydb = policydb;
 	return semanage_seuser_iterate(handle, validate_handler, &arg);
 }
diff -Naurp --exclude-from excludes old/libsemanage/src/seusers.h new/libsemanage/src/seusers.h
--- old/libsemanage/src/seusers.h	2005-11-08 09:32:57.000000000 -0500
+++ new/libsemanage/src/seusers.h	1969-12-31 19:00:00.000000000 -0500
@@ -1,11 +0,0 @@
-/* Copyright (C) 2005 Red Hat, Inc. */
-
-#ifndef _SEUSERS_INTERNAL_H_
-#define _SEUSERS_INTERNAL_H_
-
-#include "seuser_internal.h"
-
-extern int hidden semanage_seuser_validate(
-	semanage_handle_t* handle);
-
-#endif
diff -Naurp --exclude-from excludes old/policycoreutils/semanage/semanage new/policycoreutils/semanage/semanage
--- old/policycoreutils/semanage/semanage	2006-01-01 06:17:40.000000000 -0500
+++ new/policycoreutils/semanage/semanage	2005-12-26 21:50:33.000000000 -0500
@@ -109,8 +109,6 @@ class seluserRecords:
 		semanage_user_add_local(self.sh, k, u)
 		if semanage_commit(self.sh) != 0:
 			raise ValueError("Failed to add SELinux user")
-
-		self.dict[name]=seluser(name, roles, selevel, serange)
 		
 	def modify(self, name, roles=[], selevel="", serange=""):
 		(rc,k)=semanage_user_key_create(self.sh, name)
@@ -164,7 +162,6 @@ class seluserRecords:
 
 class portRecords:
 	def __init__(self):
-		self.dict={}
 		self.sh=semanage_handle_create()
 		self.semanaged=semanage_is_managed(self.sh)
 		if self.semanaged:
@@ -209,11 +206,19 @@ class portRecords:
 		
 	def list(self):
 		(status, self.plist, self.psize) = semanage_port_list(self.sh)
-		print "%-25s %s\n" % ("SELinux Port Name", "Port Number")
+		print "%-15s %-25s\n" % ("Port Range", "Context")
 		for idx in range(self.psize):
-			u=semanage_port_by_idx(self.plist, idx)
-			name=semanage_port_get_name(u)
-			print "%20s %d" % ( name, semanage_port_get_number(u))
+			p=semanage_port_by_idx(self.plist, idx)
+			low = semanage_port_get_low(p)
+			high = semanage_port_get_high(p)
+			proto_str = semanage_port_get_proto_str(p)
+			if low == high:
+				range_str = str(low)
+			else:
+				range_str = str(low) + ":" + str(high)
+			con = semanage_port_get_con(p)
+			(rc,con_str) = semanage_context_to_string(self.sh, con)
+			print "%-10s%-5s %-25s" % (range_str, proto_str, con_str)
 			
 if __name__ == '__main__':
 

--------------070901020400080600040004--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
