Message-ID: <435ED081.7030306@cornell.edu>
Date: Tue, 25 Oct 2005 20:40:33 -0400
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
CC: Stephen Smalley <sds@tycho.nsa.gov>
Subject: [ SEPOL 2 ] More debug things
Content-Type: multipart/mixed;
 boundary="------------020001080608090308080809"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------020001080608090308080809
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

- add handle to mls to/from string
- remove newline in a few places where missed
- remove DEBUG from genbools
- remove DEBUG from genusers
- remove DEBUG from .... everywhere else

...except for the records.
Leave the records alone for now... TODO



--------------020001080608090308080809
Content-Type: text/x-patch;
 name="libsepol.debug2.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libsepol.debug2.diff"

diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude direct_api.c --exclude semanage_store.c --exclude libsemanage.map --exclude 'module_record*' --exclude 'database_directory*' --exclude Makefile old/libsepol/include/sepol/policydb/mls.h new/libsepol/include/sepol/policydb/mls.h
--- old/libsepol/include/sepol/policydb/mls.h	2005-10-24 12:30:39.000000000 -0400
+++ new/libsepol/include/sepol/policydb/mls.h	2005-10-25 20:27:38.000000000 -0400
@@ -31,15 +31,18 @@
 #ifndef _SEPOL_POLICYDB_MLS_H_
 #define _SEPOL_POLICYDB_MLS_H_
 
+#include <sepol/handle.h>
 #include <sepol/policydb/context.h>
 #include <sepol/policydb/policydb.h>
 
 extern int mls_from_string(
+	sepol_handle_t* handle,
 	policydb_t* policydb,
 	const char* str,
 	context_struct_t* mls);
 
 extern int mls_to_string(
+	sepol_handle_t* handle,
 	policydb_t* policydb,
 	context_struct_t* mls,
 	char** str);
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude direct_api.c --exclude semanage_store.c --exclude libsemanage.map --exclude 'module_record*' --exclude 'database_directory*' --exclude Makefile old/libsepol/src/booleans.c new/libsepol/src/booleans.c
--- old/libsepol/src/booleans.c	2005-10-25 20:17:53.000000000 -0400
+++ new/libsepol/src/booleans.c	2005-10-25 20:21:57.000000000 -0400
@@ -49,7 +49,7 @@ static int bool_update (
 
 	err:
 	free(name);
-	ERR(handle, "could not update boolean %s\n",  cname);
+	ERR(handle, "could not update boolean %s",  cname);
 	return STATUS_ERR;		
 }
 
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude direct_api.c --exclude semanage_store.c --exclude libsemanage.map --exclude 'module_record*' --exclude 'database_directory*' --exclude Makefile old/libsepol/src/context.c new/libsepol/src/context.c
--- old/libsepol/src/context.c	2005-10-25 20:17:53.000000000 -0400
+++ new/libsepol/src/context.c	2005-10-25 20:34:11.000000000 -0400
@@ -191,10 +191,8 @@ int context_from_record(
  		ERR(handle, "mls is enabled, but no mls context found");
 		goto err_destroy;
 	}
-	if (mls && (mls_from_string(policydb, mls, scontext) < 0)) {
- 		ERR(handle, "invalid mls context: \"%s\"", mls);
+	if (mls && (mls_from_string(handle, policydb, mls, scontext) < 0)) 
 		goto err_destroy;
-	}
 
 	/* Validity check */
  	if (!context_is_valid(policydb, scontext)) {
@@ -257,7 +255,7 @@ int context_to_record(
 		goto err;
 
 	if (policydb->mls) {
-		if (mls_to_string(policydb, context, &mls) < 0)
+		if (mls_to_string(handle, policydb, context, &mls) < 0)
 			goto err;
 
 		if (sepol_context_set_mls(tmp_record, mls) < 0)
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude direct_api.c --exclude semanage_store.c --exclude libsemanage.map --exclude 'module_record*' --exclude 'database_directory*' --exclude Makefile old/libsepol/src/expand.c new/libsepol/src/expand.c
--- old/libsepol/src/expand.c	2005-10-25 10:17:32.000000000 -0400
+++ new/libsepol/src/expand.c	2005-10-25 20:29:48.000000000 -0400
@@ -1913,7 +1913,7 @@ static int expand_avtab_insert(avtab_t *
 	if (!node) {
 		rc = avtab_insert(a, k, d);
 		if (rc)
-			DEBUG(__FUNCTION__, "Out of memory!");
+			ERR(NULL, "Out of memory!");
 		return rc;
 	}
 
@@ -1921,7 +1921,7 @@ static int expand_avtab_insert(avtab_t *
 	    (node->key.specified & AVTAB_ENABLED)) {
 		node = avtab_insert_nonunique(a, k, d);
 		if (!node) {
-			DEBUG(__FUNCTION__, "Out of memory!");
+			ERR(NULL, "Out of memory!");
 			return -1;
 		}
 		return 0;
@@ -1937,7 +1937,7 @@ static int expand_avtab_insert(avtab_t *
 		avd->data &= d->data;
 		break;
 	default:
-		DEBUG(__FUNCTION__, "Type conflict!");
+		ERR(NULL, "Type conflict!");
 		return -1;
 	}
 
@@ -2040,13 +2040,13 @@ static int expand_cond_insert(cond_av_li
 	    (k->specified & AVTAB_ENABLED) != (node->key.specified & AVTAB_ENABLED)) {
 		node = avtab_insert_nonunique(expa, k, d);
 		if (!node) {
-			DEBUG(__FUNCTION__, "Out of memory!");
+			ERR(NULL, "Out of memory!");
 			return -1;
 		}
 		node->parse_context = (void*)1;
 		nl = (cond_av_list_t *) malloc(sizeof(*nl));
 		if (!nl) {
-			DEBUG(__FUNCTION__, "Out of memory!");
+			ERR(NULL, "Out of memory!");
 			return -1;
 		}
 		memset(nl, 0, sizeof(*nl));
@@ -2066,7 +2066,7 @@ static int expand_cond_insert(cond_av_li
 		avd->data &= d->data;
 		break;
 	default:
-		DEBUG(__FUNCTION__, "Type conflict!");
+		ERR(NULL, "Type conflict!");
 		return -1;
 	}
 
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude direct_api.c --exclude semanage_store.c --exclude libsemanage.map --exclude 'module_record*' --exclude 'database_directory*' --exclude Makefile old/libsepol/src/genbools.c new/libsepol/src/genbools.c
--- old/libsepol/src/genbools.c	2005-10-18 10:08:39.000000000 -0400
+++ new/libsepol/src/genbools.c	2005-10-25 20:36:22.000000000 -0400
@@ -44,8 +44,8 @@ static int process_boolean(char *buffer,
 			else if (!strncasecmp(tok, "false", sizeof("false")-1))
 				*val = 0;
 			if (*val != 0 && *val != 1) {
-				DEBUG(__FUNCTION__, "illegal value for boolean "
-					"%s=%s\n", name, tok);
+				ERR(NULL, "illegal value for boolean "
+					"%s=%s", name, tok);
 				return -1;
 			}
 			
@@ -75,7 +75,7 @@ static int load_booleans(struct policydb
 		if (ret==1) {
 			datum = hashtab_search(policydb->p_bools.table, name);
 			if (!datum) {
-				DEBUG(__FUNCTION__, "unknown boolean %s\n", name);
+				ERR(NULL, "unknown boolean %s", name);
 				errors++;
 				continue;
 			}
@@ -94,7 +94,7 @@ localbool:
 			if (ret==1) {
 				datum = hashtab_search(policydb->p_bools.table, name);
 				if (!datum) {
-					DEBUG(__FUNCTION__, "unknown boolean %s\n", name);
+					ERR(NULL, "unknown boolean %s", name);
 					errors++;
 					continue;
 				}
@@ -122,12 +122,11 @@ int sepol_genbools(void *data, size_t le
 		goto err;
 
 	if (load_booleans(&policydb, booleans) < 0) {
-		DEBUG(__FUNCTION__, "Warning! Error while reading %s\n",
-				     booleans);
+		WARN(NULL, "error while reading %s", booleans);
 	}
 
 	if (evaluate_conds(&policydb) < 0) {
-		DEBUG(__FUNCTION__, "error while re-evaluating conditionals\n");
+		ERR(NULL, "error while re-evaluating conditionals");
 		errno = EINVAL;
 		goto err_destroy;
 	}
@@ -137,7 +136,7 @@ int sepol_genbools(void *data, size_t le
 	pf.len = len;
 	rc = policydb_write(&policydb, &pf);
 	if (rc) {
-		DEBUG(__FUNCTION__, "unable to write new binary policy image\n");
+		ERR(NULL, "unable to write new binary policy image");
 		errno = EINVAL;
 		goto err_destroy;
 	}
@@ -180,13 +179,12 @@ int sepol_genbools_array(void *data, siz
 	for (i = 0; i < nel; i++) {
 		datum = hashtab_search(policydb.p_bools.table, names[i]);
 		if (!datum) {
-			DEBUG(__FUNCTION__, "boolean %s no longer in policy\n",
-				names[i]);
+			ERR(NULL, "boolean %s no longer in policy", names[i]);
 			errors++;
 			continue;
 		}
 		if (values[i] != 0 && values[i] != 1) {
-			DEBUG(__FUNCTION__, "illegal value %d for boolean %s\n",
+			ERR(NULL, "illegal value %d for boolean %s",
 				values[i], names[i]);
 			errors++;
 			continue;
@@ -195,7 +193,7 @@ int sepol_genbools_array(void *data, siz
 	}
 
 	if (evaluate_conds(&policydb) < 0) {
-		DEBUG(__FUNCTION__, "error while re-evaluating conditionals\n");
+		ERR(NULL, "error while re-evaluating conditionals");
 		errno = EINVAL;
 		goto err_destroy;
 	}
@@ -205,7 +203,7 @@ int sepol_genbools_array(void *data, siz
 	pf.len = len;
 	rc = policydb_write(&policydb, &pf);
 	if (rc) {
-		DEBUG(__FUNCTION__, "unable to write binary policy\n");
+		ERR(NULL, "unable to write binary policy");
 		errno = EINVAL;
 		goto err_destroy;
 	}
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude direct_api.c --exclude semanage_store.c --exclude libsemanage.map --exclude 'module_record*' --exclude 'database_directory*' --exclude Makefile old/libsepol/src/genusers.c new/libsepol/src/genusers.c
--- old/libsepol/src/genusers.c	2005-10-25 10:17:32.000000000 -0400
+++ new/libsepol/src/genusers.c	2005-10-25 20:31:51.000000000 -0400
@@ -18,7 +18,7 @@ void sepol_set_delusers(int on __attribu
 
 #undef BADLINE
 #define BADLINE() { \
-	DEBUG(__FUNCTION__, "invalid entry %s (%s:%u)\n", \
+	ERR(NULL, "invalid entry %s (%s:%u)", \
 		buffer, path, lineno); \
 	continue; \
 }
@@ -76,7 +76,7 @@ static int load_users(struct policydb *p
 			/* Adding a new user definition. */
 			usrdatum = (user_datum_t *) malloc(sizeof(user_datum_t));
 			if (!id || !usrdatum) {
-				DEBUG(__FUNCTION__,"out of memory\n");
+				ERR(NULL, "out of memory");
 				errno = ENOMEM;
 				free(buffer);
 				fclose(fp);
@@ -88,7 +88,7 @@ static int load_users(struct policydb *p
 			rc = hashtab_insert(policydb->p_users.table,
 					    id, (hashtab_datum_t) usrdatum);
 			if (rc) {
-				DEBUG(__FUNCTION__, "out of memory\n");
+				ERR(NULL, "out of memory");
 				errno = ENOMEM;
 				free(buffer);
 				fclose(fp);
@@ -135,7 +135,7 @@ static int load_users(struct policydb *p
 
 			roldatum = hashtab_search(policydb->p_roles.table, q);
 			if (!roldatum) {
-				DEBUG(__FUNCTION__, "undefined role %s (%s:%u)\n",
+				ERR(NULL, "undefined role %s (%s:%u)",
 					q, path, lineno);
 				continue;
 			}
@@ -143,7 +143,7 @@ static int load_users(struct policydb *p
 			ebitmap_for_each_bit(&roldatum->dominates, rnode, bit) {
 				if (ebitmap_node_get_bit(rnode, bit))
 					if (ebitmap_set_bit(&usrdatum->roles.roles, bit, 1)) {
-						DEBUG(__FUNCTION__, "out of memory\n");
+						ERR(NULL, "out of memory");
 						errno = ENOMEM;
 						free(buffer);
 						fclose(fp);
@@ -179,7 +179,7 @@ static int load_users(struct policydb *p
 
 			scontext = malloc(p - q);
 			if (!scontext) {
-				DEBUG(__FUNCTION__, "out of memory\n");
+				ERR(NULL, "out of memory");
 				free(buffer);
 				fclose(fp);
 				return -1;
@@ -197,7 +197,7 @@ static int load_users(struct policydb *p
 			context_init(&context);
 			rc = mls_context_to_sid(policydb, oldc, &r, &context);
 			if (rc) {
-				DEBUG(__FUNCTION__, "invalid level %s (%s:%u)\n",
+				ERR(NULL, "invalid level %s (%s:%u)",
 					scontext, path, lineno);
 				free(scontext);
 				continue;
@@ -224,7 +224,7 @@ static int load_users(struct policydb *p
 
 			scontext = malloc(p - q);
 			if (!scontext) {
-				DEBUG(__FUNCTION__, "out of memory\n");
+				ERR(NULL, "out of memory");
 				errno = ENOMEM;
 				free(buffer);
 				fclose(fp);
@@ -243,7 +243,7 @@ static int load_users(struct policydb *p
 			context_init(&context);
 			rc = mls_context_to_sid(policydb, oldc, &r, &context);
 			if (rc) {
-				DEBUG(__FUNCTION__, "invalid range %s (%s:%u)\n",
+				ERR(NULL, "invalid range %s (%s:%u)",
 					scontext, path, lineno);
 				free(scontext);
 				continue;
@@ -274,7 +274,7 @@ int sepol_genusers(void *data, size_t le
 	/* Load locally defined users. */
 	snprintf(path, sizeof path, "%s/local.users", usersdir);
 	if (load_users(&policydb, path) < 0) {
-		DEBUG(__FUNCTION__, "unable to load local.users: %s\n",
+		ERR(NULL, "unable to load local.users: %s",
 				strerror(errno));
 		goto err_destroy;
 	}
@@ -301,14 +301,13 @@ int sepol_genusers_policydb(policydb_t *
 	/* Load locally defined users. */
 	snprintf(path, sizeof path, "%s/local.users", usersdir);
 	if (load_users(policydb, path) < 0) {
-		DEBUG(__FUNCTION__, "unable to load local.users: %s\n",
-				strerror(errno));
+		ERR(NULL, "unable to load local.users: %s",
+			strerror(errno));
 		return -1;
 	}
 
 	if (policydb_reindex_users(policydb) < 0) {
-		DEBUG(__FUNCTION__, "unable to reindex users: %s\n",
-				strerror(errno));
+		ERR(NULL, "unable to reindex users: %s", strerror(errno));
 		return -1;
 
 	}
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude direct_api.c --exclude semanage_store.c --exclude libsemanage.map --exclude 'module_record*' --exclude 'database_directory*' --exclude Makefile old/libsepol/src/mls.c new/libsepol/src/mls.c
--- old/libsepol/src/mls.c	2005-10-24 12:32:51.000000000 -0400
+++ new/libsepol/src/mls.c	2005-10-25 20:38:18.000000000 -0400
@@ -35,10 +35,12 @@
 
 #include <stdlib.h>
 
+#include "handle.h"
 #include "debug.h"
 #include "private.h"
 
 int mls_to_string(
+	sepol_handle_t* handle,
 	policydb_t* policydb, 
 	context_struct_t* mls, 
 	char** str) {
@@ -66,7 +68,8 @@ int mls_to_string(
 	return STATUS_SUCCESS;
 
 	omem:
-	DEBUG(__FUNCTION__, "out of memory\n");
+	ERR(handle, "out of memory, could not convert mls context to string");
+
 	free(ptr);
 	free(ptr2);
 	return STATUS_ERR;
@@ -74,25 +77,31 @@ int mls_to_string(
 }
 
 int mls_from_string(
+	sepol_handle_t* handle,
 	policydb_t* policydb, 
 	const char* str, 
 	context_struct_t* mls) {
 
 	char* tmp = strdup(str);
 	char* tmp_cp = tmp;
-	if (!tmp) {
-		DEBUG(__FUNCTION__, "out of memory\n");
-		return STATUS_ERR;
-	}
+	if (!tmp) 
+		goto omem;
 
 	if (mls_context_to_sid(policydb, '$', &tmp_cp, mls)) {
-		DEBUG(__FUNCTION__, "invalid MLS context %s\n", str);
+		ERR(handle, "invalid MLS context %s", str);
 		free(tmp);
-		return STATUS_ERR;
+		goto err;
 	}
 	
 	free(tmp);
 	return STATUS_SUCCESS;
+
+	omem:
+	ERR(handle, "out of memory");
+
+	err:
+	ERR(handle, "could not construct mls context structure");
+	return STATUS_ERR;
 }
 
 /*
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude direct_api.c --exclude semanage_store.c --exclude libsemanage.map --exclude 'module_record*' --exclude 'database_directory*' --exclude Makefile old/libsepol/src/policydb.c new/libsepol/src/policydb.c
--- old/libsepol/src/policydb.c	2005-10-25 09:25:44.000000000 -0400
+++ new/libsepol/src/policydb.c	2005-10-25 20:28:41.000000000 -0400
@@ -1005,20 +1005,18 @@ int policydb_load_isids(policydb_t *p, s
 	ocontext_t *head, *c;
 
 	if (sepol_sidtab_init(s)) {
-		DEBUG(__FUNCTION__, "out of memory on SID table init");
+		ERR(NULL, "out of memory on SID table init");
 		return -1;
 	}
 
 	head = p->ocontexts[OCON_ISID];
 	for (c = head; c; c = c->next) {
 		if (!c->context[0].user) {
-			DEBUG(__FUNCTION__, "SID %s was never defined",
-				c->u.name);
+			ERR(NULL, "SID %s was never defined", c->u.name);
 			return -1;
 		}
 		if (sepol_sidtab_insert(s, c->sid[0], &c->context[0])) {
-			DEBUG(__FUNCTION__, "unable to load initial SID %s",
-				c->u.name);
+			ERR(NULL, "unable to load initial SID %s", c->u.name);
 			return -1;
 		}
 	}
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude direct_api.c --exclude semanage_store.c --exclude libsemanage.map --exclude 'module_record*' --exclude 'database_directory*' --exclude Makefile old/libsepol/src/ports.c new/libsepol/src/ports.c
--- old/libsepol/src/ports.c	2005-10-25 20:17:53.000000000 -0400
+++ new/libsepol/src/ports.c	2005-10-25 20:22:21.000000000 -0400
@@ -66,7 +66,7 @@ static int port_from_record(
 	tmp_port->u.port.low_port = sepol_port_get_low(data);
 	tmp_port->u.port.high_port = sepol_port_get_high(data);
 	if (tmp_port->u.port.low_port > tmp_port->u.port.high_port) {
-		ERR(handle, "low port %d exceeds high port %d\n",
+		ERR(handle, "low port %d exceeds high port %d",
 			tmp_port->u.port.low_port, 
 			tmp_port->u.port.high_port);
 		goto err;
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude direct_api.c --exclude semanage_store.c --exclude libsemanage.map --exclude 'module_record*' --exclude 'database_directory*' --exclude Makefile old/libsepol/src/roles.c new/libsepol/src/roles.c
--- old/libsepol/src/roles.c	2005-10-21 09:54:25.000000000 -0400
+++ new/libsepol/src/roles.c	2005-10-25 20:21:06.000000000 -0400
@@ -1,9 +1,15 @@
 #include <stdlib.h>
+#include <string.h>
+#include <stddef.h>
+
 #include <sepol/policydb/policydb.h>
+
 #include "debug.h"
+#include "handle.h"
 
 /* Check if a role exists */
 int sepol_role_exists(
+	sepol_handle_t* handle,
 	sepol_policydb_t* p, 
 	const char* role,
 	int* response) {
@@ -11,7 +17,7 @@ int sepol_role_exists(
   	policydb_t *policydb = &p->p;
 	char* role_copy = strdup(role);
 	if (!role_copy) {
-		DEBUG(__FUNCTION__, "out of memory, role check failed\n");
+		ERR(handle, "out of memory, role check failed");
 		return STATUS_ERR;
 	}
 
@@ -23,6 +29,7 @@ int sepol_role_exists(
 
 /* Fill an array with all valid roles */
 int sepol_role_list(
+	sepol_handle_t* handle,
 	sepol_policydb_t* p, 
 	char*** roles, 
 	size_t* nroles) {
@@ -47,8 +54,7 @@ int sepol_role_list(
         return STATUS_SUCCESS;
 
 	omem:
-	DEBUG(__FUNCTION__, "out of memory, could not "
-		"allocate list of valid roles\n");
+	ERR(handle, "out of memory, could not list roles");
 	
 	ptr = tmp_roles;
 	while (ptr && *ptr) 
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude direct_api.c --exclude semanage_store.c --exclude libsemanage.map --exclude 'module_record*' --exclude 'database_directory*' --exclude Makefile old/libsepol/src/services.c new/libsepol/src/services.c
--- old/libsepol/src/services.c	2005-10-25 20:17:53.000000000 -0400
+++ new/libsepol/src/services.c	2005-10-25 20:22:10.000000000 -0400
@@ -917,7 +917,7 @@ static int convert_context(sepol_securit
       bad:
 	context_to_string(NULL, policydb, &oldc, &s, &len);
 	context_destroy(&oldc);
-	ERR(NULL, "invalidating context %s\n", s);
+	ERR(NULL, "invalidating context %s", s);
 	free(s);
 	return rc;
 }
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude direct_api.c --exclude semanage_store.c --exclude libsemanage.map --exclude 'module_record*' --exclude 'database_directory*' --exclude Makefile old/libsepol/src/users.c new/libsepol/src/users.c
--- old/libsepol/src/users.c	2005-10-25 20:17:53.000000000 -0400
+++ new/libsepol/src/users.c	2005-10-25 20:25:58.000000000 -0400
@@ -13,6 +13,7 @@
 #include <sepol/user_record.h>
 
 static int user_to_record (
+	sepol_handle_t* handle,
 	policydb_t* policydb,
 	int user_idx,
 	sepol_user_t** record) {
@@ -48,17 +49,17 @@ static int user_to_record (
 		context_init(&context);
 		if (mls_level_cpy(&context.range.level[0], 
 			&usrdatum->dfltlevel) < 0) {
-			DEBUG(__FUNCTION__, "could not copy MLS level");
+			ERR(handle, "could not copy MLS level");
 			context_destroy(&context);
 			goto err;
 		}
 		if (mls_level_cpy(&context.range.level[1],
 			&usrdatum->dfltlevel) < 0) {
-			DEBUG(__FUNCTION__, "could not copy MLS level");
+			ERR(handle, "could not copy MLS level");
 			context_destroy(&context);
 			goto err;
 		}
-		if (mls_to_string(policydb, &context, &str) < 0) {
+		if (mls_to_string(handle, policydb, &context, &str) < 0) {
 			context_destroy(&context);
 			goto err;
 		}
@@ -72,11 +73,11 @@ static int user_to_record (
 
 		context_init(&context);
 		if (mls_range_cpy(&context.range, &usrdatum->range) < 0) {
-			DEBUG(__FUNCTION__, "could not copy MLS range");
+			ERR(handle, "could not copy MLS range");
 			context_destroy(&context);
 			goto err;
 		}
-		if (mls_to_string(policydb, &context, &str) < 0) {
+		if (mls_to_string(handle, policydb, &context, &str) < 0) {
 			context_destroy(&context);
 			goto err;
 		}
@@ -197,9 +198,7 @@ int sepol_user_modify(
 		}
 		
 		context_init(&context);
-		if (mls_from_string(policydb, mls_level, &context) < 0) {
-			ERR(handle, "invalid MLS default level %s "
-				"for user %s", mls_level, name);
+		if (mls_from_string(handle, policydb, mls_level, &context) < 0) {
 			context_destroy(&context);
 			goto err;
 		}
@@ -218,9 +217,7 @@ int sepol_user_modify(
 		}	
 		
 		context_init(&context);
-		if (mls_from_string(policydb, mls_range, &context) < 0) {
-			ERR(handle, "invalid MLS range %s for user %s", 
-				mls_range, name);
+		if (mls_from_string(handle, policydb, mls_range, &context) < 0) {
 			context_destroy(&context);
 			goto err;
 		}
@@ -352,7 +349,8 @@ int sepol_user_query(
 		return STATUS_SUCCESS; 
 	}
 
-	if (user_to_record(policydb, usrdatum->value - 1, response) < 0)
+	if (user_to_record(handle, policydb, 
+		usrdatum->value - 1, response) < 0)
 		goto err;
 
 	return STATUS_SUCCESS;
@@ -384,7 +382,7 @@ int sepol_user_iterate(
 
 		int status;
 
-		if (user_to_record(policydb, i, &user) < 0)
+		if (user_to_record(handle, policydb, i, &user) < 0)
 			goto err;
 
 		/* Invoke handler */
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude direct_api.c --exclude semanage_store.c --exclude libsemanage.map --exclude 'module_record*' --exclude 'database_directory*' --exclude Makefile old/libsepol/src/write.c new/libsepol/src/write.c
--- old/libsepol/src/write.c	2005-10-18 10:08:39.000000000 -0400
+++ new/libsepol/src/write.c	2005-10-25 20:36:01.000000000 -0400
@@ -1488,7 +1488,7 @@ int policydb_write(policydb_t * p, struc
 			return -1;
                 if (p->policyvers < POLICYDB_VERSION_BOOL) {
                         if (p->p_bools.nprim)
-				ERR(fp->handle, "Warning! Discarding "
+				WARN(fp->handle, "Discarding "
 					"booleans and conditional rules");
                 }
                 else {

--------------020001080608090308080809--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
