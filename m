Message-ID: <437931EA.8080605@cornell.edu>
Date: Mon, 14 Nov 2005 19:55:06 -0500
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
CC: Stephen Smalley <sds@tycho.nsa.gov>
Subject: [ SEPOL ] Mls cleanups
Content-Type: multipart/mixed;
 boundary="------------010905060803090807070902"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------010905060803090807070902
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Cleanup some of mls before I add more functions to it for seuser validation.
One of those days I'll rewrite the whole file, and add more comments and 
ERR calls.

ChangeLog:
- Hide functions mls_to_string and mls_from string into internal header, 
since they have no user in the static lib. I introduced those functions, 
and we should not be adding any functions to the static lib - we should 
be removing them.
- Hide functions mls_sid_to_context, mls_context_to_sid, and 
mls_compute_context_len in the internal header, since they have no user 
in the static lib *and* are deprecated (though I still use them in a few 
places)
- Replace internal use of <sepol/policydb/mls.h> with "mls.h"
- Replace rc values for mls_context_to_sid with STATUS_ERR and 
STATUS_SUCCESS. There are no callers that use the rc values for anything.
- Use the function mls_level_cpy which I added recently to copy low to 
high, if the high level is missing

Additional cleanups in genusers while I'm looking at this:
- Do not set ENOMEM in genusers - should be set by malloc/calloc 
internally, shouldn't it?
- The rc variables in genusers are completely ignored... get rid of 
them, they create confusion

--------------010905060803090807070902
Content-Type: text/x-patch;
 name="libsepol.mls_cleanup.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libsepol.mls_cleanup.diff"

diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION old/libsepol/include/sepol/policydb/mls.h new/libsepol/include/sepol/policydb/mls.h
--- old/libsepol/include/sepol/policydb/mls.h	2005-10-26 09:34:21.000000000 -0400
+++ new/libsepol/include/sepol/policydb/mls.h	2005-11-14 19:13:31.000000000 -0500
@@ -35,35 +35,8 @@
 #include <sepol/policydb/context.h>
 #include <sepol/policydb/policydb.h>
 
-extern int mls_from_string(
-	sepol_handle_t* handle,
-	policydb_t* policydb,
-	const char* str,
-	context_struct_t* mls);
-
-extern int mls_to_string(
-	sepol_handle_t* handle,
-	policydb_t* policydb,
-	context_struct_t* mls,
-	char** str);
-
-/* Deprecated */
-extern int mls_compute_context_len(policydb_t *policydb,
-			    context_struct_t * context);
-
-/* Deprecated */
-extern void mls_sid_to_context(policydb_t *policydb,
-                        context_struct_t *context,
-                        char **scontext);
-
 extern int mls_context_isvalid(policydb_t *p, context_struct_t * c);
 
-/* Deprecated */
-extern int mls_context_to_sid(policydb_t *policydb,
-		       char oldc,
-	               char **scontext,
-		       context_struct_t * context);
-
 extern int mls_convert_context(policydb_t * oldp,
 			policydb_t * newp,
 			context_struct_t * context);
@@ -79,7 +52,5 @@ extern int mls_setup_user_range(
 	context_struct_t *fromcon, user_datum_t *user,
 	context_struct_t *usercon, int mls);
 
-
-
 #endif	
 
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION old/libsepol/src/context.c new/libsepol/src/context.c
--- old/libsepol/src/context.c	2005-11-01 17:32:58.000000000 -0500
+++ new/libsepol/src/context.c	2005-11-14 19:36:05.000000000 -0500
@@ -2,12 +2,12 @@
 #include <string.h>
 
 #include <sepol/policydb/policydb.h>
-#include <sepol/policydb/mls.h>
 #include "context_internal.h"
 
 #include "debug.h"
 #include "context.h"
 #include "handle.h"
+#include "mls.h"
 
 /* ----- Compatibility ---- */
 int policydb_context_isvalid(
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION old/libsepol/src/genusers.c new/libsepol/src/genusers.c
--- old/libsepol/src/genusers.c	2005-11-09 09:52:38.000000000 -0500
+++ new/libsepol/src/genusers.c	2005-11-14 19:35:59.000000000 -0500
@@ -6,12 +6,12 @@
 #include <limits.h>
 
 #include <sepol/policydb/policydb.h>
-#include <sepol/policydb/mls.h>
 #include <stdarg.h>
 
 #include "debug.h"
 #include "private.h"
 #include "dso.h"
+#include "mls.h"
 
 void sepol_set_delusers(int on __attribute((unused))) {
 	WARN(NULL, "Deprecated interface");
@@ -29,7 +29,6 @@ static int load_users(struct policydb *p
 	char *buffer = NULL, *p, *q, oldc;
 	size_t len = 0;
 	ssize_t nread;
-	int rc;
 	unsigned lineno = 0, islist = 0, bit;
 	user_datum_t *usrdatum;
 	role_datum_t *roldatum;
@@ -78,7 +77,6 @@ static int load_users(struct policydb *p
 			usrdatum = (user_datum_t *) malloc(sizeof(user_datum_t));
 			if (!id || !usrdatum) {
 				ERR(NULL, "out of memory");
-				errno = ENOMEM;
 				free(buffer);
 				fclose(fp);
 				return -1;
@@ -86,11 +84,9 @@ static int load_users(struct policydb *p
 			memset(usrdatum, 0, sizeof(user_datum_t));
 			usrdatum->value = ++policydb->p_users.nprim;
 			ebitmap_init(&usrdatum->roles.roles);
-			rc = hashtab_insert(policydb->p_users.table,
-					    id, (hashtab_datum_t) usrdatum);
-			if (rc) {
+			if (hashtab_insert(policydb->p_users.table, 
+				id, (hashtab_datum_t) usrdatum)) {
 				ERR(NULL, "out of memory");
-				errno = ENOMEM;
 				free(buffer);
 				fclose(fp);
 				return -1;
@@ -145,7 +141,6 @@ static int load_users(struct policydb *p
 				if (ebitmap_node_get_bit(rnode, bit))
 					if (ebitmap_set_bit(&usrdatum->roles.roles, bit, 1)) {
 						ERR(NULL, "out of memory");
-						errno = ENOMEM;
 						free(buffer);
 						fclose(fp);
 						return -1;
@@ -196,8 +191,7 @@ static int load_users(struct policydb *p
 			r = scontext;
 
 			context_init(&context);
-			rc = mls_context_to_sid(policydb, oldc, &r, &context);
-			if (rc) {
+			if (mls_context_to_sid(policydb, oldc, &r, &context) < 0) {
 				ERR(NULL, "invalid level %s (%s:%u)",
 					scontext, path, lineno);
 				free(scontext);
@@ -226,7 +220,6 @@ static int load_users(struct policydb *p
 			scontext = malloc(p - q);
 			if (!scontext) {
 				ERR(NULL, "out of memory");
-				errno = ENOMEM;
 				free(buffer);
 				fclose(fp);
 				return -1;
@@ -242,8 +235,7 @@ static int load_users(struct policydb *p
 			r = scontext;
 
 			context_init(&context);
-			rc = mls_context_to_sid(policydb, oldc, &r, &context);
-			if (rc) {
+			if (mls_context_to_sid(policydb, oldc, &r, &context) < 0) {
 				ERR(NULL, "invalid range %s (%s:%u)",
 					scontext, path, lineno);
 				free(scontext);
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION old/libsepol/src/mls.c new/libsepol/src/mls.c
--- old/libsepol/src/mls.c	2005-10-26 09:34:29.000000000 -0400
+++ new/libsepol/src/mls.c	2005-11-14 19:39:18.000000000 -0500
@@ -28,16 +28,17 @@
  * Implementation of the multi-level security (MLS) policy.
  */
 
-#include <sepol/policydb/mls.h>
 #include <sepol/policydb/policydb.h>
 #include <sepol/policydb/services.h>
 #include <sepol/policydb/flask.h>
+#include <sepol/policydb/context.h>
 
 #include <stdlib.h>
 
 #include "handle.h"
 #include "debug.h"
 #include "private.h"
+#include "mls.h"
 
 int mls_to_string(
 	sepol_handle_t* handle,
@@ -87,7 +88,7 @@ int mls_from_string(
 	if (!tmp) 
 		goto omem;
 
-	if (mls_context_to_sid(policydb, '$', &tmp_cp, mls)) {
+	if (mls_context_to_sid(policydb, '$', &tmp_cp, mls) < 0) {
 		ERR(handle, "invalid MLS context %s", str);
 		free(tmp);
 		goto err;
@@ -305,25 +306,24 @@ int mls_context_isvalid(policydb_t *p, c
  * This function modifies the string in place, inserting
  * NULL characters to terminate the MLS fields.
  */
-int mls_context_to_sid(policydb_t *policydb,
-		       char oldc,
-		       char **scontext,
-		       context_struct_t * context)
-{
+int mls_context_to_sid(
+	policydb_t *policydb,
+	char oldc,
+	char **scontext,
+	context_struct_t * context) {
 
 	char delim;
 	char *scontextp, *p, *rngptr;
 	level_datum_t *levdatum;
 	cat_datum_t *catdatum, *rngdatum;
 	unsigned int l;
-	int rc = -EINVAL;
 
 	if (!policydb->mls)
 		return 0;
 
 	/* No MLS component to the security context */
 	if (!oldc)
-		goto out;
+		goto err;
 
 	/* Extract low sensitivity. */
 	scontextp = p = *scontext;
@@ -338,10 +338,8 @@ int mls_context_to_sid(policydb_t *polic
 		levdatum = (level_datum_t *)hashtab_search(policydb->p_levels.table,
 					      (hashtab_key_t)scontextp);
 
-		if (!levdatum) {
-			rc = -EINVAL;
-			goto out;
-		}
+		if (!levdatum)	
+			goto err;
 
 		context->range.level[l].sens = levdatum->level->sens;
 
@@ -363,36 +361,29 @@ int mls_context_to_sid(policydb_t *polic
 
 				catdatum = (cat_datum_t *)hashtab_search(policydb->p_cats.table,
 					      (hashtab_key_t)scontextp);
+				if (!catdatum)
+					goto err;
 
-				if (!catdatum) {
-					rc = -EINVAL;
-					goto out;
-				}
-
-				rc = ebitmap_set_bit(&context->range.level[l].cat,
-				                     catdatum->value - 1, 1);
-				if (rc)
-					goto out;
+				if (ebitmap_set_bit(&context->range.level[l].cat,
+					catdatum->value - 1, 1))
+					goto err;
 
 				/* If range, set all categories in range */
 				if (rngptr) {
 					unsigned int i;
 
-					rngdatum = (cat_datum_t *)hashtab_search(policydb->p_cats.table, (hashtab_key_t)rngptr);
-					if (!rngdatum) {
-						rc = -EINVAL;
-						goto out;
-					}
+					rngdatum = (cat_datum_t *)
+						hashtab_search(policydb->p_cats.table, 
+							(hashtab_key_t)rngptr);
+					if (!rngdatum)
+						goto err;
 
-					if (catdatum->value >= rngdatum->value) {
-						rc = -EINVAL;
-						goto out;
-					}
+					if (catdatum->value >= rngdatum->value)
+						goto err;
 
 					for (i = catdatum->value; i < rngdatum->value; i++) {
-						rc = ebitmap_set_bit(&context->range.level[l].cat, i, 1);
-						if (rc)
-							goto out;
+						if (ebitmap_set_bit(&context->range.level[l].cat, i, 1))
+							goto err;
 					}
 				}
 
@@ -413,17 +404,18 @@ int mls_context_to_sid(policydb_t *polic
 			break;
 	}
 
+	/* High level is missing, copy low level */
 	if (l == 0) {
-		context->range.level[1].sens = context->range.level[0].sens;
-		rc = ebitmap_cpy(&context->range.level[1].cat,
-				 &context->range.level[0].cat);
-		if (rc)
-			goto out;
+		if (mls_level_cpy(&context->range.level[1], 
+			&context->range.level[0]) < 0)
+			goto err;
 	}
 	*scontext = ++p;
-	rc = 0;
-out:
-	return rc;
+
+	return STATUS_SUCCESS;
+
+	err:
+	return STATUS_ERR;
 }
 
 /*
@@ -620,6 +612,3 @@ int mls_compute_sid(policydb_t *policydb
 	}
 	return -EINVAL;
 }
-
-/* FLASK */
-
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION old/libsepol/src/mls.h new/libsepol/src/mls.h
--- old/libsepol/src/mls.h	1969-12-31 19:00:00.000000000 -0500
+++ new/libsepol/src/mls.h	2005-11-14 19:38:59.000000000 -0500
@@ -0,0 +1,41 @@
+#ifndef _SEPOL_MLS_INTERNAL_H_
+#define _SEPOL_MLS_INTERNAL_H_
+
+#include "policydb_internal.h"
+#include <sepol/policydb/context.h>
+#include <sepol/policydb/mls.h>
+#include "handle.h"
+
+extern int mls_from_string(
+	sepol_handle_t* handle,
+	policydb_t* policydb,
+	const char* str,
+	context_struct_t* mls);
+
+extern int mls_to_string(
+        sepol_handle_t* handle,
+        policydb_t* policydb,
+        context_struct_t* mls,
+        char** str);
+
+/* Deprecated */
+extern int mls_compute_context_len(
+	policydb_t *policydb,
+	context_struct_t * context);
+
+
+/* Deprecated */
+extern void mls_sid_to_context(
+	policydb_t *policydb,
+	context_struct_t *context,
+	char **scontext);
+
+/* Deprecated */
+extern int mls_context_to_sid(
+	policydb_t *policydb,
+	char oldc,
+	char **scontext,
+	context_struct_t *context);
+
+#endif
+
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION old/libsepol/src/users.c new/libsepol/src/users.c
--- old/libsepol/src/users.c	2005-11-01 17:32:59.000000000 -0500
+++ new/libsepol/src/users.c	2005-11-14 19:21:48.000000000 -0500
@@ -8,8 +8,8 @@
 
 #include <sepol/policydb/policydb.h>
 #include <sepol/policydb/expand.h>
-#include <sepol/policydb/mls.h>
 #include "user_internal.h"
+#include "mls.h"
 
 static int user_to_record (
 	sepol_handle_t* handle,

--------------010905060803090807070902--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
