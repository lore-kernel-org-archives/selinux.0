Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j6LHd4gA027961
	for <selinux@tycho.nsa.gov>; Thu, 21 Jul 2005 13:39:05 -0400 (EDT)
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j6LHYRrg027200
	for <selinux@tycho.nsa.gov>; Thu, 21 Jul 2005 17:34:27 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.12.11/8.12.11) with ESMTP id j6LHYSP8015483
	for <selinux@tycho.nsa.gov>; Thu, 21 Jul 2005 13:34:28 -0400
Received: from mail.boston.redhat.com (mail.boston.redhat.com [172.16.76.12])
	by int-mx1.corp.redhat.com (8.11.6/8.11.6) with ESMTP id j6LHYNV27634
	for <selinux@tycho.nsa.gov>; Thu, 21 Jul 2005 13:34:23 -0400
Received: from celtics.boston.redhat.com (celtics.boston.redhat.com [172.16.80.115])
	by mail.boston.redhat.com (8.12.8/8.12.8) with ESMTP id j6LHYMll026942
	for <selinux@tycho.nsa.gov>; Thu, 21 Jul 2005 13:34:22 -0400
Subject: [ libsepol 0/6] Context reorganization
From: Ivan Gyurdiev <gyurdiev@redhat.com>
Reply-To: gyurdiev@redhat.com
To: selinux@tycho.nsa.gov
Content-Type: multipart/mixed; boundary="=-FfI7wWkmOVhoThL7VNUE"
Date: Thu, 21 Jul 2005 13:31:58 -0400
Message-Id: <1121967118.9844.17.camel@celtics.boston.redhat.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-FfI7wWkmOVhoThL7VNUE
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

The following patch moves functions relating to context_struct_t
into file contexts.c for better organization. It makes all of 
them take policydb as argument, and enforces the sepol_ prefix.
It uses the new debugging system. It adds a structure for
a high level representation of a context (sepol_ctxinfo_t), 
and a new function to convert from it (sepol_context_create),
and makes use of that function to make the conversion
from string (formerly sepol_context_to_sid) easier.

libsepol-1.1-context.diff

Disclaimer 1: 

The following bit, as taken from the current 
policydb_context_isvalid fails for me currently. I don't
understand the role of the cache here. Does genusers.c
need to be modified to do something with the cache,
when it loads the user? Do I need to correspondingly 
modify my own load_user function (which is based on genusers)?

+               if (!ebitmap_get_bit(&usrdatum->cache, c->role - 1))
+                       /* user may not be associated with role */
+                       return 0;

Disclaimer 2:

What purpose does the result_len serves in
to_string/from_string functions? Shouldn't all those
strings be null terminated? The former context_struct_to_string
was done this way, so I didn't change it, but I don't see
why this is necessary. Looking at mls_sid_to_context it
would appear that it is null terminated (uses strcpy).



--=-FfI7wWkmOVhoThL7VNUE
Content-Disposition: attachment; filename=libsepol-1.1-context.diff
Content-Type: text/x-patch; name=libsepol-1.1-context.diff; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -aru libsepol.work/include/sepol/context.h libsepol-1.1-context/include/sepol/context.h
--- libsepol.work/include/sepol/context.h	2005-07-18 15:05:31.000000000 -0400
+++ libsepol-1.1-context/include/sepol/context.h	2005-07-21 08:29:32.000000000 -0400
@@ -16,12 +16,24 @@
  * clients of the security server.
  */
 
-#ifndef _CONTEXT_H_
-#define _CONTEXT_H_
+#ifndef _SEPOL_CONTEXT_H_
+#define _SEPOL_CONTEXT_H_
 
 #include <sepol/ebitmap.h>
 #include <sepol/mls_types.h>
 
+/* 
+ * High level representation of the context 
+ * This structure provides sufficient information
+ * to construct a security context. 
+ */
+typedef struct sepol_ctxinfo {
+	const char* user;
+	const char* role;
+	const char* type;
+	const char* mls;
+} sepol_ctxinfo_t;
+
 /*
  * A security context consists of an authenticated user
  * identity, a role, a type and a MLS range.
@@ -33,7 +45,6 @@
 	mls_range_t range;
 } context_struct_t;
 
-
 static inline void mls_context_init(context_struct_t * c)
 {
 	memset(&c->range, 0, sizeof(c->range));
@@ -111,7 +122,34 @@
 		mls_context_cmp(c1, c2));
 }
 
-#endif	/* _CONTEXT_H_ */
+struct policydb;
+
+/* Create a context structure from high level representation */
+extern int sepol_context_create(
+	struct policydb *policydb,
+	context_struct_t** cptr,
+	sepol_ctxinfo_t* data);
+
+/* Create a context structure from string representation */
+extern int sepol_context_from_string(
+	struct policydb* policydb,
+	context_struct_t** cptr,
+	const char* con_str,
+	size_t con_str_len);
+
+/* Check if the provided context is valid for this policy */
+extern int sepol_context_is_valid(
+	struct policydb *policydb, 
+	context_struct_t *context);
+
+/* Extract the context as string */
+extern int sepol_context_to_string(
+	struct policydb *policydb,
+	context_struct_t * context,
+	char ** result,
+	size_t *result_len);
+
+#endif	/* _SEPOL_CONTEXT_H_ */
 
 /* FLASK */
 
diff -aru libsepol.work/include/sepol/policydb.h libsepol-1.1-context/include/sepol/policydb.h
--- libsepol.work/include/sepol/policydb.h	2005-07-18 15:05:31.000000000 -0400
+++ libsepol-1.1-context/include/sepol/policydb.h	2005-07-20 19:57:29.000000000 -0400
@@ -452,7 +452,11 @@
 
 extern int policydb_load_isids(policydb_t *p, sidtab_t *s);
 
-extern int policydb_context_isvalid(policydb_t *p, context_struct_t *c);
+/* Deprecated */
+static inline int policydb_context_isvalid(policydb_t *p, context_struct_t *c) {
+	return sepol_context_is_valid(p,c);
+}
+
 extern void symtabs_destroy(symtab_t *symtab);
 extern int scope_destroy(hashtab_key_t key, hashtab_datum_t datum, void *p);
 typedef void (*hashtab_destroy_func_t) (hashtab_key_t k, hashtab_datum_t d, void *args);
diff -aru libsepol.work/src/context.c libsepol-1.1-context/src/context.c
--- libsepol.work/src/context.c	2005-07-20 09:32:15.000000000 -0400
+++ libsepol-1.1-context/src/context.c	2005-07-21 12:19:09.000000000 -0400
@@ -0,0 +1,281 @@
+#include <stdlib.h>
+
+#include <sepol/policydb.h>
+#include <sepol/context.h>
+#include <sepol/mls.h>
+
+#include "debug.h"
+
+/*
+ * Return 1 if the fields in the security context
+ * structure `c' are valid.  Return 0 otherwise.
+ */
+int sepol_context_is_valid(policydb_t *p, context_struct_t *c)
+{
+	role_datum_t *role;
+	user_datum_t *usrdatum;
+	ebitmap_t types, roles;
+	int ret = 1;
+
+	ebitmap_init(&types);
+	ebitmap_init(&roles);
+	if (!c->role || c->role > p->p_roles.nprim)
+		return 0;
+
+	if (!c->user || c->user > p->p_users.nprim)
+		return 0;
+
+	if (!c->type || c->type > p->p_types.nprim)
+		return 0;
+
+	if (c->role != OBJECT_R_VAL) {
+		/*
+		 * Role must be authorized for the type.
+		 */
+		role = p->role_val_to_struct[c->role - 1];
+		if (!ebitmap_get_bit(&role->cache, c->type - 1))
+			/* role may not be associated with type */
+			return 0;
+
+		/*
+		 * User must be authorized for the role.
+		 */
+		usrdatum = p->user_val_to_struct[c->user - 1];
+		if (!usrdatum)
+			return 0;
+
+		if (!ebitmap_get_bit(&usrdatum->cache, c->role - 1)) 
+			/* user may not be associated with role */
+			return 0;
+	}
+
+	if (!mls_context_isvalid(p, c))
+		return 0;
+
+	return ret;
+}
+
+/*
+ * Write the security context string representation of
+ * the context structure `context' into a dynamically
+ * allocated string of the correct size.  Set `*scontext'
+ * to point to this string and set `*scontext_len' to
+ * the length of the string.
+ */
+int sepol_context_to_string(
+	policydb_t* policydb,
+	context_struct_t * context,
+	char **result,
+	size_t *result_len) {
+
+	char *scontext = NULL;
+	size_t scontext_len = 0;
+	char* ptr;
+
+	/* Compute the size of the context. */
+	scontext_len += strlen(policydb->p_user_val_to_name[context->user-1])+1;
+	scontext_len += strlen(policydb->p_role_val_to_name[context->role-1])+1;
+	scontext_len += strlen(policydb->p_type_val_to_name[context->type-1])+1;
+	scontext_len += mls_compute_context_len(policydb, context);
+
+	/* Allocate space for the context; caller must free this space. */
+	scontext = malloc(scontext_len);
+	if (!scontext) 
+		goto omem;
+
+	/*
+	 * Copy the user name, role name and type name into the context.
+	 */
+	ptr = scontext;
+	sprintf(ptr, "%s:%s:%s",
+		policydb->p_user_val_to_name[context->user - 1],
+		policydb->p_role_val_to_name[context->role - 1],
+		policydb->p_type_val_to_name[context->type - 1]);
+
+	ptr += 
+		strlen(policydb->p_user_val_to_name[context->user - 1]) + 1 + 
+		strlen(policydb->p_role_val_to_name[context->role - 1]) + 1 + 
+		strlen(policydb->p_type_val_to_name[context->type - 1]);
+
+	mls_sid_to_context(policydb, context, &ptr);
+
+	*result = scontext;
+	*result_len = scontext_len;
+	return STATUS_SUCCESS;
+
+	omem:
+	DEBUG(__FUNCTION__, "out of memory, could not convert "
+		"context to string\n");
+	free(scontext);
+	return STATUS_ERR;
+}
+
+
+/* Create a policy-dependent context structure, corresponding
+ * to the provided high level representation */
+
+int sepol_context_create(
+	policydb_t* policydb, 
+	context_struct_t** cptr, 
+	sepol_ctxinfo_t* data) {
+
+	context_struct_t* scontext = NULL;
+	user_datum_t* usrdatum;
+	role_datum_t* roldatum;
+	type_datum_t* typdatum;
+
+	/* Hashtab keys are not constant - suppress warnings */
+	char* user = strdup(data->user); 
+	char* role = strdup(data->role);
+	char* type = strdup(data->type);
+	char* mls = data->mls ? strdup(data->mls): NULL;
+
+	scontext = (context_struct_t*) malloc(sizeof(context_struct_t));
+	if (!user || !role || !type || (data->mls && !mls) || !scontext) {
+		DEBUG(__FUNCTION__, "out of memory\n"); 
+		goto err;
+	}
+	context_init(scontext);
+
+	/* User */
+	usrdatum = (user_datum_t*) hashtab_search(policydb->p_users.table,
+                                        (hashtab_key_t) user);
+	if (!usrdatum) {
+		DEBUG(__FUNCTION__, "user %s is not defined\n", user);
+		goto err_destroy;
+	}
+	scontext->user = usrdatum->value;
+
+	/* Role */
+	roldatum = (role_datum_t*) hashtab_search(policydb->p_roles.table,
+					(hashtab_key_t) role);
+	if (!roldatum) {
+		DEBUG(__FUNCTION__, "role %s is not defined\n", role);
+		goto err_destroy;
+	}
+	scontext->role = roldatum->value;
+
+	/* Type */
+	typdatum = (type_datum_t *) hashtab_search(policydb->p_types.table,
+					(hashtab_key_t) type);
+	if (!typdatum || typdatum->isattr) {
+		DEBUG(__FUNCTION__, "type %s is not defined\n", type);
+		goto err_destroy;
+	}
+	scontext->type = typdatum->value;
+
+	/* MLS */
+	if (mls && !sepol_mls_enabled()) {
+		DEBUG(__FUNCTION__, "mls context found, but mls is disabled\n");
+		mls = NULL;
+	}
+	else if (!mls && sepol_mls_enabled()) {
+		DEBUG(__FUNCTION__, "mls is enabled, but no mls context found\n");
+		goto err_destroy;
+	}
+	if (mls && (mls_context_to_sid(policydb, '$', &mls, scontext) < 0)) {
+		DEBUG(__FUNCTION__, "invalid mls context %s\n", mls);
+		goto err_destroy;
+	}
+
+	/* Validity check */
+	if (!sepol_context_is_valid(policydb, scontext)) {
+		if (mls)
+			DEBUG(__FUNCTION__, 
+				"invalid security context: %s:%s:%s:%s\n",
+				user, role, type, mls);
+		else
+			DEBUG(__FUNCTION__, 
+				"invalid security context: %s:%s:%s\n",
+				user, role, type);
+		goto err_destroy;
+	}
+
+	*cptr = scontext;
+	free(user);	
+	free(type);
+	free(role);
+	free(mls);
+	return STATUS_SUCCESS;
+
+	err_destroy:
+	context_destroy(scontext);
+
+	err: 
+	free(scontext);
+	free(user);
+	free(type);
+	free(role);
+	free(mls);	
+	DEBUG(__FUNCTION__, "error creating context structure\n");
+	return STATUS_ERR;
+}
+
+/*
+ * Create a context structure from the provided string.
+ */
+int sepol_context_from_string(
+	policydb_t* policydb,
+	context_struct_t** cptr,
+	const char* con_str,
+	size_t con_str_len) { 
+
+	char* con_cpy = NULL;
+	sepol_ctxinfo_t ctx_info;
+	char *p;
+
+	/* Copy the string so that we can modify the copy as we parse it.
+	   The string should already by null terminated, but we append a
+	   null suffix to the copy to avoid problems with the existing
+	   attr package, which doesn't view the null terminator as part
+	   of the attribute value. */
+	con_cpy = malloc(con_str_len + 1);
+	if (!con_cpy) {
+		DEBUG(__FUNCTION__, "out of memory\n");
+		goto err;
+	}
+	memcpy(con_cpy, con_str, con_str_len);
+	con_cpy[con_str_len] = '\0';
+	p = (char *) con_cpy;
+
+        /* Find user */
+	ctx_info.user = p;
+	while (*p && *p != ':')
+		p++;
+	if (*p == '\0')
+		goto parse_err;
+	*p++ = '\0';
+
+        /* Find role */
+	ctx_info.role = p;
+	while (*p && *p != ':')
+		p++;
+	if (*p == '\0')
+		goto parse_err;
+	*p++ = '\0';
+
+        /* Find type and MLS */
+	ctx_info.type = p;
+	while (*p && *p != ':')
+		p++;
+	if (sepol_mls_enabled() && (*p == ':'))
+		ctx_info.mls = (p + 1);
+	else
+		ctx_info.mls = NULL;
+	*p++ = '\0';
+
+	/* Now create from the data structure */
+	if (sepol_context_create(policydb, cptr, &ctx_info) < 0)
+		goto err;
+
+	free(con_cpy);
+	return STATUS_SUCCESS;
+	
+	parse_err:
+	DEBUG(__FUNCTION__, "invalid security context: %s\n", con_str);
+
+	err:
+	DEBUG(__FUNCTION__, "unable to create context structure\n");
+	free(con_cpy);
+	return STATUS_ERR;
+}
diff -aru libsepol.work/src/policydb.c libsepol-1.1-context/src/policydb.c
--- libsepol.work/src/policydb.c	2005-07-18 15:05:31.000000000 -0400
+++ libsepol-1.1-context/src/policydb.c	2005-07-20 19:57:49.000000000 -0400
@@ -985,56 +985,6 @@
 	return 0;
 }
 
-/*
- * Return 1 if the fields in the security context 
- * structure `c' are valid.  Return 0 otherwise.
- */
-int policydb_context_isvalid(policydb_t *p, context_struct_t *c)
-{
-	role_datum_t *role;
-	user_datum_t *usrdatum;
-	ebitmap_t types, roles;
-        int ret = 1;
-
-	ebitmap_init(&types);
-	ebitmap_init(&roles);
-	if (!c->role || c->role > p->p_roles.nprim)
-		return 0;
-
-	if (!c->user || c->user > p->p_users.nprim)
-		return 0;
-
-	if (!c->type || c->type > p->p_types.nprim)
-		return 0;
-
-	if (c->role != OBJECT_R_VAL) {
-		/*
-		 * Role must be authorized for the type.
-		 */
-		role = p->role_val_to_struct[c->role - 1];
-		if (!ebitmap_get_bit(&role->cache, c->type - 1))
-			/* role may not be associated with type */
-			return 0;
-		
-		/*
-		 * User must be authorized for the role.
-		 */
-		usrdatum = p->user_val_to_struct[c->user - 1];
-		if (!usrdatum)
-			return 0;
-
-		if (!ebitmap_get_bit(&usrdatum->cache, c->role - 1))
-			/* user may not be associated with role */
-			return 0;
-	}
-
-	if (!mls_context_isvalid(p, c))
-		return 0;
-
-	return ret;
-}
-
-
 /***********************************************************************/
 /* everything below is for policy reads */
 
diff -aru libsepol.work/src/services.c libsepol-1.1-context/src/services.c
--- libsepol.work/src/services.c	2005-07-18 15:05:30.000000000 -0400
+++ libsepol-1.1-context/src/services.c	2005-07-20 19:57:44.000000000 -0400
@@ -57,6 +57,7 @@
 #include <sepol/conditional.h>
 #include <sepol/flask.h>
 
+#include "debug.h"
 #include "private.h"
 #include "av_permissions.h"
 
@@ -481,52 +482,15 @@
 	return sepol_compute_av_reason(ssid, tsid, tclass, requested, avd, &reason);
 }
 
-/*
- * Write the security context string representation of 
- * the context structure `context' into a dynamically
- * allocated string of the correct size.  Set `*scontext'
- * to point to this string and set `*scontext_len' to
- * the length of the string.
- */
-int context_struct_to_string(context_struct_t * context,
-			     sepol_security_context_t * scontext,
-			     size_t *scontext_len)
-{
-	char *scontextp;
-
-	*scontext = 0;
-	*scontext_len = 0;
-
-	/* Compute the size of the context. */
-	*scontext_len += strlen(policydb->p_user_val_to_name[context->user - 1]) + 1;
-	*scontext_len += strlen(policydb->p_role_val_to_name[context->role - 1]) + 1;
-	*scontext_len += strlen(policydb->p_type_val_to_name[context->type - 1]) + 1;
-	*scontext_len += mls_compute_context_len(policydb, context);
-
-	/* Allocate space for the context; caller must free this space. */
-	scontextp = malloc(*scontext_len);
-	if (!scontextp) {
-		return -ENOMEM;
-	}
-	*scontext = (sepol_security_context_t) scontextp;
+/* Deprecated */
+static inline int context_struct_to_string(
+        context_struct_t* context,
+        char ** result,
+        size_t *result_len) {
 
-	/*
-	 * Copy the user name, role name and type name into the context.
-	 */
-	sprintf(scontextp, "%s:%s:%s",
-		policydb->p_user_val_to_name[context->user - 1],
-		policydb->p_role_val_to_name[context->role - 1],
-		policydb->p_type_val_to_name[context->type - 1]);
-	scontextp += strlen(policydb->p_user_val_to_name[context->user - 1]) + 1 + strlen(policydb->p_role_val_to_name[context->role - 1]) + 1 + strlen(policydb->p_type_val_to_name[context->type - 1]);
-
-	mls_sid_to_context(policydb, context, &scontextp);
-
-	*scontextp = 0;
-
-	return 0;
+        return sepol_context_to_string(policydb, context, result, result_len);
 }
 
-
 /*
  * Write the security context string representation of 
  * the context associated with `sid' into a dynamically
@@ -561,105 +525,25 @@
 			    size_t scontext_len,
 			    sepol_security_id_t * sid)
 {
-	sepol_security_context_t scontext2;
-	context_struct_t context;
-	role_datum_t *role;
-	type_datum_t *typdatum;
-	user_datum_t *usrdatum;
-	char *scontextp, *p, oldc;
-	int rc = 0;
-
-	if (sid)
-		*sid = SEPOL_SECSID_NULL;
-
-	/* Copy the string so that we can modify the copy as we parse it.
-	   The string should already by null terminated, but we append a
-	   null suffix to the copy to avoid problems with the existing
-	   attr package, which doesn't view the null terminator as part
-	   of the attribute value. */
-	scontext2 = malloc(scontext_len+1);
-	if (!scontext2) {
-		return -ENOMEM;
-	}
-	memcpy(scontext2, scontext, scontext_len);
-	scontext2[scontext_len] = 0;
-
-	context_init(&context);
-
-	/* Parse the security context. */
-
-	rc = -EINVAL;
-	scontextp = (char *) scontext2;
-
-	/* Extract the user. */
-	p = scontextp;
-	while (*p && *p != ':')
-		p++;
-
-	if (*p == 0)
-		goto out;
+	context_struct_t* context = NULL;
 
-	*p++ = 0;
-
-	usrdatum = (user_datum_t *) hashtab_search(policydb->p_users.table,
-					      (hashtab_key_t) scontextp);
-	if (!usrdatum)
-		goto out;
-
-	context.user = usrdatum->value;
-
-	/* Extract role. */
-	scontextp = p;
-	while (*p && *p != ':')
-		p++;
-
-	if (*p == 0)
-		goto out;
-
-	*p++ = 0;
-
-	role = (role_datum_t *) hashtab_search(policydb->p_roles.table,
-					       (hashtab_key_t) scontextp);
-	if (!role)
-		goto out;
-	context.role = role->value;
-
-	/* Extract type. */
-	scontextp = p;
-	while (*p && *p != ':')
-		p++;
-	oldc = *p;
-	*p++ = 0;
-
-	typdatum = (type_datum_t *) hashtab_search(policydb->p_types.table,
-					      (hashtab_key_t) scontextp);
-
-	if (!typdatum)
-		goto out;
-
-	context.type = typdatum->value;
-
-	rc = mls_context_to_sid(policydb, oldc, &p, &context);
-	if (rc)
-		goto out;
-
-	if ((p - scontext2) < scontext_len) {
-		rc = -EINVAL;
-		goto out;
-	}
+	/* First, create the context */
+	if (sepol_context_from_string(policydb, &context, 
+		scontext, scontext_len) < 0)
+		goto err;
 
-	/* Check the validity of the new context. */
-	if (!policydb_context_isvalid(policydb, &context)) {
-		rc = -EINVAL;
-		goto out;
-	}
-	/* Obtain the new sid. */
-	if (sid)
-		rc = sepol_sidtab_context_to_sid(sidtab, &context, sid);
-out:
-	context_destroy(&context);
-	free(scontext2);
-	return rc;
+	/* Obtain the new sid */
+	if (sid && (sepol_sidtab_context_to_sid(sidtab, context, sid) < 0))
+		goto err;		
+
+	context_destroy(context);
+	return STATUS_SUCCESS;
+
+	err:
+	if (context)
+		context_destroy(context);
+	DEBUG(__FUNCTION__, "could not convert %s to sid\n", scontext);
+	return STATUS_ERR;
 }
 
 int sepol_check_context(char *context) 

--=-FfI7wWkmOVhoThL7VNUE--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
