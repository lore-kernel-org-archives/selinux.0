Message-ID: <43B67855.2020003@cornell.edu>
Date: Sat, 31 Dec 2005 07:23:49 -0500
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: SELinux List <SELinux@tycho.nsa.gov>
CC: Stephen Smalley <sds@tycho.nsa.gov>
Subject: [SEPOL] Context validity and range checks
Content-Type: multipart/mixed;
 boundary="------------080805090203000402080601"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------080805090203000402080601
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi, this patch implements validity checks for a full context, as well as 
an mls context. It also allows comparison of two mls contexts (does one 
contain the other). I think we'll need those functions to implement 
seuser and file context checking from libsemanage.

Note1: The validity checks are intentionally written to assert, not to 
test (an assert prints errors, while a test is silent). If a context is 
not valid, we'll most likely want to know (in detail) why it's not 
valid, in the form of an error message. If a test is necessary, we can 
pass a NULL handle to silence the errors. A test implementation that way 
will cause problems on OMEM, because of overlap of the test result, and 
the error value, but I've chosen not to worry about this here (or the 
caller can check for that if a test is needed).

Note2: The sepol_check_context function is similar, but (1) it works 
without a handle, (2) it works on the global policydb, (3) it's silent, 
and (4) it does not use the proper external representation of a context 
(sepol_context_t).... which is why I marked it deprecated.


--------------080805090203000402080601
Content-Type: text/x-patch;
 name="libsepol.context_checks.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libsepol.context_checks.diff"

diff -Naurp --exclude-from excludes old/libsepol/include/sepol/context.h new/libsepol/include/sepol/context.h
--- old/libsepol/include/sepol/context.h	1969-12-31 19:00:00.000000000 -0500
+++ new/libsepol/include/sepol/context.h	2005-12-31 06:57:24.000000000 -0500
@@ -0,0 +1,31 @@
+#ifndef _SEPOL_CONTEXT_H_
+#define _SEPOL_CONTEXT_H_
+
+#include <sepol/context_record.h>
+#include <sepol/policydb.h>
+#include <sepol/handle.h>
+
+/* -- Deprecated -- */
+
+extern int sepol_check_context(
+	char *context);
+
+/* -- End deprecated -- */
+
+extern int sepol_context_check(
+	sepol_handle_t* handle,
+	sepol_policydb_t* policydb,
+	sepol_context_t* context);
+
+extern int sepol_mls_contains(
+	sepol_handle_t* handle,
+	sepol_policydb_t* policydb,
+	const char* mls1,
+	const char* mls2,
+	int* response);
+
+extern int sepol_mls_check(
+	sepol_handle_t* handle,
+	sepol_policydb_t* policydb,
+	const char* mls);
+#endif
diff -Naurp --exclude-from excludes old/libsepol/include/sepol/sepol.h new/libsepol/include/sepol/sepol.h
--- old/libsepol/include/sepol/sepol.h	2005-10-21 11:31:27.000000000 -0400
+++ new/libsepol/include/sepol/sepol.h	2005-12-31 05:02:00.000000000 -0500
@@ -18,11 +18,9 @@
 #include <sepol/debug.h>
 #include <sepol/policydb.h>
 #include <sepol/module.h>
+#include <sepol/context.h>
 
 /* Set internal policydb from a file for subsequent service calls. */
 extern int sepol_set_policydb_from_file(FILE *fp);
 
-/* Check context validity against currently set binary policy. */
-extern int sepol_check_context(char *context);
-
 #endif
diff -Naurp --exclude-from excludes old/libsepol/src/context.c new/libsepol/src/context.c
--- old/libsepol/src/context.c	2005-11-15 08:06:55.000000000 -0500
+++ new/libsepol/src/context.c	2005-12-31 06:58:04.000000000 -0500
@@ -1,7 +1,9 @@
 #include <stdlib.h>
 #include <string.h>
+#include <errno.h>
 
 #include <sepol/policydb/policydb.h>
+#include <sepol/policydb/services.h>
 #include "context_internal.h"
 
 #include "debug.h"
@@ -16,6 +18,13 @@ int policydb_context_isvalid(
 
         return context_is_valid(p,c);
 }
+
+int sepol_check_context(
+	char *context) {
+
+	return sepol_context_to_sid(context, strlen(context)+1, NULL);
+}
+
 /* ---- End compatibility --- */
 
 /*
@@ -183,12 +192,12 @@ int context_from_record(
 
 	/* MLS */
 	if (mls && !policydb->mls) {
- 		WARN(handle, "mls context \"%s\" ignored, since "
-			"mls is disabled", mls);
+		WARN(handle, "mls context \"%s\" ignored, since "
+				"mls is disabled", mls);
 		mls = NULL;
 	}
 	else if (!mls && policydb->mls) {
- 		ERR(handle, "mls is enabled, but no mls context found");
+	 	ERR(handle, "mls is enabled, but no mls context found");
 		goto err_destroy;
 	}
 	if (mls && (mls_from_string(handle, policydb, mls, scontext) < 0)) 
@@ -313,3 +322,15 @@ int context_from_string(
 	sepol_context_free(ctx_record);
 	return STATUS_ERR;
 }
+
+int sepol_context_check(
+	sepol_handle_t* handle,
+	sepol_policydb_t* policydb,
+	sepol_context_t* context) {
+
+	context_struct_t* con = NULL;
+	int ret = context_from_record(handle, &policydb->p, &con, context);
+	context_destroy(con);
+	free(con);
+	return ret;
+} 
diff -Naurp --exclude-from excludes old/libsepol/src/libsepol.map new/libsepol/src/libsepol.map
--- old/libsepol/src/libsepol.map	2005-12-23 20:49:27.000000000 -0500
+++ new/libsepol/src/libsepol.map	2005-12-31 04:51:27.000000000 -0500
@@ -2,7 +2,7 @@
   global: 
 	sepol_module_package_*; sepol_link_modules; sepol_expand_module; sepol_link_packages;
 	sepol_bool_*; sepol_genbools*; 
-	sepol_context*; sepol_check_context;
+	sepol_context_*; sepol_mls_*; sepol_check_context;
 	sepol_iface_*; 
 	sepol_port_*;
 	sepol_user_*; sepol_genusers; sepol_set_delusers;
diff -Naurp --exclude-from excludes old/libsepol/src/mls.c new/libsepol/src/mls.c
--- old/libsepol/src/mls.c	2005-11-15 08:06:55.000000000 -0500
+++ new/libsepol/src/mls.c	2005-12-31 06:58:25.000000000 -0500
@@ -1,4 +1,3 @@
-
 /* Author : Stephen Smalley, <sds@epoch.ncsc.mil> */
 /*
  * Updated: Trusted Computer Solutions, Inc. <dgoeddel@trustedcs.com>
@@ -612,3 +611,64 @@ int mls_compute_sid(policydb_t *policydb
 	}
 	return -EINVAL;
 }
+
+int sepol_mls_contains(
+	sepol_handle_t* handle,
+	sepol_policydb_t* policydb,
+	const char* mls1,
+	const char* mls2,
+	int* response) {
+
+	context_struct_t *ctx1 = NULL, *ctx2 = NULL;
+	ctx1 = malloc(sizeof(context_struct_t));
+	ctx2 = malloc(sizeof(context_struct_t));
+	if (ctx1 == NULL || ctx2 == NULL) 
+		goto omem;
+	context_init(ctx1);
+	context_init(ctx2);
+
+	if (mls_from_string(handle, &policydb->p, mls1, ctx1) < 0)
+		goto err;
+
+	if (mls_from_string(handle, &policydb->p, mls2, ctx2) < 0)
+		goto err;
+
+	*response = mls_range_contains(ctx1->range, ctx2->range);
+	context_destroy(ctx1);
+	context_destroy(ctx2);
+	free(ctx1);
+	free(ctx2);
+	return STATUS_SUCCESS;
+
+	omem:
+	ERR(handle, "out of memory");
+
+	err:
+	ERR(handle, "could not check if mls context %s contains %s", 
+		mls1, mls2);
+	context_destroy(ctx1);
+	context_destroy(ctx2);
+	free(ctx1);
+	free(ctx2);
+	return STATUS_ERR;	
+}
+
+int sepol_mls_check(
+	sepol_handle_t* handle,
+	sepol_policydb_t* policydb,
+	const char* mls) {
+
+	int ret;
+	context_struct_t* con = malloc(sizeof(context_struct_t));
+	if (!con) {
+		ERR(handle, "out of memory, could not check if "
+			"mls context %s is valid", mls);
+		return STATUS_ERR;
+	} 
+	context_init(con);
+
+	ret = mls_from_string(handle, &policydb->p, mls, con);
+	context_destroy(con);
+	free(con);
+	return ret;
+}
diff -Naurp --exclude-from excludes old/libsepol/src/services.c new/libsepol/src/services.c
--- old/libsepol/src/services.c	2005-11-15 08:06:55.000000000 -0500
+++ new/libsepol/src/services.c	2005-12-31 06:17:30.000000000 -0500
@@ -558,11 +558,6 @@ int hidden sepol_context_to_sid(sepol_se
 	return STATUS_ERR;
 }
 
-int sepol_check_context(char *context) 
-{
-	return sepol_context_to_sid(context, strlen(context)+1, NULL);
-}
-
 static inline int compute_sid_handle_invalid_context(
 	context_struct_t *scontext,
 	context_struct_t *tcontext,

--------------080805090203000402080601--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
