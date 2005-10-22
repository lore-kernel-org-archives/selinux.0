Message-ID: <435A394B.9010304@cornell.edu>
Date: Sat, 22 Oct 2005 09:06:19 -0400
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
CC: Stephen Smalley <sds@tycho.nsa.gov>
Subject: [ SEPOL 5 ] Pass key to sepol
Content-Type: multipart/mixed;
 boundary="------------050802020301040404080907"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------050802020301040404080907
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

I did ask about this - Joshua didn't seem to care either way...

I am not sure if the key should be passed into sepol - it's 
double-storing all the key fields, and now needs an "unpack" method.  
The alternative approach is to pass in a single record structure as both 
key and response, but I think that's an uglier interface, possibly less 
able to adapt to future change.

Since no one expressed a strong opinion either way, here's an 
implementation that passes the key into sepol.
===========

By the way, I was considering three options - keeping the key, dropping 
the key, or keeping the key in semanage only. I don't like this third 
option anymore - the same solution should apply to both libraries.

This patch also drops the sepol_bool_set_array function for now...we 
have the one in genbools to use for mkload.

--------------050802020301040404080907
Content-Type: text/x-patch;
 name="libsemanage.introduce_key.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libsemanage.introduce_key.diff"

diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude database_policydb.h --exclude policy_components.c --exclude libsemanage.map --exclude 'module_record*' --exclude 'database_directory*' old/libsepol/include/sepol/boolean_record.h new/libsepol/include/sepol/boolean_record.h
--- old/libsepol/include/sepol/boolean_record.h	2005-09-30 16:19:08.000000000 -0400
+++ new/libsepol/include/sepol/boolean_record.h	2005-10-20 21:30:39.000000000 -0400
@@ -13,6 +13,10 @@ extern int sepol_bool_key_create(
 	const char* name,
 	sepol_bool_key_t** key);
 
+extern void sepol_bool_key_unpack(
+	sepol_bool_key_t* key,
+	const char** name);
+
 extern int sepol_bool_key_extract(
 	sepol_bool_t* boolean,
 	sepol_bool_key_t** key_ptr);
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude database_policydb.h --exclude policy_components.c --exclude libsemanage.map --exclude 'module_record*' --exclude 'database_directory*' old/libsepol/include/sepol/booleans.h new/libsepol/include/sepol/booleans.h
--- old/libsepol/include/sepol/booleans.h	2005-10-22 07:30:16.000000000 -0400
+++ new/libsepol/include/sepol/booleans.h	2005-10-22 08:25:11.000000000 -0400
@@ -30,13 +30,8 @@ extern int sepol_genbools_array(
 /* Load a boolean into the policy */
 extern int sepol_bool_set (
 	sepol_policydb_t* policydb, 
-	sepol_bool_t* boolean);
-
-/* Load a boolean array into the policy */
-extern int sepol_bool_set_array(
-	sepol_policydb_t* policydb,
-	sepol_bool_t** bool_arr,
-	size_t bool_arr_len);
+	sepol_bool_key_t* key,
+	sepol_bool_t* data);
 
 /* Iterate the booleans
  * The handler may return:
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude database_policydb.h --exclude policy_components.c --exclude libsemanage.map --exclude 'module_record*' --exclude 'database_directory*' old/libsepol/include/sepol/iface_record.h new/libsepol/include/sepol/iface_record.h
--- old/libsepol/include/sepol/iface_record.h	2005-09-30 16:19:08.000000000 -0400
+++ new/libsepol/include/sepol/iface_record.h	2005-10-21 10:59:55.000000000 -0400
@@ -13,6 +13,10 @@ extern int sepol_iface_compare(
 	sepol_iface_t* iface, 
 	sepol_iface_key_t* key);
 
+extern void sepol_iface_key_unpack(
+	sepol_iface_key_t* key,
+	const char** name);
+
 extern int sepol_iface_key_create(
 	const char* name,
 	sepol_iface_key_t** key_ptr);
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude database_policydb.h --exclude policy_components.c --exclude libsemanage.map --exclude 'module_record*' --exclude 'database_directory*' old/libsepol/include/sepol/interfaces.h new/libsepol/include/sepol/interfaces.h
--- old/libsepol/include/sepol/interfaces.h	2005-10-07 16:45:17.000000000 -0400
+++ new/libsepol/include/sepol/interfaces.h	2005-10-22 08:25:57.000000000 -0400
@@ -5,16 +5,16 @@
 #include <sepol/iface_record.h>
 #include <stddef.h>
 
-/* Get the current context mapping for this interface */
-extern int sepol_iface_get_context(
+/* Query an interface */
+extern int sepol_iface_query(
 	sepol_policydb_t* policydb,
-	sepol_iface_t* data,
-	char** ifcon_str, size_t* ifcon_str_len,
-	char** msgcon_str, size_t* msgcon_str_len);
+	sepol_iface_key_t* key,
+	sepol_iface_t** response);
 
-/* Load an interface into policy */
+/* Add an interface to policy */
 extern int sepol_iface_add(
 	sepol_policydb_t* policydb,
+	sepol_iface_key_t* key,
 	sepol_iface_t* data);
 
 /* Iterate the interfaces
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude database_policydb.h --exclude policy_components.c --exclude libsemanage.map --exclude 'module_record*' --exclude 'database_directory*' old/libsepol/include/sepol/port_record.h new/libsepol/include/sepol/port_record.h
--- old/libsepol/include/sepol/port_record.h	2005-09-30 16:19:08.000000000 -0400
+++ new/libsepol/include/sepol/port_record.h	2005-10-20 21:31:45.000000000 -0400
@@ -20,6 +20,10 @@ extern int sepol_port_key_create(
 	int low, int high, int proto,
 	sepol_port_key_t** key_ptr);
 
+extern void sepol_port_key_unpack(
+	sepol_port_key_t* key,
+	int* low, int* high, int* proto);
+
 extern int sepol_port_key_extract(
 	sepol_port_t* port, 
 	sepol_port_key_t** key_ptr);
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude database_policydb.h --exclude policy_components.c --exclude libsemanage.map --exclude 'module_record*' --exclude 'database_directory*' old/libsepol/include/sepol/ports.h new/libsepol/include/sepol/ports.h
--- old/libsepol/include/sepol/ports.h	2005-10-07 16:45:17.000000000 -0400
+++ new/libsepol/include/sepol/ports.h	2005-10-22 08:38:28.000000000 -0400
@@ -5,18 +5,16 @@
 #include <sepol/port_record.h>
 #include <stddef.h>
 
-/* Get the current context mapping
- * for this port. Returns 1 if no match, -1 on error, 0 on
- * success. The returned data is allocated on the heap */
-int sepol_port_get_context(
+/* Query a port */
+extern int sepol_port_query(
 	sepol_policydb_t* policydb,
-	sepol_port_t* data,
-	char** con_str,
-	size_t* con_str_len);
+	sepol_port_key_t* key,
+	sepol_port_t** response);
 
-/* Load the given port into policy. No shadowing is allowed. */
+/* Add a port into policy */
 extern int sepol_port_add(
 	sepol_policydb_t* policydb, 
+	sepol_port_key_t* key,
 	sepol_port_t* data);
 
 /* Iterate the ports 
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude database_policydb.h --exclude policy_components.c --exclude libsemanage.map --exclude 'module_record*' --exclude 'database_directory*' old/libsepol/include/sepol/user_record.h new/libsepol/include/sepol/user_record.h
--- old/libsepol/include/sepol/user_record.h	2005-09-30 16:19:08.000000000 -0400
+++ new/libsepol/include/sepol/user_record.h	2005-10-21 11:00:08.000000000 -0400
@@ -13,6 +13,10 @@ extern int sepol_user_key_create(
 	const char* name,
 	sepol_user_key_t** key);
 
+extern void sepol_user_key_unpack(
+	sepol_user_key_t* key,
+	const char** name);
+
 extern int sepol_user_key_extract(
 	sepol_user_t* user,
 	sepol_user_key_t** key_ptr);
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude database_policydb.h --exclude policy_components.c --exclude libsemanage.map --exclude 'module_record*' --exclude 'database_directory*' old/libsepol/include/sepol/users.h new/libsepol/include/sepol/users.h
--- old/libsepol/include/sepol/users.h	2005-10-21 16:17:46.000000000 -0400
+++ new/libsepol/include/sepol/users.h	2005-10-22 08:27:14.000000000 -0400
@@ -26,12 +26,13 @@ extern void sepol_set_delusers(int on);
 /* Add the user if missing, or modify otherwise */
 extern int sepol_user_modify(
 	sepol_policydb_t* policydb, 
-	sepol_user_t* user);
+	sepol_user_key_t* key,
+	sepol_user_t* data);
 
 /* Check if the specified user exists */
 extern int sepol_user_exists(
 	sepol_policydb_t* policydb,
-	const char* user,
+	sepol_user_key_t* key,
 	int* response);
 
 /* Iterate the users
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude database_policydb.h --exclude policy_components.c --exclude libsemanage.map --exclude 'module_record*' --exclude 'database_directory*' old/libsepol/src/boolean_record.c new/libsepol/src/boolean_record.c
--- old/libsepol/src/boolean_record.c	2005-09-30 16:19:08.000000000 -0400
+++ new/libsepol/src/boolean_record.c	2005-10-20 21:29:57.000000000 -0400
@@ -37,6 +37,13 @@ int sepol_bool_key_create(
 	return STATUS_SUCCESS;
 }
 
+void sepol_bool_key_unpack(
+	sepol_bool_key_t* key,
+	const char** name) {
+
+	*name = key->name;
+}
+
 int sepol_bool_key_extract(sepol_bool_t* boolean, sepol_bool_key_t** key_ptr) {
 	if (sepol_bool_key_create(boolean->name, key_ptr) < 0) {
 		DEBUG(__FUNCTION__, "could not extract key from boolean %s\n",
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude database_policydb.h --exclude policy_components.c --exclude libsemanage.map --exclude 'module_record*' --exclude 'database_directory*' old/libsepol/src/booleans.c new/libsepol/src/booleans.c
--- old/libsepol/src/booleans.c	2005-10-22 07:30:16.000000000 -0400
+++ new/libsepol/src/booleans.c	2005-10-22 08:24:07.000000000 -0400
@@ -12,12 +12,18 @@
 #include <sepol/policydb/conditional.h>
 #include <sepol/boolean_record.h>
 
-static inline int bool_update (
+static int bool_update (
 	policydb_t* policydb,
-	sepol_bool_t* boolean) {
+	sepol_bool_key_t* key,
+	sepol_bool_t* data) {
 
-	char* name = strdup(sepol_bool_get_name(boolean));
-	int value = sepol_bool_get_value(boolean);
+	const char* cname;
+	char* name;
+	int value;
+
+	sepol_bool_key_unpack(key, &cname);
+	name = strdup(name);	
+	value = sepol_bool_get_value(data);
 
 	if (!name) {
 		DEBUG(__FUNCTION__, "out of memory\n");
@@ -41,8 +47,7 @@ static inline int bool_update (
 
 	err:
 	free(name);
-	DEBUG(__FUNCTION__, "unable to update boolean %s\n", 
-		sepol_bool_get_name(boolean));
+	DEBUG(__FUNCTION__, "could not update boolean %s\n",  cname);
 	return STATUS_ERR;		
 }
 
@@ -75,11 +80,12 @@ static int bool_to_record (
 }
 
 int sepol_bool_set (
-	sepol_policydb_t* p, 
-	sepol_bool_t* boolean) {
+	sepol_policydb_t* p,
+	sepol_bool_key_t* key, 
+	sepol_bool_t* data) {
 
 	policydb_t *policydb = &p->p;
-	if (bool_update(policydb, boolean) < 0)
+	if (bool_update(policydb, key, data) < 0)
 		goto err;	
 	
         if (evaluate_conds(policydb) < 0) {
@@ -90,38 +96,9 @@ int sepol_bool_set (
 	return STATUS_SUCCESS;
 
 	err:
-	DEBUG(__FUNCTION__, "could not load boolean %s\n", 
-		sepol_bool_get_name(boolean));
-	errno = EINVAL;
-	return STATUS_ERR;
-}
-
-int sepol_bool_set_array(
-	sepol_policydb_t* p,
-	sepol_bool_t** bool_arr,
-	size_t bool_arr_len) {	
-
-	policydb_t *policydb = &p->p;
-	unsigned int i, errors = 0;
-
-	for (i = 0; i < bool_arr_len; i++)
-		if (bool_update(policydb, bool_arr[i]) < 0) {
-			errors++;
-			continue;
-		}	
-
-	if (evaluate_conds(policydb) < 0) {
-		DEBUG(__FUNCTION__, "error while re-evaluating conditionals\n");
-		goto err;
-	}
-
-	if (errors) 
-		goto err;
-
-	return STATUS_SUCCESS;
-	err:
+	DEBUG(__FUNCTION__, "could not set boolean %s\n",
+		sepol_bool_get_name(data)); 
 	errno = EINVAL;
-	DEBUG(__FUNCTION__, "error while loading booleans\n");
 	return STATUS_ERR;
 }
 
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude database_policydb.h --exclude policy_components.c --exclude libsemanage.map --exclude 'module_record*' --exclude 'database_directory*' old/libsepol/src/iface_record.c new/libsepol/src/iface_record.c
--- old/libsepol/src/iface_record.c	2005-09-30 16:19:08.000000000 -0400
+++ new/libsepol/src/iface_record.c	2005-10-20 21:46:04.000000000 -0400
@@ -43,6 +43,13 @@ int sepol_iface_key_create(
 	return STATUS_SUCCESS;
 }
 
+void sepol_iface_key_unpack(
+	sepol_iface_key_t* key,
+	const char** name) {
+
+	*name = key->name;	
+}
+
 int sepol_iface_key_extract(sepol_iface_t* iface, sepol_iface_key_t** key_ptr) {
 	if (sepol_iface_key_create(iface->name, key_ptr) < 0) {
 		DEBUG(__FUNCTION__, "could not extract key from "
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude database_policydb.h --exclude policy_components.c --exclude libsemanage.map --exclude 'module_record*' --exclude 'database_directory*' old/libsepol/src/interfaces.c new/libsepol/src/interfaces.c
--- old/libsepol/src/interfaces.c	2005-10-22 07:30:16.000000000 -0400
+++ new/libsepol/src/interfaces.c	2005-10-22 08:39:21.000000000 -0400
@@ -97,66 +97,57 @@ static int iface_to_record (
 }
 
 /* Get the current context mapping for this interface */
-int sepol_iface_get_context(
+int sepol_iface_query (
 	sepol_policydb_t* p,
-	sepol_iface_t* data,
-	char** ifcon_str, size_t* ifcon_str_len,	
-	char** msgcon_str, size_t* msgcon_str_len) {
+	sepol_iface_key_t* key,
+	sepol_iface_t** response) {
 
 	policydb_t *policydb = &p->p;
 	ocontext_t *c, *head;
-	const char* name = sepol_iface_get_name(data);
+
+	const char* name;
+	sepol_iface_key_unpack(key, &name);
 
 	head = policydb->ocontexts[OCON_NETIF];
 	for (c = head; c; c = c->next) {
-		if (!strcmp(name, c->u.name)) { 
-			if (context_to_string(policydb, 
-				&c->context[0], ifcon_str, ifcon_str_len) < 0)
-				goto err;
-	
-			if (context_to_string(policydb,
-				&c->context[1], msgcon_str, msgcon_str_len) < 0)
+		if (!strcmp(name, c->u.name)) {
+
+			if (iface_to_record(policydb, c, response) < 0)
 				goto err;
 
 			return STATUS_SUCCESS;
 		}
-	}
-
+	} 
 	return STATUS_NODATA;
 
 	err: 
-	DEBUG(__FUNCTION__, "could not construct context string for "
-		"interface %s\n", name);
+	DEBUG(__FUNCTION__, "could not query interface %s\n", name);
 	return STATUS_ERR;
 }
 
 /* Load an interface into policy */
 int sepol_iface_add(
-	sepol_policydb_t* p, 
+	sepol_policydb_t* p,
+	sepol_iface_key_t* key, 
 	sepol_iface_t* data) {
 
 	policydb_t *policydb = &p->p;
 	ocontext_t* iface = NULL;
-	char *ifcon_str, *msgcon_str;
-	size_t ifcon_str_len, msgcon_str_len;
+	sepol_iface_t* query_response = NULL;
 	int rc;
 
-	const char* name = sepol_iface_get_name(data);
+	const char* name;
+	sepol_iface_key_unpack(key, &name);
 
-	if (iface_from_record(policydb, &iface, data) < 0)
+	rc = sepol_iface_query(p, key, &query_response);
+	if (rc < 0) 
 		goto err;
 
-	rc = sepol_iface_get_context(
-		p, data, 
-		&ifcon_str, &ifcon_str_len,
-		&msgcon_str, &msgcon_str_len);
-	if (rc < 0) 
+	if (iface_from_record(policydb, &iface, data) < 0)
 		goto err;
 
 	else if (rc != STATUS_NODATA) {
-		DEBUG(__FUNCTION__, "interface %s is already mapped to " 
-			"context %s with message context %s\n", 
-			name, ifcon_str, msgcon_str);
+		DEBUG(__FUNCTION__, "interface is already configured\n"); 
 		goto err;
 	}
 	
@@ -164,12 +155,14 @@ int sepol_iface_add(
 	iface->next = policydb->ocontexts[OCON_NETIF];
 	policydb->ocontexts[OCON_NETIF] = iface;
 
+	sepol_iface_free(query_response);
 	return STATUS_SUCCESS;
 
 	err:
 	DEBUG(__FUNCTION__, "error while loading interface %s\n", name);
 	free(iface->u.name);
 	free(iface);
+	sepol_iface_free(query_response);
 	return STATUS_ERR;
 }
 
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude database_policydb.h --exclude policy_components.c --exclude libsemanage.map --exclude 'module_record*' --exclude 'database_directory*' old/libsepol/src/port_record.c new/libsepol/src/port_record.c
--- old/libsepol/src/port_record.c	2005-09-30 16:19:08.000000000 -0400
+++ new/libsepol/src/port_record.c	2005-10-20 21:27:53.000000000 -0400
@@ -46,6 +46,16 @@ int sepol_port_key_create(
 	return STATUS_SUCCESS;
 }
 
+void sepol_port_key_unpack(
+	sepol_port_key_t* key,
+	int* low, int* high, int* proto) {
+
+	*low = key->low;
+	*high = key->high;
+	*proto = key->proto;
+}
+
+
 int sepol_port_key_extract(sepol_port_t* port, sepol_port_key_t** key_ptr) {
 	if (sepol_port_key_create(
 		port->low, port->high, port->proto, key_ptr) < 0) {
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude database_policydb.h --exclude policy_components.c --exclude libsemanage.map --exclude 'module_record*' --exclude 'database_directory*' old/libsepol/src/ports.c new/libsepol/src/ports.c
--- old/libsepol/src/ports.c	2005-10-22 07:30:16.000000000 -0400
+++ new/libsepol/src/ports.c	2005-10-22 08:40:59.000000000 -0400
@@ -125,22 +125,21 @@ static int port_to_record (
 }
 
 /* Get the current context mapping for this port */
-int sepol_port_get_context(
+int sepol_port_query(
 	sepol_policydb_t* p,
-	sepol_port_t* data,
-	char** con_str,	
-	size_t* con_str_len) {
+	sepol_port_key_t* key,
+	sepol_port_t** response) {
 
 	policydb_t *policydb = &p->p;
-	int low = sepol_port_get_low(data);	
-	int high = sepol_port_get_high(data);
+	ocontext_t *c, *l, *head;
+
+	int low, high, proto;
+	sepol_port_key_unpack(key, &low, &high, &proto);
+	proto = sepol2ipproto(proto);
 
-	int proto = sepol2ipproto(sepol_port_get_proto(data));
 	if (proto < 0)
 		goto err;
 
-	ocontext_t *c, *l, *head;
-
 	head = policydb->ocontexts[OCON_PORT];
 	for (l = NULL, c = head; c; l = c, c = c->next) {
 		int proto2 = c->u.port.protocol;
@@ -153,10 +152,10 @@ int sepol_port_get_context(
 
 		if ((low == low2 && high == high2) ||
 		    (low2 <= low && high2 >= high)) {
-			if (context_to_string(policydb, con2, 
-				con_str, con_str_len) < 0)
-				goto err;		
-	
+
+			if (port_to_record(policydb, c, response) < 0)
+				goto err;
+
 			return STATUS_SUCCESS;
 		}
 	}
@@ -164,9 +163,8 @@ int sepol_port_get_context(
 	return STATUS_NODATA;
 
 	err: 
-	DEBUG(__FUNCTION__, "could not retrieve context string for "
-		"port entry %s %d-%d\n", 
-			sepol_port_get_proto_str(data), low, high);
+	DEBUG(__FUNCTION__, "could not get context for port %i:%d-%d\n", 
+				proto, low, high);
 	return STATUS_ERR;
 
 }
@@ -174,41 +172,41 @@ int sepol_port_get_context(
 /* Load a port into policy */
 int sepol_port_add(
 	sepol_policydb_t* p, 
+	sepol_port_key_t* key,
 	sepol_port_t* data) {
+
 	policydb_t *policydb = &p->p;
 	ocontext_t* port = NULL;
-	char* dup_match;
-	size_t dup_size; 
+	sepol_port_t* query_response = NULL;
 	int rc;
 
-	if (port_from_record(policydb, &port, data) < 0)
-		goto err;
-
-	rc = sepol_port_get_context(p, data, &dup_match, &dup_size);
+	rc = sepol_port_query(p, key, &query_response);
 	if (rc < 0) 
 		goto err;
-
 	else if (rc != STATUS_NODATA) {
-		DEBUG(__FUNCTION__, "port entry for %s %d-%d "
-			"is already mapped to context %s\n",
-			sepol_port_get_proto_str(data),
-			sepol_port_get_low(data),
-			sepol_port_get_high(data), dup_match);
+		DEBUG(__FUNCTION__, "port entry is already configured\n");
 		goto err;
 	}
+
+	if (port_from_record(policydb, &port, data) < 0)
+		goto err;
 	
 	/* Attach to context list */
 	port->next = policydb->ocontexts[OCON_PORT];
 	policydb->ocontexts[OCON_PORT] = port;
 
+	sepol_port_free(query_response);
 	return STATUS_SUCCESS;
 
 	err:
-	DEBUG(__FUNCTION__, "error while loading port %s %d-%d\n",
-		sepol_port_get_proto_str(data),
+	DEBUG(__FUNCTION__, "could not load "
+		"%s port %d-%d\n",
+		sepol_port_get_proto_str(data), 
 		sepol_port_get_low(data),
 		sepol_port_get_high(data));
+
 	free(port);
+	sepol_port_free(query_response);
 	return STATUS_ERR;
 }
 
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude database_policydb.h --exclude policy_components.c --exclude libsemanage.map --exclude 'module_record*' --exclude 'database_directory*' old/libsepol/src/user_record.c new/libsepol/src/user_record.c
--- old/libsepol/src/user_record.c	2005-10-21 09:54:25.000000000 -0400
+++ new/libsepol/src/user_record.c	2005-10-20 21:28:42.000000000 -0400
@@ -50,6 +50,13 @@ int sepol_user_key_create(
 	return STATUS_SUCCESS;
 }
 
+void sepol_user_key_unpack(
+	sepol_user_key_t* key,
+	const char** name) {
+
+	*name = key->name;
+}
+
 int sepol_user_key_extract(sepol_user_t* user, sepol_user_key_t** key_ptr) {
 	if (sepol_user_key_create(user->name, key_ptr) < 0) {
 		DEBUG(__FUNCTION__, "could not extract key from user %s\n",
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude database_policydb.h --exclude policy_components.c --exclude libsemanage.map --exclude 'module_record*' --exclude 'database_directory*' old/libsepol/src/users.c new/libsepol/src/users.c
--- old/libsepol/src/users.c	2005-10-22 08:42:17.000000000 -0400
+++ new/libsepol/src/users.c	2005-10-22 08:39:50.000000000 -0400
@@ -81,12 +81,17 @@ static int user_to_record (
 	return STATUS_ERR;
 }
 
-int sepol_user_modify(sepol_policydb_t* p, sepol_user_t* user) {
+int sepol_user_modify(
+	sepol_policydb_t* p, 
+	sepol_user_key_t* key,
+	sepol_user_t* user) {
+
 	policydb_t *policydb = &p->p;
+
 	/* For user data */	
-	const char *tmp_mlslevel, *tmp_mlsrange;
-	char *name = NULL;
-	char *mls_level = NULL, *mls_range = NULL;
+	const char *cname, *cmls_level, *cmls_range;
+	char *name = NULL, *mls_level = NULL, *mls_range = NULL;
+
 	const char **roles = NULL;
 	size_t num_roles = 0;
 	char *role = NULL;
@@ -103,18 +108,19 @@ int sepol_user_modify(sepol_policydb_t* 
 	ebitmap_node_t *rnode;
 
 	/* First, extract all the data */
-	name = strdup(sepol_user_get_name(user));
-	tmp_mlslevel = sepol_user_get_mlslevel(user);
-	tmp_mlsrange = sepol_user_get_mlsrange(user);
-	mls_level = tmp_mlslevel? strdup(tmp_mlslevel): NULL;
-	mls_range = tmp_mlsrange? strdup(tmp_mlsrange): NULL;
+	sepol_user_key_unpack(key, &cname);
+	name = strdup(cname);
+
+	cmls_level = sepol_user_get_mlslevel(user);
+	cmls_range = sepol_user_get_mlsrange(user);
+	mls_level = cmls_level? strdup(cmls_level): NULL;
+	mls_range = cmls_range? strdup(cmls_range): NULL;
 
 	/* Make sure that worked properly */
 	if (sepol_user_get_roles(user, &roles, &num_roles) < 0)
 		goto err;
 
-	if (!name || (tmp_mlslevel && !mls_level) ||
-		(tmp_mlsrange && !mls_range))
+	if (!name || (cmls_level && !mls_level) || (cmls_range && !mls_range))
 		goto omem;
 		
 	/* Now, see if a user exists */
@@ -259,18 +265,23 @@ int sepol_user_modify(sepol_policydb_t* 
 
 int sepol_user_exists(
 	sepol_policydb_t* p, 
-	const char* user,
+	sepol_user_key_t* key,
 	int* response) {
 
 	policydb_t *policydb = &p->p;
-	char* user_copy = strdup(user);
-	if (!user_copy) {
+
+	const char* cname;	
+	char* name = NULL;
+	sepol_user_key_unpack(key, &cname);
+	name = strdup(cname);	
+
+	if (!name) {
 		DEBUG(__FUNCTION__, "out of memory, user check failed\n");
 		return STATUS_ERR;
 	}
 	
-	*response = (hashtab_search(policydb->p_users.table, user_copy) != NULL);
-	free(user_copy);
+	*response = (hashtab_search(policydb->p_users.table, name) != NULL);
+	free(name);
 	return STATUS_SUCCESS;
 }
 

--------------050802020301040404080907--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
