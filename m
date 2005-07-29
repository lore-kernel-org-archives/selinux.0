Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j6TJU8gA003229
	for <selinux@tycho.nsa.gov>; Fri, 29 Jul 2005 15:30:09 -0400 (EDT)
Received: from moss-lions.epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j6TJN1hF016984
	for <selinux@tycho.nsa.gov>; Fri, 29 Jul 2005 19:23:01 GMT
Received: from moss-lions.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by moss-lions.epoch.ncsc.mil (8.13.4/8.13.4) with ESMTP id j6TJODPq019911
	for <selinux@tycho.nsa.gov>; Fri, 29 Jul 2005 15:24:13 -0400
Received: (from jwcart2@localhost)
	by moss-lions.epoch.ncsc.mil (8.13.4/8.13.4/Submit) id j6TJODZ1019910
	for selinux@tycho.nsa.gov; Fri, 29 Jul 2005 15:24:13 -0400
Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j6THcBgA002110
	for <selinux@tycho.nsa.gov>; Fri, 29 Jul 2005 13:38:11 -0400 (EDT)
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j6THWCC2025430
	for <selinux@tycho.nsa.gov>; Fri, 29 Jul 2005 17:32:12 GMT
Subject: [ libsepol ] User, context, port records. Bugfixes.
From: Ivan Gyurdiev <gyurdiev@redhat.com>
Reply-To: gyurdiev@redhat.com
To: Daniel J Walsh <dwalsh@redhat.com>, jbrindle@tresys.com,
   selinux@tycho.nsa.gov
Content-Type: multipart/mixed; boundary="=-07m7xC2v+3WJ5jIR8FTy"
Date: Fri, 29 Jul 2005 13:29:13 -0400
Message-Id: <1122658154.28860.19.camel@celtics.boston.redhat.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-07m7xC2v+3WJ5jIR8FTy
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

The following patch replaces the previously added
high level structures: 

sepol_ctxinfo_t
sepol_portinfo_t
sepol_uinfo_t

with opaque records:

sepol_context_t
sepol_port_t
sepol_user_t

The idea is that those opaque records can
be re-used by libsemanage (not sure exactly
how to do that without re-implementing
the entire interface and calling each sepol
function). In any case, the change stands 
independently of libsemanage, and using
opaque data structures in interfaces is 
a good idea.

Other changes:
- changed namespace to some functions in context.c
to sepol_ctx_struct, in order not to conflict with
the record namespace

- fixed a memory leak in context.c on mls-disabled 
systems with mls contexts

- fixed improper use of mls_context_to_sid in users.c
that would cause a crash.

- made some error messages more clear/verbose


--=-07m7xC2v+3WJ5jIR8FTy
Content-Disposition: attachment; filename=libsepol.diff
Content-Type: text/x-patch; name=libsepol.diff; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -Naur libsepol-1.7.6.orig/include/sepol/context.h libsepol-1.7.6.new/include/sepol/context.h
--- libsepol-1.7.6.orig/include/sepol/context.h	2005-07-28 09:32:50.000000000 -0400
+++ libsepol-1.7.6.new/include/sepol/context.h	2005-07-29 12:06:04.000000000 -0400
@@ -21,18 +21,7 @@
 
 #include <sepol/ebitmap.h>
 #include <sepol/mls_types.h>
-
-/* 
- * High level representation of the context 
- * This structure provides sufficient information
- * to construct a security context. 
- */
-typedef struct sepol_ctxinfo {
-	const char* user;
-	const char* role;
-	const char* type;
-	const char* mls;
-} sepol_ctxinfo_t;
+#include <sepol/context_record.h>
 
 /*
  * A security context consists of an authenticated user
@@ -125,31 +114,28 @@
 struct policydb;
 
 /* Create a context structure from high level representation */
-extern int sepol_context_create(
+extern int sepol_ctx_struct_create(
 	struct policydb *policydb,
 	context_struct_t** cptr,
-	sepol_ctxinfo_t* data);
+	sepol_context_t data);
 
 /* Create a context structure from string representation */
-extern int sepol_context_from_string(
+extern int sepol_ctx_struct_from_string(
 	struct policydb* policydb,
 	context_struct_t** cptr,
 	const char* con_str,
 	size_t con_str_len);
 
 /* Check if the provided context is valid for this policy */
-extern int sepol_context_is_valid(
+extern int sepol_ctx_struct_is_valid(
 	struct policydb *policydb, 
 	context_struct_t *context);
 
 /* Extract the context as string */
-extern int sepol_context_to_string(
+extern int sepol_ctx_struct_to_string(
 	struct policydb *policydb,
 	context_struct_t * context,
 	char ** result,
 	size_t *result_len);
 
 #endif	/* _SEPOL_CONTEXT_H_ */
-
-/* FLASK */
-
diff -Naur libsepol-1.7.6.orig/include/sepol/context_record.h libsepol-1.7.6.new/include/sepol/context_record.h
--- libsepol-1.7.6.orig/include/sepol/context_record.h	1969-12-31 19:00:00.000000000 -0500
+++ libsepol-1.7.6.new/include/sepol/context_record.h	2005-07-29 12:00:44.000000000 -0400
@@ -0,0 +1,35 @@
+#ifndef _SEPOL_CONTEXT_RECORD_H_
+#define _SEPOL_CONTEXT_RECORD_H_ 
+
+struct sepol_context;
+typedef struct sepol_context* sepol_context_t;
+
+/* We don't need a key, because the context is never stored
+ * in a data collection by itself */
+
+/* User */
+extern const char* sepol_context_get_user(sepol_context_t con);
+extern int sepol_context_set_user(sepol_context_t con, const char* user);
+
+/* Role */
+extern const char* sepol_context_get_role(sepol_context_t con);
+extern int sepol_context_set_role(sepol_context_t con, const char* role);
+
+/* Type */
+extern const char* sepol_context_get_type(sepol_context_t con);
+extern int sepol_context_set_type(sepol_context_t con, const char* type);
+
+/* MLS */
+extern const char* sepol_context_get_mls(sepol_context_t con);
+extern int sepol_context_set_mls(sepol_context_t con, const char* mls_range);
+
+/* Create/Clone/Destroy */
+extern int sepol_context_create(sepol_context_t* con_ptr);
+extern int sepol_context_clone(sepol_context_t con, sepol_context_t* con_ptr);
+extern void sepol_context_free(sepol_context_t con);
+
+/* Parse to/from string */
+extern int sepol_context_from_string(const char* str, sepol_context_t* con);
+extern char* sepol_context_to_string(sepol_context_t con);
+
+#endif 
diff -Naur libsepol-1.7.6.orig/include/sepol/interfaces.h libsepol-1.7.6.new/include/sepol/interfaces.h
--- libsepol-1.7.6.orig/include/sepol/interfaces.h	2005-07-28 09:32:51.000000000 -0400
+++ libsepol-1.7.6.new/include/sepol/interfaces.h	2005-07-29 12:19:32.000000000 -0400
@@ -1,11 +1,11 @@
 #include <sepol/policydb.h>
-#include <sepol/context.h>
+#include <sepol/context_record.h>
 
 /* High level representation of an interface */
 typedef struct sepol_iface {
         const char* name;
-        sepol_ctxinfo_t netif_con;
-        sepol_ctxinfo_t netmsg_con;
+        sepol_context_t netif_con;
+        sepol_context_t netmsg_con;
 } sepol_iface_t;
 
 /* Create a low level interface structure from
diff -Naur libsepol-1.7.6.orig/include/sepol/policydb.h libsepol-1.7.6.new/include/sepol/policydb.h
--- libsepol-1.7.6.orig/include/sepol/policydb.h	2005-07-28 09:32:51.000000000 -0400
+++ libsepol-1.7.6.new/include/sepol/policydb.h	2005-07-29 11:07:54.000000000 -0400
@@ -454,7 +454,7 @@
 
 /* Deprecated */
 static inline int policydb_context_isvalid(policydb_t *p, context_struct_t *c) {
-	return sepol_context_is_valid(p,c);
+	return sepol_ctx_struct_is_valid(p,c);
 }
 
 extern void symtabs_destroy(symtab_t *symtab);
diff -Naur libsepol-1.7.6.orig/include/sepol/port_record.h libsepol-1.7.6.new/include/sepol/port_record.h
--- libsepol-1.7.6.orig/include/sepol/port_record.h	1969-12-31 19:00:00.000000000 -0500
+++ libsepol-1.7.6.new/include/sepol/port_record.h	2005-07-29 12:02:55.000000000 -0400
@@ -0,0 +1,46 @@
+#ifndef _SEPOL_PORT_RECORD_H_
+#define _SEPOL_PORT_RECORD_H_ 
+
+#include <sepol/context_record.h>
+
+struct sepol_port;
+struct sepol_port_key;
+typedef struct sepol_port* sepol_port_t;
+typedef struct sepol_port_key* sepol_port_key_t;
+
+#define SEPOL_PROTO_UDP 0
+#define SEPOL_PROTO_TCP 1
+
+/* Key */
+extern int sepol_port_compare(
+	sepol_port_t port, 
+	sepol_port_key_t key);
+
+extern int sepol_port_key_create(
+	int low, int high, int proto,
+	sepol_port_key_t* key);
+
+extern void sepol_port_key_free(
+	sepol_port_key_t key);
+
+/* Protocol */
+extern int sepol_port_get_proto(sepol_port_t port);
+extern int sepol_port_set_proto(sepol_port_t port, int proto);
+extern const char* sepol_port_get_proto_str(sepol_port_t port);
+
+/* Port */
+extern int sepol_port_get_low(sepol_port_t port);
+extern int sepol_port_get_high(sepol_port_t port);
+extern int sepol_port_set_port(sepol_port_t port, int port_num);
+extern int sepol_port_set_range(sepol_port_t port, int low, int high);
+
+/* Context */
+extern sepol_context_t sepol_port_get_con(sepol_port_t port);
+extern int sepol_port_set_con(sepol_port_t port, sepol_context_t con);
+
+/* Create/Clone/Destroy */
+extern int sepol_port_create(sepol_port_t* port_ptr);
+extern int sepol_port_clone(sepol_port_t port, sepol_port_t* port_ptr);
+extern void sepol_port_free(sepol_port_t port);
+
+#endif
diff -Naur libsepol-1.7.6.orig/include/sepol/ports.h libsepol-1.7.6.new/include/sepol/ports.h
--- libsepol-1.7.6.orig/include/sepol/ports.h	2005-07-28 09:32:50.000000000 -0400
+++ libsepol-1.7.6.new/include/sepol/ports.h	2005-07-29 12:07:54.000000000 -0400
@@ -2,41 +2,26 @@
 #define _SEPOL_PORTS_H_
 
 #include <sepol/policydb.h>
-#include <sepol/context.h>
-
-#define SEPOL_TCP_PROTO 0
-#define SEPOL_UDP_PROTO 1
-
-/* High level representation of a port */
-typedef struct sepol_portinfo {
-
-	/* Port parameters */
-	int protocol;
-	int low, high;
-
-	/* Sufficient information to construct 
-	 * the port context */
-	sepol_ctxinfo_t con;
-} sepol_portinfo_t;
+#include <sepol/port_record.h>
 
 /* Create a port structure from high level representation */
-extern int sepol_port_create(
+extern int sepol_port_struct_create(
 	policydb_t* policydb,
 	ocontext_t** port,
-	sepol_portinfo_t* data);
+	sepol_port_t data);
 
 /* Get the current context mapping
  * for this port. Returns 1 if no match, -1 on error, 0 on
  * success. The returned data is allocated on the heap */
 int sepol_port_get_context(
 	policydb_t* policydb,
-	sepol_portinfo_t* data,
+	sepol_port_t data,
 	char** con_str,
 	size_t* con_str_len);
 
 /* Load the given port into policy. No shadowing is allowed. */
 extern int sepol_port_load(
 	policydb_t* policydb, 
-	sepol_portinfo_t* port);
+	sepol_port_t data);
 
-#endif /* _SEPOL_PORTS_H_ */
+#endif
diff -Naur libsepol-1.7.6.orig/include/sepol/user_record.h libsepol-1.7.6.new/include/sepol/user_record.h
--- libsepol-1.7.6.orig/include/sepol/user_record.h	1969-12-31 19:00:00.000000000 -0500
+++ libsepol-1.7.6.new/include/sepol/user_record.h	2005-07-29 12:36:03.000000000 -0400
@@ -0,0 +1,61 @@
+#ifndef _SEPOL_USER_RECORD_H_
+#define _SEPOL_USER_RECORD_H_
+
+struct sepol_user;
+struct sepol_user_key;
+typedef struct sepol_user* sepol_user_t;
+typedef struct sepol_user_key* sepol_user_key_t;
+
+/* Key */
+extern int sepol_user_key_create(
+	const char* name,
+	sepol_user_key_t* key);
+
+extern void sepol_user_key_free(
+	sepol_user_key_t key);
+
+extern int sepol_user_compare(
+	sepol_user_t user,
+	sepol_user_key_t key);
+	
+/* Name */
+extern const char* sepol_user_get_name(sepol_user_t user);
+extern int sepol_user_set_name(sepol_user_t user, const char* name);
+
+/* MLS */
+extern const char* sepol_user_get_mlslevel(
+	sepol_user_t user);
+
+extern int sepol_user_set_mlslevel(
+	sepol_user_t user, 
+	const char* mls_level);
+
+extern const char* sepol_user_get_mlsrange(
+	sepol_user_t user);
+
+extern int sepol_user_set_mlsrange(
+	sepol_user_t user, 
+	const char* mls_range);
+
+/* Role management */
+extern int sepol_user_get_num_roles(sepol_user_t user);
+extern const char* sepol_user_get_defrole(sepol_user_t user);
+extern int sepol_user_add_role(sepol_user_t user, const char* role);
+extern int sepol_user_del_role(sepol_user_t user, const char* role);
+extern int sepol_user_has_role(sepol_user_t user, const char* role);
+extern int sepol_user_set_defrole(sepol_user_t user, const char* role);
+extern int sepol_user_get_roles(
+	sepol_user_t user,
+	const char*** roles_arr, 
+	size_t* num_roles);
+extern int sepol_user_set_roles(
+	sepol_user_t user,
+	const char** roles_arr,
+	size_t num_roles);
+
+/* Create/Clone/Destroy */
+extern int sepol_user_create(sepol_user_t* user_ptr);
+extern int sepol_user_clone(sepol_user_t user, sepol_user_t* user_ptr);
+extern void sepol_user_free(sepol_user_t user);
+
+#endif
diff -Naur libsepol-1.7.6.orig/include/sepol/users.h libsepol-1.7.6.new/include/sepol/users.h
--- libsepol-1.7.6.orig/include/sepol/users.h	2005-07-28 09:32:51.000000000 -0400
+++ libsepol-1.7.6.new/include/sepol/users.h	2005-07-29 12:06:01.000000000 -0400
@@ -2,17 +2,9 @@
 #define _SEPOL_USERS_H_
 
 #include <sepol/policydb.h>
+#include <sepol/user_record.h>
 #include <sys/types.h>
 
-/* High level representation of a user */
-typedef struct sepol_uinfo {
-	const char* name;
-	const char** roles;
-	size_t num_roles;
-	const char* mls_level;
-	const char* mls_range;
-} sepol_uinfo_t;
-
 /* Clear unused users */
 extern void sepol_clear_unused_users(
 	policydb_t* policydb);
@@ -21,7 +13,7 @@
    Load allows duplicates, but add does not. */
 extern int sepol_user_add(
 	policydb_t* policydb,
-	sepol_uinfo_t* user); 
+	sepol_user_t user); 
 
 extern int sepol_user_del(
 	policydb_t* policydb, 
@@ -29,7 +21,7 @@
 
 extern int sepol_user_load(
 	policydb_t* policydb, 
-	sepol_uinfo_t* user);
+	sepol_user_t user);
 
 /* Check if users or roles are valid */
 extern int sepol_user_is_valid(
diff -Naur libsepol-1.7.6.orig/src/context.c libsepol-1.7.6.new/src/context.c
--- libsepol-1.7.6.orig/src/context.c	2005-07-28 09:32:39.000000000 -0400
+++ libsepol-1.7.6.new/src/context.c	2005-07-29 13:01:16.000000000 -0400
@@ -3,6 +3,7 @@
 #include <sepol/policydb.h>
 #include <sepol/context.h>
 #include <sepol/mls.h>
+#include <sepol/context_record.h>
 
 #include "debug.h"
 
@@ -10,7 +11,7 @@
  * Return 1 if the fields in the security context
  * structure `c' are valid.  Return 0 otherwise.
  */
-int sepol_context_is_valid(policydb_t *p, context_struct_t *c)
+int sepol_ctx_struct_is_valid(policydb_t *p, context_struct_t *c)
 {
 	role_datum_t *role;
 	user_datum_t *usrdatum;
@@ -62,7 +63,7 @@
  * to point to this string and set `*scontext_len' to
  * the length of the string.
  */
-int sepol_context_to_string(
+int sepol_ctx_struct_to_string(
 	policydb_t* policydb,
 	context_struct_t * context,
 	char **result,
@@ -118,10 +119,10 @@
 /* Create a policy-dependent context structure, corresponding
  * to the provided high level representation */
 
-int sepol_context_create(
+int sepol_ctx_struct_create(
 	policydb_t* policydb, 
 	context_struct_t** cptr, 
-	sepol_ctxinfo_t* data) {
+	sepol_context_t data) {
 
 	context_struct_t* scontext = NULL;
 	user_datum_t* usrdatum;
@@ -129,13 +130,16 @@
 	type_datum_t* typdatum;
 
 	/* Hashtab keys are not constant - suppress warnings */
-	char* user = strdup(data->user); 
-	char* role = strdup(data->role);
-	char* type = strdup(data->type);
-	char* mls = data->mls ? strdup(data->mls): NULL;
+	char* user = strdup(sepol_context_get_user(data)); 
+	char* role = strdup(sepol_context_get_role(data));
+	char* type = strdup(sepol_context_get_type(data));
+
+	const char* tmp = sepol_context_get_mls(data);
+	char* mls = tmp ? strdup(tmp): NULL;
+	char* mls_ptr = mls;
 
 	scontext = (context_struct_t*) malloc(sizeof(context_struct_t));
-	if (!user || !role || !type || (data->mls && !mls) || !scontext) {
+	if (!user || !role || !type || (tmp && !mls) || !scontext) {
 		DEBUG(__FUNCTION__, "out of memory\n"); 
 		goto err;
 	}
@@ -170,20 +174,23 @@
 
 	/* MLS */
 	if (mls && !sepol_mls_enabled()) {
-		DEBUG(__FUNCTION__, "mls context found, but mls is disabled\n");
+		DEBUG(__FUNCTION__, "Warning! mls context \"%s\" found, "
+			"but mls is disabled\n", mls);
+		free(mls);
 		mls = NULL;
 	}
 	else if (!mls && sepol_mls_enabled()) {
-		DEBUG(__FUNCTION__, "mls is enabled, but no mls context found\n");
+		DEBUG(__FUNCTION__, "mls is enabled, but no "
+			"mls context found\n");
 		goto err_destroy;
 	}
-	if (mls && (mls_context_to_sid(policydb, '$', &mls, scontext) < 0)) {
-		DEBUG(__FUNCTION__, "invalid mls context %s\n", mls);
+	if (mls && (mls_context_to_sid(policydb, '$', &mls_ptr, scontext) < 0)) {
+		DEBUG(__FUNCTION__, "invalid mls context: %s\n", mls);
 		goto err_destroy;
 	}
 
 	/* Validity check */
-	if (!sepol_context_is_valid(policydb, scontext)) {
+	if (!sepol_ctx_struct_is_valid(policydb, scontext)) {
 		if (mls)
 			DEBUG(__FUNCTION__, 
 				"invalid security context: %s:%s:%s:%s\n",
@@ -218,21 +225,16 @@
 /*
  * Create a context structure from the provided string.
  */
-int sepol_context_from_string(
+int sepol_ctx_struct_from_string(
 	policydb_t* policydb,
 	context_struct_t** cptr,
 	const char* con_str,
 	size_t con_str_len) { 
 
 	char* con_cpy = NULL;
-	sepol_ctxinfo_t ctx_info;
-	char *p;
+	sepol_context_t ctx_info = NULL;
 
-	/* Copy the string so that we can modify the copy as we parse it.
-	   The string should already by null terminated, but we append a
-	   null suffix to the copy to avoid problems with the existing
-	   attr package, which doesn't view the null terminator as part
-	   of the attribute value. */
+	/* sepol_context_from_string expects a NULL-terminated string */
 	con_cpy = malloc(con_str_len + 1);
 	if (!con_cpy) {
 		DEBUG(__FUNCTION__, "out of memory\n");
@@ -240,46 +242,21 @@
 	}
 	memcpy(con_cpy, con_str, con_str_len);
 	con_cpy[con_str_len] = '\0';
-	p = (char *) con_cpy;
 
-        /* Find user */
-	ctx_info.user = p;
-	while (*p && *p != ':')
-		p++;
-	if (*p == '\0')
-		goto parse_err;
-	*p++ = '\0';
-
-        /* Find role */
-	ctx_info.role = p;
-	while (*p && *p != ':')
-		p++;
-	if (*p == '\0')
-		goto parse_err;
-	*p++ = '\0';
-
-        /* Find type and MLS */
-	ctx_info.type = p;
-	while (*p && *p != ':')
-		p++;
-	if (sepol_mls_enabled() && (*p == ':'))
-		ctx_info.mls = (p + 1);
-	else
-		ctx_info.mls = NULL;
-	*p++ = '\0';
+	if (sepol_context_from_string(con_cpy, &ctx_info) < 0)
+		goto err;
 
 	/* Now create from the data structure */
-	if (sepol_context_create(policydb, cptr, &ctx_info) < 0)
+	if (sepol_ctx_struct_create(policydb, cptr, ctx_info) < 0)
 		goto err;
 
 	free(con_cpy);
+	sepol_context_free(ctx_info);
 	return STATUS_SUCCESS;
 	
-	parse_err:
-	DEBUG(__FUNCTION__, "invalid security context: %s\n", con_str);
-
 	err:
 	DEBUG(__FUNCTION__, "unable to create context structure\n");
 	free(con_cpy);
+	sepol_context_free(ctx_info);
 	return STATUS_ERR;
 }
diff -Naur libsepol-1.7.6.orig/src/context_record.c libsepol-1.7.6.new/src/context_record.c
--- libsepol-1.7.6.orig/src/context_record.c	1969-12-31 19:00:00.000000000 -0500
+++ libsepol-1.7.6.new/src/context_record.c	2005-07-29 12:49:45.000000000 -0400
@@ -0,0 +1,257 @@
+#include <stdlib.h>
+#include <string.h>
+#include <stdio.h>
+
+#include <sepol/context_record.h>
+#include "debug.h"
+
+struct sepol_context {
+
+	/* Selinux user */
+	char* user;
+
+	/* Selinux role */
+	char* role;
+
+	/* Selinux type */
+	char* type;
+
+	/* MLS */
+	char* mls;
+};
+
+/* User */
+const char* sepol_context_get_user(sepol_context_t con) {
+	return con->user;
+}
+
+int sepol_context_set_user(sepol_context_t con, const char* user) {
+	con->user = strdup(user);
+	if (!con->user) { 
+		DEBUG(__FUNCTION__, "out of memory, could not set "
+			"context user to %s\n", user);
+		return STATUS_ERR;
+	}
+	return STATUS_SUCCESS;
+}
+
+/* Role */
+const char* sepol_context_get_role(sepol_context_t con) {
+	return con->role;
+}
+
+int sepol_context_set_role(sepol_context_t con, const char* role) {
+	con->role = strdup(role);
+	if (!con->role) {
+		DEBUG(__FUNCTION__, "out of memory, could not set "
+			"context role to %s\n", role);
+		return STATUS_ERR;
+	}
+	return STATUS_SUCCESS;
+}
+
+/* Type */
+const char* sepol_context_get_type(sepol_context_t con) {
+	return con->type;
+}
+
+int sepol_context_set_type(sepol_context_t con, const char* type) {
+	con->type = strdup(type);
+	if (!con->role) {
+		DEBUG(__FUNCTION__, "out of memory, could not set "
+			"context type to %s\n", type);
+		return STATUS_ERR;
+	}
+	return STATUS_SUCCESS;
+}
+
+/* MLS */
+const char* sepol_context_get_mls(sepol_context_t con) {
+	return con->mls;
+}
+
+int sepol_context_set_mls(sepol_context_t con, const char* mls) {
+	con->mls = strdup(mls);
+	if (!con->mls) {
+		DEBUG(__FUNCTION__, "out of memory, could not set "
+			"MLS fields to %s\n", mls);
+		return STATUS_ERR;
+	}	
+	return STATUS_SUCCESS;
+}
+
+/* Create */
+int sepol_context_create(sepol_context_t* con_ptr) {
+	sepol_context_t con =
+                (sepol_context_t) malloc(sizeof(struct sepol_context));
+
+        if (!con) {
+		DEBUG(__FUNCTION__, "out of memory, could not "
+			"create context\n");
+		return STATUS_ERR;
+	}
+
+	con->user = NULL;
+	con->role = NULL;
+	con->type = NULL;
+	con->mls = NULL;
+	*con_ptr = con;
+	return STATUS_SUCCESS;
+}
+
+/* Deep copy clone */
+int sepol_context_clone(
+	sepol_context_t con,
+	sepol_context_t* con_ptr) {
+
+	sepol_context_t new_con = NULL;	
+	if (sepol_context_create(&new_con) < 0)
+		goto err;
+
+	if (!(new_con->user = strdup(con->user)))
+		goto omem;
+
+	if (!(new_con->role = strdup(con->role)))
+		goto omem;
+
+	if (!(new_con->type = strdup(con->type)))
+		goto omem;
+
+	if (con->mls && !(new_con->mls = strdup(con->mls)))
+		goto omem;
+
+	*con_ptr = new_con;
+	return STATUS_SUCCESS;
+		
+	omem:
+	DEBUG(__FUNCTION__, "out of memory\n");
+
+	err:
+	DEBUG(__FUNCTION__, "could not clone context record\n");
+	sepol_context_free(new_con);
+	return STATUS_ERR;
+}
+
+/* Destroy */
+void sepol_context_free(sepol_context_t con) {
+	if (!con)
+		return;
+
+	free(con->user);
+	free(con->role);
+	free(con->type);
+	free(con->mls);
+	free(con);
+}
+
+int sepol_context_from_string(const char* str, sepol_context_t* con) {
+
+	char *tmp = NULL, *low, *high;
+	sepol_context_t tmp_con = NULL;
+
+	if (!strcmp(str, "<<none>>")) {
+		*con = NULL;
+		return STATUS_SUCCESS;
+	}
+
+	if (sepol_context_create(&tmp_con) < 0)
+		goto err;
+
+	/* Working copy context */
+	tmp = strdup(str);
+	if (!tmp) {
+		DEBUG(__FUNCTION__, "out of memory\n");
+		goto err;
+	}
+	low = tmp;
+
+	/* Then, break it into its components */
+
+	/* User */
+	if (!(high = strchr(low, ':')))
+		goto mcontext;
+	else
+		*high++ = '\0';
+	if (sepol_context_set_user(tmp_con, low) < 0)
+		goto err;	
+	low = high;
+
+	/* Role */
+	if (!(high = strchr(low, ':')))
+		goto mcontext;
+	else
+		*high++ = '\0';
+	if (sepol_context_set_role(tmp_con, low) < 0)
+		goto err;
+	low = high;
+
+	/* Type, and possibly MLS */
+	if (!(high = strchr(low, ':'))) {
+		if (sepol_context_set_type(tmp_con, low) < 0)
+			goto err;
+	}
+	else {
+		*high++ = '\0';
+		if (sepol_context_set_type(tmp_con, low) < 0)
+			goto err;
+		low = high;
+		if (sepol_context_set_mls(tmp_con, low) < 0)
+			goto err;
+	}
+
+	free(tmp);
+	*con = tmp_con;
+	
+	return STATUS_SUCCESS;
+
+	mcontext:
+	DEBUG(__FUNCTION__, "malformed context \"%s\"\n", str);
+
+	err:
+	DEBUG(__FUNCTION__, "could not construct context from string\n");
+	free(tmp);
+	sepol_context_free(tmp_con);
+	return STATUS_ERR;
+}
+
+char* sepol_context_to_string(sepol_context_t con) {
+
+	const int user_sz = strlen(con->user);
+	const int role_sz = strlen(con->role);
+	const int type_sz = strlen(con->type);
+	const int mls_sz = (con->mls)? strlen(con->mls): 0;	
+
+	const int total_sz = user_sz + role_sz + type_sz + 
+		mls_sz + ((con->mls)? 3:2);
+
+	char* str = malloc(total_sz + 1);
+	int rc;
+
+	if (!str)
+		goto omem;
+	
+	if (con->mls) {
+		rc = snprintf(str, total_sz + 1, "%s:%s:%s:%s", 
+			con->user, con->role, con->type, con->mls);
+		if (rc < 0 || (rc == total_sz + 1)) {
+			DEBUG(__FUNCTION__, "print error\n");
+			goto err;
+		}
+	}
+	else { 		
+		rc = snprintf(str, total_sz + 1, "%s:%s:%s",
+			con->user, con->role, con->type);
+		if (rc < 0 || (rc == total_sz + 1)) {
+			DEBUG(__FUNCTION__, "print error\n");
+			goto err;
+		}
+	}
+
+	return str; 
+	omem:
+	DEBUG(__FUNCTION__, "out of memory\n");
+
+	err:
+	DEBUG(__FUNCTION__, "could not convert context to string\n");
+	return NULL;
+}
diff -Naur libsepol-1.7.6.orig/src/interfaces.c libsepol-1.7.6.new/src/interfaces.c
--- libsepol-1.7.6.orig/src/interfaces.c	2005-07-28 09:32:43.000000000 -0400
+++ libsepol-1.7.6.new/src/interfaces.c	2005-07-29 12:46:14.000000000 -0400
@@ -30,15 +30,15 @@
 		goto omem;
 
 	/* Interface Context */
-	if (sepol_context_create(policydb, &tmp_ifcon, 
-		&data->netif_con) < 0)
+	if (sepol_ctx_struct_create(policydb, 
+		&tmp_ifcon, data->netif_con) < 0)
 		goto err;
 	context_cpy(&tmp_iface->context[0], tmp_ifcon);
 	free(tmp_ifcon);
 
 	/* Message Context */
-	if (sepol_context_create(policydb, &tmp_msgcon,
-		&data->netmsg_con) < 0)
+	if (sepol_ctx_struct_create(policydb, &tmp_msgcon, 
+		data->netmsg_con) < 0)
 		goto err;
 	context_cpy(&tmp_iface->context[1], tmp_msgcon);
 	free(tmp_msgcon);
@@ -67,11 +67,11 @@
 	head = policydb->ocontexts[OCON_NETIF];
 	for (c = head; c; c = c->next) {
 		if (!strcmp(data->name, c->u.name)) { 
-			if (sepol_context_to_string(policydb, 
+			if (sepol_ctx_struct_to_string(policydb, 
 				&c->context[0], ifcon_str, ifcon_str_len) < 0)
 				goto err;
 	
-			if (sepol_context_to_string(policydb,
+			if (sepol_ctx_struct_to_string(policydb,
 				&c->context[1], msgcon_str, msgcon_str_len) < 0)
 				goto err;
 
@@ -82,7 +82,7 @@
 	return STATUS_NODATA;
 
 	err: 
-	DEBUG(__FUNCTION__, "could not construct  context string for "
+	DEBUG(__FUNCTION__, "could not construct context string for "
 		"interface %s\n", data->name);
 	return STATUS_ERR;
 }
diff -Naur libsepol-1.7.6.orig/src/port_record.c libsepol-1.7.6.new/src/port_record.c
--- libsepol-1.7.6.orig/src/port_record.c	1969-12-31 19:00:00.000000000 -0500
+++ libsepol-1.7.6.new/src/port_record.c	2005-07-29 12:08:55.000000000 -0400
@@ -0,0 +1,168 @@
+#include <stdlib.h>
+#include <string.h>
+
+#include <sepol/port_record.h>
+#include <sepol/context_record.h>
+#include "debug.h"
+
+struct sepol_port {
+	/* Low - High range. Same for single ports. */
+	int low, high;
+	
+	/* Protocol */
+	int proto;
+
+	/* Context */
+	sepol_context_t con;
+};
+
+struct sepol_port_key {
+	/* Low - High range. Same for single ports. */
+	int low, high;
+	
+	/* Protocol */
+	int proto;	
+};
+
+/* Key */
+int sepol_port_key_create(
+	int low, int high, int proto, 
+	sepol_port_key_t* key_ptr) {
+
+	sepol_port_key_t tmp_key = 
+		(sepol_port_key_t) malloc(sizeof(struct sepol_port_key));
+
+	if (!tmp_key) {
+		DEBUG(__FUNCTION__, "out of memory, could not create "
+			"port key\n");
+		return STATUS_ERR;
+	}
+
+	tmp_key->low = low;
+	tmp_key->high = high;
+	tmp_key->proto = proto;
+	
+	*key_ptr = tmp_key;
+	return STATUS_SUCCESS;
+}
+
+void sepol_port_key_free(sepol_port_key_t key) {
+	free(key);
+}
+
+int sepol_port_compare(
+	sepol_port_t port, 
+	sepol_port_key_t key) {
+
+	if ((port->low <= key->low) && 
+	    (port->high >= key->high) &&
+	    (port->proto == key->proto))
+		return 0;
+
+	return 1;
+}
+
+/* Port */
+int sepol_port_get_low(sepol_port_t port) {
+	return port->low;
+}
+
+int sepol_port_get_high(sepol_port_t port) {
+	return port->high;
+}
+
+int sepol_port_set_port(sepol_port_t port, int port_num) {
+	port->low = port_num;
+	port->high = port_num;
+	return STATUS_SUCCESS;
+}
+
+int sepol_port_set_range(sepol_port_t port, int low, int high) {
+	port->low = low;
+	port->high = high;
+	return STATUS_SUCCESS;
+}
+
+/* Protocol */
+int sepol_port_get_proto(sepol_port_t port) {
+	return port->proto;
+}
+
+const char* sepol_port_get_proto_str(sepol_port_t port) {
+	switch (port->proto) {
+		case SEPOL_PROTO_UDP:
+			return "udp";
+		case SEPOL_PROTO_TCP:
+			return "tcp";
+		default:
+			return "???";
+	}	
+}
+
+int sepol_port_set_proto(sepol_port_t port, int proto) {
+	port->proto = proto;
+	return STATUS_SUCCESS;
+}
+
+/* Create */
+int sepol_port_create(sepol_port_t* port) {
+	sepol_port_t tmp_port = 
+		(sepol_port_t) malloc(sizeof(struct sepol_port));
+
+        if (!tmp_port) {
+		DEBUG(__FUNCTION__, "out of memory, could not create "
+			"port record\n");
+		return STATUS_ERR;
+	}
+
+	tmp_port->low = 0;
+	tmp_port->high = 0;
+	tmp_port->proto = SEPOL_PROTO_UDP;
+	tmp_port->con = NULL;
+	*port = tmp_port;	
+
+	return STATUS_SUCCESS;
+}
+
+/* Deep copy clone */
+int sepol_port_clone(sepol_port_t port, sepol_port_t* port_ptr) {
+
+	sepol_port_t new_port = NULL;
+	if (sepol_port_create(&new_port) < 0)
+		goto err;
+
+	new_port->low = port->low;
+	new_port->high = port->high;
+	new_port->proto = port->proto;
+
+	if (port->con && 
+	   (sepol_context_clone(port->con, &new_port->con) < 0))
+		goto err;	
+
+	*port_ptr = new_port;
+	return STATUS_SUCCESS;
+
+	err:
+	DEBUG(__FUNCTION__, "could not clone port record\n");
+	sepol_port_free(new_port);
+	return STATUS_ERR;
+}
+
+/* Destroy */
+void sepol_port_free(sepol_port_t port) {
+	if (!port)
+		return;
+	
+	sepol_context_free(port->con);
+	free(port);
+}
+
+/* Context */
+sepol_context_t sepol_port_get_con(sepol_port_t port) {
+	return port->con;
+}
+
+int sepol_port_set_con(sepol_port_t port, sepol_context_t con) {
+	port->con = con;
+	return STATUS_SUCCESS;
+}
diff -Naur libsepol-1.7.6.orig/src/ports.c libsepol-1.7.6.new/src/ports.c
--- libsepol-1.7.6.orig/src/ports.c	2005-07-28 09:32:43.000000000 -0400
+++ libsepol-1.7.6.new/src/ports.c	2005-07-29 12:08:09.000000000 -0400
@@ -8,23 +8,13 @@
 #include <sepol/sidtab.h>
 #include <sepol/services.h>
 #include <sepol/ports.h>
-
-static const char* proto_to_str(int proto) {
-	switch(proto) {
-		case SEPOL_TCP_PROTO:
-			return "TCP";
-		case SEPOL_UDP_PROTO:
-			return "UDP";
-		default:
-			return "???";
-	}
-}
+#include <sepol/port_record.h>
 
 static int sepol2ipproto(int proto) {
 	switch(proto) {
-		case SEPOL_TCP_PROTO:
+		case SEPOL_PROTO_TCP:
 			return IPPROTO_TCP;
-		case SEPOL_UDP_PROTO:
+		case SEPOL_PROTO_UDP:
 			return IPPROTO_UDP;
 		default:
 			DEBUG(__FUNCTION__, "unsupported protocol %d\n",
@@ -35,10 +25,10 @@
 
 /* Create a low level port structure from
  * a high level representation */
-int sepol_port_create(
+int sepol_port_struct_create(
 	policydb_t* policydb,
 	ocontext_t** port,
-	sepol_portinfo_t* data) {
+	sepol_port_t data) {
 
 	ocontext_t* tmp_port = NULL;
 	context_struct_t* tmp_con = NULL;
@@ -51,22 +41,24 @@
 	}
 	
 	/* Process protocol */
-	tmp_proto = sepol2ipproto(data->protocol);
+	tmp_proto = sepol2ipproto(sepol_port_get_proto(data));
 	if (tmp_proto < 0)
 		goto err;
 	tmp_port->u.port.protocol = tmp_proto;
 
 	/* Port range */
-	tmp_port->u.port.low_port = data->low;
-	tmp_port->u.port.high_port = data->high;
-	if (data->low > data->high) {
+	tmp_port->u.port.low_port = sepol_port_get_low(data);
+	tmp_port->u.port.high_port = sepol_port_get_high(data);
+	if (tmp_port->u.port.low_port > tmp_port->u.port.high_port) {
 		DEBUG(__FUNCTION__, "low port %d exceeds high port %d\n",
-			data->low, data->high);
+			tmp_port->u.port.low_port, 
+			tmp_port->u.port.high_port);
 		goto err;
 	}
 
 	/* Context */
-	if (sepol_context_create(policydb, &tmp_con, &data->con) < 0)
+	if (sepol_ctx_struct_create(policydb, &tmp_con, 
+		sepol_port_get_con(data)) < 0)
 		goto err;
 	context_cpy(&tmp_port->context[0], tmp_con);
 	free(tmp_con);
@@ -83,14 +75,14 @@
 /* Get the current context mapping for this port */
 int sepol_port_get_context(
 	policydb_t* policydb,
-	sepol_portinfo_t* data,
+	sepol_port_t data,
 	char** con_str,	
 	size_t* con_str_len) {
 
-	int low = data->low;	
-	int high = data->high;
+	int low = sepol_port_get_low(data);	
+	int high = sepol_port_get_high(data);
 
-	int proto = sepol2ipproto(data->protocol);
+	int proto = sepol2ipproto(sepol_port_get_proto(data));
 	if (proto < 0)
 		goto err;
 
@@ -108,7 +100,7 @@
 
 		if ((low == low2 && high == high2) ||
 		    (low2 <= low && high2 >= high)) {
-			if (sepol_context_to_string(policydb, con2, 
+			if (sepol_ctx_struct_to_string(policydb, con2, 
 				con_str, con_str_len) < 0)
 				goto err;		
 	
@@ -120,8 +112,8 @@
 
 	err: 
 	DEBUG(__FUNCTION__, "could not retrieve context string for "
-		"port entry %s %d-%d\n", proto_to_str(data->protocol), 
-			low, high);
+		"port entry %s %d-%d\n", 
+			sepol_port_get_proto_str(data), low, high);
 	return STATUS_ERR;
 
 }
@@ -129,14 +121,14 @@
 /* Load a port into policy */
 int sepol_port_load(
 	policydb_t* policydb, 
-	sepol_portinfo_t* data) {
+	sepol_port_t data) {
 
 	ocontext_t* port = NULL;
 	char* dup_match;
 	size_t dup_size; 
 	int rc;
 
-	if (sepol_port_create(policydb, &port, data) < 0)
+	if (sepol_port_struct_create(policydb, &port, data) < 0)
 		goto err;
 
 	rc = sepol_port_get_context(policydb, data, &dup_match, &dup_size);
@@ -146,8 +138,9 @@
 	else if (rc != STATUS_NODATA) {
 		DEBUG(__FUNCTION__, "port entry for %s %d-%d "
 			"is already mapped to context %s\n",
-			proto_to_str(data->protocol), 
-			data->low, data->high, dup_match);
+			sepol_port_get_proto_str(data),
+			sepol_port_get_low(data),
+			sepol_port_get_high(data), dup_match);
 		goto err;
 	}
 	
@@ -159,7 +152,9 @@
 
 	err:
 	DEBUG(__FUNCTION__, "error while loading port %s %d-%d\n",
-		proto_to_str(data->protocol), data->low, data->high);
+		sepol_port_get_proto_str(data),
+		sepol_port_get_low(data),
+		sepol_port_get_high(data));
 	free(port);
 	return STATUS_ERR;
 }
diff -Naur libsepol-1.7.6.orig/src/services.c libsepol-1.7.6.new/src/services.c
--- libsepol-1.7.6.orig/src/services.c	2005-07-28 09:32:43.000000000 -0400
+++ libsepol-1.7.6.new/src/services.c	2005-07-29 11:04:38.000000000 -0400
@@ -483,7 +483,7 @@
         char ** result,
         size_t *result_len) {
 
-        return sepol_context_to_string(policydb, context, result, result_len);
+        return sepol_ctx_struct_to_string(policydb, context, result, result_len);
 }
 
 /*
@@ -523,7 +523,7 @@
 	context_struct_t* context = NULL;
 
 	/* First, create the context */
-	if (sepol_context_from_string(policydb, &context, 
+	if (sepol_ctx_struct_from_string(policydb, &context, 
 		scontext, scontext_len) < 0)
 		goto err;
 
diff -Naur libsepol-1.7.6.orig/src/user_record.c libsepol-1.7.6.new/src/user_record.c
--- libsepol-1.7.6.orig/src/user_record.c	1969-12-31 19:00:00.000000000 -0500
+++ libsepol-1.7.6.new/src/user_record.c	2005-07-29 13:14:25.000000000 -0400
@@ -0,0 +1,341 @@
+#include <errno.h>
+#include <stdlib.h>
+#include <string.h>
+
+#include <sepol/user_record.h>
+#include "debug.h"
+
+struct sepol_user {
+	/* This user's name */
+	char* name;
+
+	/* This user's mls level (only required for mls) */
+	char* mls_level;
+
+	/* This user's mls range (only required for mls) */
+	char* mls_range;
+
+	/* The role array */
+	char** roles;
+
+	/* The number of roles */
+	int num_roles;
+
+	/* The default role */
+	char* def_role;
+};
+
+struct sepol_user_key {
+	/* This user's name */
+	const char* name;
+};
+
+int sepol_user_key_create(
+	const char* name,
+	sepol_user_key_t* key_ptr) {
+
+	sepol_user_key_t tmp_key = 
+		(sepol_user_key_t) malloc(sizeof (struct sepol_user_key));
+
+	if (!tmp_key) {
+		DEBUG(__FUNCTION__, "out of memory, "
+			"could not create selinux user key\n");
+		return STATUS_ERR;
+	}
+
+	tmp_key->name = name;
+
+	*key_ptr = tmp_key;
+	return STATUS_SUCCESS;
+}	
+
+void sepol_user_key_free(sepol_user_key_t key) {
+	free(key);
+}
+
+int sepol_user_compare(
+	sepol_user_t user,
+	sepol_user_key_t key) {
+	
+	if (!strcmp(user->name, key->name))
+		return 0;
+	return 1;
+}
+
+/* Name */
+const char* sepol_user_get_name(sepol_user_t user) {
+	return user->name;
+}
+
+int sepol_user_set_name(sepol_user_t user, const char* name) {
+	user->name = strdup(name);
+	if (!user->name) {
+		DEBUG(__FUNCTION__, "out of memory, "
+			"could not set name\n");
+		return STATUS_ERR;
+	}
+	return STATUS_SUCCESS;
+}
+
+/* MLS */
+const char* sepol_user_get_mlslevel(sepol_user_t user) {
+	return user->mls_level;
+}
+
+int sepol_user_set_mlslevel(sepol_user_t user, const char* mls_level) {
+	user->mls_level = strdup(mls_level);
+	if (!user->mls_level) {
+		DEBUG(__FUNCTION__, "out of memory, "
+			"could not set MLS default level\n");
+		return STATUS_ERR;
+	}
+	return STATUS_SUCCESS;
+}
+
+const char* sepol_user_get_mlsrange(sepol_user_t user) {
+	return user->mls_range;
+}
+
+int sepol_user_set_mlsrange(sepol_user_t user, const char* mls_range) {
+	user->mls_range = strdup(mls_range);
+	if (!user->mls_range) {
+		DEBUG(__FUNCTION__, "out of memory, "
+			"could not set MLS allowed range\n");
+		return STATUS_ERR;
+	}
+	return STATUS_SUCCESS;
+}
+
+/* Roles */
+int sepol_user_get_numroles(sepol_user_t user) {
+	return user->num_roles;
+}
+
+const char* sepol_user_get_defrole(sepol_user_t user) {
+	 return (user->def_role == NULL)? NULL : user->def_role;
+}
+
+int sepol_user_add_role(sepol_user_t user, const char* role) {
+
+	char* role_cp = strdup(role);
+	char* role_cp2 = strdup(role); 
+	char** roles_realloc = realloc(user->roles, user->num_roles + 1);
+	if (!role_cp || !role_cp2 || !roles_realloc) 
+		goto omem;
+
+	user->num_roles++;
+	user->roles = roles_realloc;
+	user->roles[user->num_roles - 1] = role_cp;
+	if (!user->def_role)
+		user->def_role = role_cp2;
+
+        return STATUS_SUCCESS;
+
+	omem:
+	DEBUG(__FUNCTION__, "out of memory, "
+		"could not add role %s\n", role);
+	free(role_cp);
+	free(role_cp2);
+	free(roles_realloc);
+	return STATUS_ERR;
+}
+
+int sepol_user_has_role(sepol_user_t user, const char* role) {
+	int i;
+
+	for (i = 0; i < user->num_roles; i++)
+		if (!strcmp(user->roles[i], role)) 
+			return 1;
+	return 0;
+}
+
+int sepol_user_set_roles(
+	sepol_user_t user,
+	const char** roles_arr,
+	size_t num_roles) {
+
+	int i;
+	char** tmp_roles =
+		(char**) calloc(1, sizeof(char*) * num_roles);
+	if (!tmp_roles) 
+		goto omem;
+	
+	for (i = 0; i < num_roles; i++) {
+		tmp_roles[i] = strdup(roles_arr[i]); 
+		if (!tmp_roles[i])
+			goto omem;	
+	}
+
+	user->roles = tmp_roles;
+	user->num_roles = num_roles;
+	return STATUS_SUCCESS;
+
+	omem:
+	DEBUG(__FUNCTION__, "out of memory, could not "
+		"allocate roles array for user %s\n", user->name);
+
+	for (i = 0; i < num_roles; i++ ) {
+		if (!tmp_roles[i])
+			break;
+		free(tmp_roles[i]);	
+	}
+	free(tmp_roles);
+	return STATUS_ERR;	
+}
+
+int sepol_user_get_roles(
+	sepol_user_t user, 
+	const char*** roles_arr, 
+	size_t* num_roles) {
+
+	int i;	
+	const char** tmp_roles = 
+		(const char**) malloc(sizeof (char*) * user->num_roles);
+	if (!tmp_roles)
+		goto omem;
+
+	for (i = 0; i < user->num_roles; i++)
+		tmp_roles[i] = user->roles[i];
+
+	*roles_arr = tmp_roles;
+	*num_roles = user->num_roles;
+	return STATUS_SUCCESS;
+
+	omem:
+	DEBUG(__FUNCTION__, "out of memory, could not "
+		"allocate roles array for user %s\n", user->name);
+	free(tmp_roles);
+	return STATUS_ERR;
+}
+
+int sepol_user_del_role(sepol_user_t user, const char* role) {
+	int i;
+	for (i = 0; i < user->num_roles; i++) {
+		if (!strcmp(user->roles[i], role)) {
+
+			if (user->num_roles == 1) {
+				DEBUG(__FUNCTION__,
+					"cannot delete last role "
+					"for user %s\n", user->name);
+				goto err;
+			}
+
+			free(user->roles[i]);
+			user->roles[i] = user->roles[user->num_roles-1];
+			user->num_roles--;
+
+			if (!strcmp(user->def_role, role))  {
+				free(user->def_role);
+				user->def_role = strdup(user->roles[0]);
+				if (!user->def_role)
+					goto omem;
+			}
+			return STATUS_SUCCESS;
+		}
+	}
+
+	omem:
+	DEBUG(__FUNCTION__, "out of memory\n");
+	
+	err:
+	DEBUG(__FUNCTION__, "could not allocate new default role\n");
+	return STATUS_ERR;
+}
+
+int sepol_user_set_defrole(sepol_user_t user, const char* role) {
+
+	/* First, add the role if we don't have it */
+	if (!sepol_user_has_role(user, role)) {
+		if (sepol_user_add_role(user, role) < 0)
+			goto err;
+	}
+
+	/* Set as default */
+	user->def_role = strdup(role);
+	if (!user->def_role)
+		goto omem;		
+
+
+	return STATUS_SUCCESS;
+	omem:
+	DEBUG(__FUNCTION__, "out of memory\n");
+	
+	err:
+	DEBUG(__FUNCTION__, "could not set default role for %s to %s\n",
+		user->name, role);
+	return STATUS_ERR;
+}
+
+/* Create */
+int sepol_user_create(sepol_user_t* user_ptr) {
+	sepol_user_t user = (sepol_user_t) 
+		malloc(sizeof (struct sepol_user));
+
+        if (!user) {
+		DEBUG(__FUNCTION__, "out of memory, "
+			"could not create selinux user record\n"); 
+		return STATUS_ERR;
+	}
+
+        user->roles = NULL;
+        user->def_role = NULL;
+        user->num_roles = 0;
+        user->name = NULL;
+	user->mls_level = NULL;
+	user->mls_range = NULL;
+	
+	*user_ptr = user;
+	return STATUS_SUCCESS;
+}
+
+/* Deep copy clone */
+int sepol_user_clone(sepol_user_t user, sepol_user_t* user_ptr) {
+	sepol_user_t new_user = NULL;
+	int i;
+
+	if (sepol_user_create(&new_user) < 0)
+		goto err;
+
+	if (sepol_user_set_name(new_user, user->name) < 0)
+		goto err;
+
+	for (i = 0; i < user->num_roles; i++) {
+		if (sepol_user_add_role(new_user, user->roles[i]) < 0) 
+			goto err;
+	}
+
+	if (sepol_user_set_defrole(new_user, user->def_role) < 0)
+		goto err;	
+
+	if (user->mls_level &&
+	    (sepol_user_set_mlslevel(new_user, user->mls_level) < 0))
+		goto err;
+
+	if (user->mls_range &&
+	    (sepol_user_set_mlsrange(new_user, user->mls_range) < 0))
+		goto err;
+
+	*user_ptr = new_user;
+	return STATUS_SUCCESS;
+
+	err:
+	DEBUG(__FUNCTION__, "could not clone selinux user record\n");
+	sepol_user_free(new_user);
+	return STATUS_ERR;
+}
+
+/* Destroy */
+void sepol_user_free(sepol_user_t user) {
+	int i;
+
+	if (!user)
+		return;
+	
+	free(user->name);
+	for (i = 0; i < user->num_roles; i++)
+		free(user->roles[i]);
+	free(user->roles);
+	free(user->mls_level);
+	free(user->mls_range);
+	free(user);
+}
diff -Naur libsepol-1.7.6.orig/src/users.c libsepol-1.7.6.new/src/users.c
--- libsepol-1.7.6.orig/src/users.c	2005-07-28 09:32:48.000000000 -0400
+++ libsepol-1.7.6.new/src/users.c	2005-07-29 11:56:33.000000000 -0400
@@ -1,4 +1,5 @@
 #include <stdlib.h>
+#include <sys/types.h>
 
 #include "private.h"
 #include "debug.h"
@@ -8,7 +9,7 @@
 #include <sepol/expand.h>
 #include <sepol/mls.h>
 #include <sepol/users.h>
-#include <sys/types.h>
+#include <sepol/user_record.h>
 
 int selinux_delusers = 0;
 
@@ -78,13 +79,13 @@
 
 /* Add a user to the given policydb. The user may not exist already */
 
-int sepol_user_add(policydb_t* policydb, sepol_uinfo_t* user) {
+int sepol_user_add(policydb_t* policydb, sepol_user_t user) {
 
 	char* name = NULL;
 	user_datum_t* usrdatum;
 
 	/* See if a user exists */
-	name = strdup(user->name);
+	name = strdup(sepol_user_get_name(user));
 	if (!name) 
 		goto omem;
 
@@ -105,7 +106,8 @@
 	DEBUG(__FUNCTION__, "out of memory\n");
 
 	err:
-	DEBUG(__FUNCTION__, "could not add %s to policy\n", user->name);
+	DEBUG(__FUNCTION__, "could not add %s to policy\n", 
+		sepol_user_get_name(user));
 	free(name);
 	return STATUS_ERR;
 }
@@ -152,12 +154,17 @@
  * which case the supplied data replaces the existing data. Alternatively,
  * the user could be new. */
 
-int sepol_user_load(policydb_t* policydb, sepol_uinfo_t* user) {
+int sepol_user_load(policydb_t* policydb, sepol_user_t user) {
+
+	/* For user data */	
+	const char *tmp_mlslevel, *tmp_mlsrange;
+	char *name = NULL;
+	char *mls_level = NULL, *mls_range = NULL;
+	const char **roles = NULL;
+	size_t num_roles = 0;
+	char *role = NULL;
 
-	/* For user data */
-	char *name = NULL, *role = NULL, 
-	     *mls_level = NULL, *mls_range = NULL,
-	     *key = NULL;
+	/* Low-level representation */
 	user_datum_t* usrdatum = NULL;
 	role_datum_t* roldatum;
 	int i;
@@ -166,11 +173,22 @@
 	unsigned bit;
 	int new = 0;
 
-	/* See if a user exists */
-	name = strdup(user->name);
-	if (!name) 
-		goto omem;
+	/* First, extract all the data */
+	name = strdup(sepol_user_get_name(user));
+	tmp_mlslevel = sepol_user_get_mlslevel(user);
+	tmp_mlsrange = sepol_user_get_mlsrange(user);
+	mls_level = tmp_mlslevel? strdup(tmp_mlslevel): NULL;
+	mls_range = tmp_mlsrange? strdup(tmp_mlsrange): NULL;
 
+	/* Make sure that worked properly */
+	if (sepol_user_get_roles(user, &roles, &num_roles) < 0)
+		goto err;
+
+	if (!name || (tmp_mlslevel && !mls_level) ||
+		(tmp_mlsrange && !mls_range))
+		goto omem;
+		
+	/* Now, see if a user exists */
 	usrdatum = hashtab_search(policydb->p_users.table, name);
 
 	/* If it does, we will modify it */
@@ -191,9 +209,9 @@
 	}
 
 	/* For every role */
-	for (i = 0; i < user->num_roles; i++) {
-		role = strdup(user->roles[i]);
-		if (!role) 
+	for (i = 0; i < num_roles; i++) {
+		char* role = strdup(roles[i]);
+		if (!role)
 			goto omem;
 
 		/* Search for the role */
@@ -218,61 +236,48 @@
 		role = NULL;
 	}
 
+	/* For MLS systems */
 	if (mls_enabled) {
+		char* mls_tmp;
 		context_init(&context);
 
 		/* MLS level */
-		if (user->mls_level == NULL) {
+		if (mls_level == NULL) {
 			DEBUG(__FUNCTION__, "mls is enabled, but no mls "
-					"level found for user %s\n", 
-				name);
+				"level found for user %s\n", name);
 			goto err;
 		}
 
-		mls_level = strdup(user->mls_level);
-		if (!mls_level) 
-			goto omem;
-
-		if (mls_context_to_sid(policydb, '$', &mls_level, &context)) {
+		mls_tmp = mls_level;
+		if (mls_context_to_sid(policydb, '$', &mls_tmp, &context)) {
 			DEBUG(__FUNCTION__, "invalid level %s for user %s\n", 
 				mls_level, name);
 			goto err;
 		}
-		free(mls_level);
-		mls_level = NULL;
 		memcpy(&usrdatum->dfltlevel, &context.range.level[0], 
 		        sizeof(usrdatum->dfltlevel));
 		
 		/* MLS range */
 		context_init(&context);
-		if (user->mls_range == NULL) {
-			DEBUG(__FUNCTION__, "mls is enabled, but no "
-				"mls range found for user %s\n", name);
+		if (mls_range == NULL) {
+			DEBUG(__FUNCTION__, "mls is enabled, but no mls"
+				"range found for user %s\n", name);
 			goto err;
 		}	
 
-		mls_range = strdup(user->mls_range);
-		if (!mls_range) 
-			goto omem;
-
-		if (mls_context_to_sid(policydb, '$', &mls_range, &context)) {
+		mls_tmp = mls_range; 
+		if (mls_context_to_sid(policydb, '$', &mls_tmp, &context)) {
 			DEBUG(__FUNCTION__, "invalid range %s for user %s\n", 
 				mls_range, name);
 			goto err;
 		}
-		free(mls_range);
-		mls_range = NULL;
 		memcpy(&usrdatum->range, &context.range, sizeof(usrdatum->range));
 	}
 
 	/* If there are no errors, and this is a new user, add the user to policy */
 	if (new) {
-		key = strdup(name);
 		void *tmp_ptr;
 
-		if (!key) 
-			goto omem;
-
 		/* Ensure reverse lookup array has enough space */
 		tmp_ptr = realloc(policydb->user_val_to_struct, 
 			(policydb->p_users.nprim + 1) * sizeof(user_datum_t *));
@@ -280,7 +285,6 @@
 			goto omem;
 		policydb->user_val_to_struct = tmp_ptr;
 
-
 		tmp_ptr = realloc(policydb->sym_val_to_name[SYM_USERS],
 			(policydb->p_users.nprim + 1) * sizeof(user_datum_t *));
 		if (!tmp_ptr)
@@ -289,13 +293,14 @@
 
 		/* Store user */
 		usrdatum->value = ++policydb->p_users.nprim;
-		if (hashtab_insert(policydb->p_users.table, key, 
+		if (hashtab_insert(policydb->p_users.table, name, 
 			(hashtab_datum_t) usrdatum) < 0) 
 			goto omem;
 
 		/* Set up reverse entry */
-		policydb->p_user_val_to_name[usrdatum->value - 1] = key;
+		policydb->p_user_val_to_name[usrdatum->value - 1] = name;
 		policydb->user_val_to_struct[usrdatum->value - 1] = usrdatum;
+		name = NULL;
 
 		/* Expand roles */
 		if (role_set_expand(&usrdatum->roles, &usrdatum->cache, policydb)) {
@@ -303,19 +308,22 @@
 			goto err;
 		}
 	}	
-	 
+	
 	free(name);
+	free(roles);
+	free(mls_range);
+	free(mls_level);
 	return STATUS_SUCCESS;
 
 	omem:
 	DEBUG(__FUNCTION__, "out of memory\n");
 
 	err:
-	DEBUG(__FUNCTION__, "could not load %s into policy\n", 
-		user->name);
-	free(key);
+	DEBUG(__FUNCTION__, "could not load %s into policy\n", name);
+
 	free(name);
 	free(role);
+	free(roles);
 	free(mls_range);
 	free(mls_level);
 	if (new && usrdatum) {

--=-07m7xC2v+3WJ5jIR8FTy--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
