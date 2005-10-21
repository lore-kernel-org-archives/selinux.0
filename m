Message-ID: <43595049.2@cornell.edu>
Date: Fri, 21 Oct 2005 16:32:09 -0400
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
CC: Stephen Smalley <sds@tycho.nsa.gov>
Subject: [ SEPOL ] Context interface cleanup
Content-Type: multipart/mixed;
 boundary="------------070703040602070407090800"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------070703040602070407090800
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

We need to be removing things from the static interface, not adding to 
it. During my first attempt to implement user management in libsepol, I 
added a few functions that work with a context_struct. Some are new 
functions that I wrote to convert a record to a context_struct, others I 
pulled out of services.c to organize into context.c.

They were prefixed sepol_ctx_struct_*.

This patch:
- deletes those functions from the static interface, and puts them in a 
private header. Those are the first of (hopefully more to come) 
functions to be drawn from the static interface (as described by 
published headers) back into libsepol where they belong.
- removes the sepol_ prefix, which I use to indicate whether a function 
is exported or not
- changes "ctx_struct" to "context" for consistency with other code that 
uses a context_struct (context_cpy, etc..)
- removes unnecessary relay function from services.c, and use the right 
function directly.
- renames the create() function to _from_record(), which describes more 
accurately what is going on.
- replaces all inclusion of <sepol/policydb/context.h> with the internal 
"context.h", which draws in the other header

=======
Note: A possible point of confusion - the internal context functions are 
now all prefixed context_*. The record ones are prefixed 
(sepol_context_*). They both represent a context, but the record is 
exported via the shared interface. The internal structure is only 
exported via the static interface.

--------------070703040602070407090800
Content-Type: text/x-patch;
 name="libsepol.context_cleanup.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libsepol.context_cleanup.diff"

diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude policy_components.c --exclude '*_record.c' --exclude '*_record.h' --exclude libsemanage.map --exclude 'module_record*' --exclude 'database_directory*' old/libsepol/include/sepol/policydb/context.h new/libsepol/include/sepol/policydb/context.h
--- old/libsepol/include/sepol/policydb/context.h	2005-10-21 15:47:49.000000000 -0400
+++ new/libsepol/include/sepol/policydb/context.h	2005-10-21 15:51:28.000000000 -0400
@@ -22,7 +22,6 @@
 #include <stddef.h>
 #include <sepol/policydb/ebitmap.h>
 #include <sepol/policydb/mls_types.h>
-#include <sepol/context_record.h>
 
 /*
  * A security context consists of an authenticated user
@@ -103,31 +102,4 @@ static inline int context_cmp(context_st
 		mls_context_cmp(c1, c2));
 }
 
-struct policydb;
-
-/* Create a context structure from high level representation */
-extern int sepol_ctx_struct_create(
-	struct policydb *policydb,
-	context_struct_t** cptr,
-	sepol_context_t* data);
-
-/* Create a context structure from string representation */
-extern int sepol_ctx_struct_from_string(
-	struct policydb* policydb,
-	context_struct_t** cptr,
-	const char* con_str,
-	size_t con_str_len);
-
-/* Check if the provided context is valid for this policy */
-extern int sepol_ctx_struct_is_valid(
-	struct policydb *policydb, 
-	context_struct_t *context);
-
-/* Extract the context as string */
-extern int sepol_ctx_struct_to_string(
-	struct policydb *policydb,
-	context_struct_t * context,
-	char ** result,
-	size_t *result_len);
-
-#endif	/* _SEPOL_CONTEXT_H_ */
+#endif
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude policy_components.c --exclude '*_record.c' --exclude '*_record.h' --exclude libsemanage.map --exclude 'module_record*' --exclude 'database_directory*' old/libsepol/include/sepol/policydb/policydb.h new/libsepol/include/sepol/policydb/policydb.h
--- old/libsepol/include/sepol/policydb/policydb.h	2005-10-19 15:05:00.000000000 -0400
+++ new/libsepol/include/sepol/policydb/policydb.h	2005-10-21 15:53:59.000000000 -0400
@@ -470,9 +470,7 @@ extern void policydb_destroy(policydb_t 
 extern int policydb_load_isids(policydb_t *p, sidtab_t *s);
 
 /* Deprecated */
-static inline int policydb_context_isvalid(policydb_t *p, context_struct_t *c) {
-	return sepol_ctx_struct_is_valid(p,c);
-}
+extern int policydb_context_isvalid(policydb_t *p, context_struct_t *c);
 
 extern void symtabs_destroy(symtab_t *symtab);
 extern int scope_destroy(hashtab_key_t key, hashtab_datum_t datum, void *p);
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude policy_components.c --exclude '*_record.c' --exclude '*_record.h' --exclude libsemanage.map --exclude 'module_record*' --exclude 'database_directory*' old/libsepol/src/context.c new/libsepol/src/context.c
--- old/libsepol/src/context.c	2005-10-13 13:06:06.000000000 -0400
+++ new/libsepol/src/context.c	2005-10-21 16:17:10.000000000 -0400
@@ -1,17 +1,26 @@
 #include <stdlib.h>
 
 #include <sepol/policydb/policydb.h>
-#include <sepol/policydb/context.h>
 #include <sepol/policydb/mls.h>
 #include <sepol/context_record.h>
 
 #include "debug.h"
+#include "context.h"
+
+/* ----- Compatibility ---- */
+int policydb_context_isvalid(
+	policydb_t *p, 
+	context_struct_t *c) {
+
+        return context_is_valid(p,c);
+}
+/* ---- End compatibility --- */
 
 /*
  * Return 1 if the fields in the security context
  * structure `c' are valid.  Return 0 otherwise.
  */
-int sepol_ctx_struct_is_valid(policydb_t *p, context_struct_t *c)
+int context_is_valid(policydb_t *p, context_struct_t *c)
 {
 	role_datum_t *role;
 	user_datum_t *usrdatum;
@@ -63,7 +72,7 @@ int sepol_ctx_struct_is_valid(policydb_t
  * to point to this string and set `*scontext_len' to
  * the length of the string.
  */
-int sepol_ctx_struct_to_string(
+int context_to_string(
 	policydb_t* policydb,
 	context_struct_t * context,
 	char **result,
@@ -119,7 +128,7 @@ int sepol_ctx_struct_to_string(
 /* Create a policy-dependent context structure, corresponding
  * to the provided high level representation */
 
-int sepol_ctx_struct_create(
+int context_from_record(
 	policydb_t* policydb, 
 	context_struct_t** cptr, 
 	sepol_context_t* data) {
@@ -190,7 +199,7 @@ int sepol_ctx_struct_create(
 	}
 
 	/* Validity check */
- 	if (!sepol_ctx_struct_is_valid(policydb, scontext)) {
+ 	if (!context_is_valid(policydb, scontext)) {
 		if (mls) {
 			DEBUG(__FUNCTION__, 
 				"invalid security context: %s:%s:%s:%s\n",
@@ -227,14 +236,14 @@ int sepol_ctx_struct_create(
 /*
  * Create a context structure from the provided string.
  */
-int sepol_ctx_struct_from_string(
+int context_from_string(
 	policydb_t* policydb,
 	context_struct_t** cptr,
 	const char* con_str,
 	size_t con_str_len) { 
 
 	char* con_cpy = NULL;
-	sepol_context_t* ctx_info = NULL;
+	sepol_context_t* ctx_record = NULL;
 
 	/* sepol_context_from_string expects a NULL-terminated string */
 	con_cpy = malloc(con_str_len + 1);
@@ -245,20 +254,20 @@ int sepol_ctx_struct_from_string(
 	memcpy(con_cpy, con_str, con_str_len);
 	con_cpy[con_str_len] = '\0';
 
-	if (sepol_context_from_string(con_cpy, &ctx_info) < 0)
+	if (sepol_context_from_string(con_cpy, &ctx_record) < 0)
 		goto err;
 
 	/* Now create from the data structure */
-	if (sepol_ctx_struct_create(policydb, cptr, ctx_info) < 0)
+	if (context_from_record(policydb, cptr, ctx_record) < 0)
 		goto err;
 
 	free(con_cpy);
-	sepol_context_free(ctx_info);
+	sepol_context_free(ctx_record);
 	return STATUS_SUCCESS;
 	
 	err:
 	DEBUG(__FUNCTION__, "unable to create context structure\n");
 	free(con_cpy);
-	sepol_context_free(ctx_info);
+	sepol_context_free(ctx_record);
 	return STATUS_ERR;
 }
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude policy_components.c --exclude '*_record.c' --exclude '*_record.h' --exclude libsemanage.map --exclude 'module_record*' --exclude 'database_directory*' old/libsepol/src/context.h new/libsepol/src/context.h
--- old/libsepol/src/context.h	1969-12-31 19:00:00.000000000 -0500
+++ new/libsepol/src/context.h	2005-10-21 16:15:35.000000000 -0400
@@ -0,0 +1,34 @@
+#ifndef _SEPOL_CONTEXT_INTERNAL_H_
+#define _SEPOL_CONTEXT_INTERNAL_H_
+
+#include <stddef.h>
+#include <sepol/context_record.h>
+#include <sepol/policydb/context.h> 
+#include <sepol/policydb/policydb.h>
+
+/* Create a context structure from high level representation */
+extern int context_from_record(
+	policydb_t* policydb,
+	context_struct_t** cptr,
+	sepol_context_t* data);
+
+/* Create a context structure from string representation */
+extern int context_from_string(
+	policydb_t* policydb,
+	context_struct_t** cptr,
+	const char* con_str,
+	size_t con_str_len);
+
+/* Check if the provided context is valid for this policy */
+extern int context_is_valid(
+	policydb_t* policydb,
+	context_struct_t* context);
+
+/* Extract the context as string */
+extern int context_to_string(
+	policydb_t* policydb,
+	context_struct_t* context,
+	char ** result,
+	size_t *result_len);
+
+#endif
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude policy_components.c --exclude '*_record.c' --exclude '*_record.h' --exclude libsemanage.map --exclude 'module_record*' --exclude 'database_directory*' old/libsepol/src/expand.c new/libsepol/src/expand.c
--- old/libsepol/src/expand.c	2005-10-19 16:14:51.000000000 -0400
+++ new/libsepol/src/expand.c	2005-10-21 16:12:25.000000000 -0400
@@ -19,8 +19,7 @@
  *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
  */
 
-
-#include <sepol/policydb/context.h>
+#include "context.h"
 #include <sepol/policydb/policydb.h>
 #include <sepol/policydb/conditional.h>
 #include <sepol/policydb/hashtab.h>
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude policy_components.c --exclude '*_record.c' --exclude '*_record.h' --exclude libsemanage.map --exclude 'module_record*' --exclude 'database_directory*' old/libsepol/src/interfaces.c new/libsepol/src/interfaces.c
--- old/libsepol/src/interfaces.c	2005-10-07 16:45:46.000000000 -0400
+++ new/libsepol/src/interfaces.c	2005-10-21 16:10:06.000000000 -0400
@@ -2,9 +2,9 @@
 #include <stdlib.h>
 
 #include "debug.h"
+#include "context.h"
 #include <sepol/sepol.h>
 #include <sepol/policydb/policydb.h>
-#include <sepol/policydb/context.h>
 #include <sepol/policydb/sidtab.h>
 #include <sepol/policydb/services.h>
 #include <sepol/interfaces.h>
@@ -12,7 +12,7 @@
 
 /* Create a low level interface structure from
  * a high level representation */
-static int sepol_iface_struct_create(
+static int sepol_iface_struct_create (
 	policydb_t* policydb,
 	ocontext_t** iface,
 	sepol_iface_t* data) {
@@ -31,14 +31,14 @@ static int sepol_iface_struct_create(
 		goto omem;
 
 	/* Interface Context */
-	if (sepol_ctx_struct_create(policydb, 
+	if (context_from_record(policydb, 
 		&tmp_ifcon, sepol_iface_get_ifcon(data)) < 0)
 		goto err;
 	context_cpy(&tmp_iface->context[0], tmp_ifcon);
 	free(tmp_ifcon);
 
 	/* Message Context */
-	if (sepol_ctx_struct_create(policydb, 
+	if (context_from_record(policydb, 
 		&tmp_msgcon, sepol_iface_get_msgcon(data)) < 0)
 		goto err;
 	context_cpy(&tmp_iface->context[1], tmp_msgcon);
@@ -70,11 +70,11 @@ int sepol_iface_get_context(
 	head = policydb->ocontexts[OCON_NETIF];
 	for (c = head; c; c = c->next) {
 		if (!strcmp(name, c->u.name)) { 
-			if (sepol_ctx_struct_to_string(policydb, 
+			if (context_to_string(policydb, 
 				&c->context[0], ifcon_str, ifcon_str_len) < 0)
 				goto err;
 	
-			if (sepol_ctx_struct_to_string(policydb,
+			if (context_to_string(policydb,
 				&c->context[1], msgcon_str, msgcon_str_len) < 0)
 				goto err;
 
@@ -160,7 +160,7 @@ int sepol_iface_iterate(
 			goto err;
 
 		/* Interface context */
-		if (sepol_ctx_struct_to_string(policydb, ifcon,
+		if (context_to_string(policydb, ifcon,
 			&tmp_con_str, &tmp_con_ssize) < 0)
 			goto err;
 
@@ -174,7 +174,7 @@ int sepol_iface_iterate(
 		tmp_con = NULL;
 
 		/* Message context */
-		if (sepol_ctx_struct_to_string(policydb, msgcon,
+		if (context_to_string(policydb, msgcon,
 			&tmp_con_str, &tmp_con_ssize) < 0)
 			goto err;
 
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude policy_components.c --exclude '*_record.c' --exclude '*_record.h' --exclude libsemanage.map --exclude 'module_record*' --exclude 'database_directory*' old/libsepol/src/ports.c new/libsepol/src/ports.c
--- old/libsepol/src/ports.c	2005-10-07 16:45:46.000000000 -0400
+++ new/libsepol/src/ports.c	2005-10-21 16:12:14.000000000 -0400
@@ -2,9 +2,9 @@
 #include <stdlib.h>
 
 #include "debug.h"
+#include "context.h"
 #include <sepol/sepol.h>
 #include <sepol/policydb/policydb.h>
-#include <sepol/policydb/context.h>
 #include <sepol/policydb/sidtab.h>
 #include <sepol/policydb/services.h>
 #include <sepol/ports.h>
@@ -70,7 +70,7 @@ static int sepol_port_struct_create(
 	}
 
 	/* Context */
-	if (sepol_ctx_struct_create(policydb, &tmp_con, 
+	if (context_from_record(policydb, &tmp_con, 
 		sepol_port_get_con(data)) < 0)
 		goto err;
 	context_cpy(&tmp_port->context[0], tmp_con);
@@ -113,7 +113,7 @@ int sepol_port_get_context(
 
 		if ((low == low2 && high == high2) ||
 		    (low2 <= low && high2 >= high)) {
-			if (sepol_ctx_struct_to_string(policydb, con2, 
+			if (context_to_string(policydb, con2, 
 				con_str, con_str_len) < 0)
 				goto err;		
 	
@@ -203,7 +203,7 @@ int sepol_port_iterate(
 		if (sepol_port_set_range(port, low, high) < 0)
 			goto err;
 		
-		if (sepol_ctx_struct_to_string(policydb, con, 
+		if (context_to_string(policydb, con, 
 			&tmp_con_str, &tmp_con_ssize) < 0)
 			goto err;
 
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude policy_components.c --exclude '*_record.c' --exclude '*_record.h' --exclude libsemanage.map --exclude 'module_record*' --exclude 'database_directory*' old/libsepol/src/services.c new/libsepol/src/services.c
--- old/libsepol/src/services.c	2005-10-07 16:45:46.000000000 -0400
+++ new/libsepol/src/services.c	2005-10-21 16:18:44.000000000 -0400
@@ -49,7 +49,6 @@
 #include <netinet/in.h>
 #include <arpa/inet.h>
 
-#include <sepol/policydb/context.h>
 #include <sepol/policydb/policydb.h>
 #include <sepol/policydb/sidtab.h>
 #include <sepol/policydb/services.h>
@@ -59,6 +58,7 @@
 
 #include "debug.h"
 #include "private.h"
+#include "context.h"
 #include "av_permissions.h"
 
 #define BUG() do { DEBUG(__FUNCTION__, "Badness at %s:%d\n", __FILE__, __LINE__); } while (0)
@@ -499,15 +499,6 @@ int sepol_compute_av(sepol_security_id_t
 	return sepol_compute_av_reason(ssid, tsid, tclass, requested, avd, &reason);
 }
 
-/* Deprecated */
-static inline int context_struct_to_string(
-        context_struct_t* context,
-        char ** result,
-        size_t *result_len) {
-
-        return sepol_ctx_struct_to_string(policydb, context, result, result_len);
-}
-
 /*
  * Write the security context string representation of 
  * the context associated with `sid' into a dynamically
@@ -528,7 +519,7 @@ int sepol_sid_to_context(sepol_security_
 		rc = -EINVAL;
 		goto out;
 	}
-	rc = context_struct_to_string(context, scontext, scontext_len);
+	rc = context_to_string(policydb, context, scontext, scontext_len);
 out:
 	return rc;
 	
@@ -545,7 +536,7 @@ int sepol_context_to_sid(sepol_security_
 	context_struct_t* context = NULL;
 
 	/* First, create the context */
-	if (sepol_ctx_struct_from_string(policydb, &context, 
+	if (context_from_string(policydb, &context, 
 		scontext, scontext_len) < 0)
 		goto err;
 
@@ -583,9 +574,9 @@ static inline int compute_sid_handle_inv
 		sepol_security_context_t s, t, n;
 		size_t slen, tlen, nlen;
 
-		context_struct_to_string(scontext, &s, &slen);
-		context_struct_to_string(tcontext, &t, &tlen);
-		context_struct_to_string(newcontext, &n, &nlen);
+		context_to_string(policydb, scontext, &s, &slen);
+		context_to_string(policydb, tcontext, &t, &tlen);
+		context_to_string(policydb, newcontext, &n, &nlen);
 		DEBUG(__FUNCTION__, "invalid context %s for "
 			"scontext=%s tcontext=%s tclass=%s\n",
 			n, s, t, policydb->p_class_val_to_name[tclass-1]);
@@ -848,7 +839,7 @@ static inline int convert_context_handle
 		sepol_security_context_t s;
 		size_t len;
 
-		context_struct_to_string(context, &s, &len);
+		context_to_string(policydb, context, &s, &len);
 		DEBUG(__FUNCTION__, "context %s is invalid\n", s);
 		free(s);
 		return 0;
@@ -926,7 +917,7 @@ static int convert_context(sepol_securit
 	return 0;
 
       bad:
-	context_struct_to_string(&oldc, &s, &len);
+	context_to_string(policydb, &oldc, &s, &len);
 	context_destroy(&oldc);
 	DEBUG(__FUNCTION__, "invalidating context %s\n", s);
 	free(s);

--------------070703040602070407090800--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
