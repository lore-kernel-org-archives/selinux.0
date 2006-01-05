Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id k06DKGXf000009
	for <selinux@tycho.nsa.gov>; Fri, 6 Jan 2006 08:20:16 -0500 (EST)
Received: from moss-lions.epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k06DKDfk019298
	for <selinux@tycho.nsa.gov>; Fri, 6 Jan 2006 13:20:14 GMT
Received: from moss-lions.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by moss-lions.epoch.ncsc.mil (8.13.4/8.13.4) with ESMTP id k06DJODB023642
	for <selinux@tycho.nsa.gov>; Fri, 6 Jan 2006 08:19:24 -0500
Received: (from jwcart2@localhost)
	by moss-lions.epoch.ncsc.mil (8.13.4/8.13.4/Submit) id k06DJO89023641
	for selinux@tycho.nsa.gov; Fri, 6 Jan 2006 08:19:24 -0500
Message-ID: <43BD635A.7040709@cornell.edu>
Date: Thu, 05 Jan 2006 13:20:10 -0500
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: SELinux List <SELinux@tycho.nsa.gov>
CC: Stephen Smalley <sds@tycho.nsa.gov>
Subject: [SEPOL] Const in APIs (part 1)
Content-Type: multipart/mixed;
 boundary="------------020907060106050608020202"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------020907060106050608020202
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit

Makes a ton of things const for the purposes of enhanced error checking.

I can't figure this out out:
context.c: In function ‘sepol_check_context’:
context.c:25: warning: passing argument 1 of ‘sepol_context_to_sid’ 
discards qualifiers from pointer target type

Something's confusing it - either the hidden proto, or the fact that the 
typedef wraps the pointer - not sure why it won't go away.

--------------020907060106050608020202
Content-Type: text/x-patch;
 name="libsepol.const_api.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libsepol.const_api.diff"

diff -Naurp --exclude libsemanage --exclude-from excludes old/libsepol/include/sepol/boolean_record.h new/libsepol/include/sepol/boolean_record.h
--- old/libsepol/include/sepol/boolean_record.h	2005-10-31 11:09:39.000000000 -0500
+++ new/libsepol/include/sepol/boolean_record.h	2006-01-05 12:40:34.000000000 -0500
@@ -16,24 +16,24 @@ extern int sepol_bool_key_create(
 	sepol_bool_key_t** key);
 
 extern void sepol_bool_key_unpack(
-	sepol_bool_key_t* key,
+	const sepol_bool_key_t* key,
 	const char** name);
 
 extern int sepol_bool_key_extract(
 	sepol_handle_t* handle,
-	sepol_bool_t* boolean,
+	const sepol_bool_t* boolean,
 	sepol_bool_key_t** key_ptr);
 
 extern void sepol_bool_key_free(
 	sepol_bool_key_t* key);
 
 extern int sepol_bool_compare(
-	sepol_bool_t* boolean,
-	sepol_bool_key_t* key);
+	const sepol_bool_t* boolean,
+	const sepol_bool_key_t* key);
 	
 /* Name */
 extern const char* sepol_bool_get_name(
-	sepol_bool_t* boolean);
+	const sepol_bool_t* boolean);
 
 extern int sepol_bool_set_name(
 	sepol_handle_t* handle,
@@ -42,7 +42,7 @@ extern int sepol_bool_set_name(
 
 /* Value */
 extern int sepol_bool_get_value(
-	sepol_bool_t* boolean);
+	const sepol_bool_t* boolean);
 
 extern void sepol_bool_set_value(
 	sepol_bool_t* boolean, 
@@ -55,7 +55,7 @@ extern int sepol_bool_create(
 
 extern int sepol_bool_clone(
 	sepol_handle_t* handle,
-	sepol_bool_t* boolean, 
+	const sepol_bool_t* boolean, 
 	sepol_bool_t** bool_ptr);
 
 extern void sepol_bool_free(
diff -Naurp --exclude libsemanage --exclude-from excludes old/libsepol/include/sepol/booleans.h new/libsepol/include/sepol/booleans.h
--- old/libsepol/include/sepol/booleans.h	2005-10-27 17:39:08.000000000 -0400
+++ new/libsepol/include/sepol/booleans.h	2006-01-05 12:50:16.000000000 -0500
@@ -32,27 +32,27 @@ extern int sepol_genbools_array(
 extern int sepol_bool_set (
 	sepol_handle_t* handle,
 	sepol_policydb_t* policydb, 
-	sepol_bool_key_t* key,
-	sepol_bool_t* data);
+	const sepol_bool_key_t* key,
+	const sepol_bool_t* data);
 
 /* Return the number of booleans */
 extern int sepol_bool_count(
 	sepol_handle_t* handle,
-	sepol_policydb_t* p,
+	const sepol_policydb_t* p,
 	unsigned int* response);
 
 /* Check if the specified boolean exists */
 extern int sepol_bool_exists(
 	sepol_handle_t* handle,
-	sepol_policydb_t* policydb,
-	sepol_bool_key_t* key,
+	const sepol_policydb_t* policydb,
+	const sepol_bool_key_t* key,
 	int* response);
 
 /* Query a boolean - returns the boolean, or NULL if not found */
 extern int sepol_bool_query(
 	sepol_handle_t* handle,
-	sepol_policydb_t* p,
-	sepol_bool_key_t* key,
+	const sepol_policydb_t* p,
+	const sepol_bool_key_t* key,
 	sepol_bool_t** response);
 
 /* Iterate the booleans
@@ -63,9 +63,9 @@ extern int sepol_bool_query(
 
 extern int sepol_bool_iterate(
 	sepol_handle_t* handle,
-	sepol_policydb_t* policydb,
+	const sepol_policydb_t* policydb,
 	int (*fn)(
-		sepol_bool_t* boolean,
+		const sepol_bool_t* boolean,
 		void* fn_arg),
 	void* arg);
 
diff -Naurp --exclude libsemanage --exclude-from excludes old/libsepol/include/sepol/context.h new/libsepol/include/sepol/context.h
--- old/libsepol/include/sepol/context.h	2006-01-04 12:17:25.000000000 -0500
+++ new/libsepol/include/sepol/context.h	2006-01-05 12:52:58.000000000 -0500
@@ -8,24 +8,24 @@
 /* -- Deprecated -- */
 
 extern int sepol_check_context(
-	char *context);
+	const char *context);
 
 /* -- End deprecated -- */
 
 extern int sepol_context_check(
 	sepol_handle_t* handle,
-	sepol_policydb_t* policydb,
-	sepol_context_t* context);
+	const sepol_policydb_t* policydb,
+	const sepol_context_t* context);
 
 extern int sepol_mls_contains(
 	sepol_handle_t* handle,
-	sepol_policydb_t* policydb,
+	const sepol_policydb_t* policydb,
 	const char* mls1,
 	const char* mls2,
 	int* response);
 
 extern int sepol_mls_check(
 	sepol_handle_t* handle,
-	sepol_policydb_t* policydb,
+	const sepol_policydb_t* policydb,
 	const char* mls);
 #endif
diff -Naurp --exclude libsemanage --exclude-from excludes old/libsepol/include/sepol/context_record.h new/libsepol/include/sepol/context_record.h
--- old/libsepol/include/sepol/context_record.h	2005-11-03 12:48:03.000000000 -0500
+++ new/libsepol/include/sepol/context_record.h	2006-01-05 12:41:08.000000000 -0500
@@ -11,7 +11,7 @@ typedef struct sepol_context sepol_conte
 
 /* User */
 extern const char* sepol_context_get_user(
-	sepol_context_t* con);
+	const sepol_context_t* con);
 
 extern int sepol_context_set_user(
 	sepol_handle_t* handle,
@@ -20,7 +20,7 @@ extern int sepol_context_set_user(
 
 /* Role */
 extern const char* sepol_context_get_role(
-	sepol_context_t* con);
+	const sepol_context_t* con);
 
 extern int sepol_context_set_role(
 	sepol_handle_t* handle,
@@ -29,7 +29,7 @@ extern int sepol_context_set_role(
 
 /* Type */
 extern const char* sepol_context_get_type(
-	sepol_context_t* con);
+	const sepol_context_t* con);
 
 extern int sepol_context_set_type(
 	sepol_handle_t* handle,
@@ -38,7 +38,7 @@ extern int sepol_context_set_type(
 
 /* MLS */
 extern const char* sepol_context_get_mls(
-	sepol_context_t* con);
+	const sepol_context_t* con);
 
 extern int sepol_context_set_mls(
 	sepol_handle_t* handle,
@@ -52,7 +52,7 @@ extern int sepol_context_create(
 
 extern int sepol_context_clone(
 	sepol_handle_t* handle,
-	sepol_context_t* con, 
+	const sepol_context_t* con, 
 	sepol_context_t** con_ptr);
 
 extern void sepol_context_free(
@@ -66,7 +66,7 @@ extern int sepol_context_from_string(
 
 extern int sepol_context_to_string(
 	sepol_handle_t* handle,
-	sepol_context_t* con,
+	const sepol_context_t* con,
 	char** str_ptr);
 
 #endif 
diff -Naurp --exclude libsemanage --exclude-from excludes old/libsepol/include/sepol/iface_record.h new/libsepol/include/sepol/iface_record.h
--- old/libsepol/include/sepol/iface_record.h	2005-10-31 11:09:39.000000000 -0500
+++ new/libsepol/include/sepol/iface_record.h	2006-01-05 12:43:37.000000000 -0500
@@ -11,11 +11,11 @@ typedef struct sepol_iface_key sepol_ifa
 
 /* Key */
 extern int sepol_iface_compare(
-	sepol_iface_t* iface, 
-	sepol_iface_key_t* key);
+	const sepol_iface_t* iface, 
+	const sepol_iface_key_t* key);
 
 extern void sepol_iface_key_unpack(
-	sepol_iface_key_t* key,
+	const sepol_iface_key_t* key,
 	const char** name);
 
 extern int sepol_iface_key_create(
@@ -25,7 +25,7 @@ extern int sepol_iface_key_create(
 
 extern int sepol_iface_key_extract(
 	sepol_handle_t* handle,
-	sepol_iface_t* iface, 
+	const sepol_iface_t* iface, 
 	sepol_iface_key_t** key_ptr);
 
 extern void sepol_iface_key_free(
@@ -33,7 +33,7 @@ extern void sepol_iface_key_free(
 
 /* Name */
 extern const char* sepol_iface_get_name(
-	sepol_iface_t* iface);
+	const sepol_iface_t* iface);
 
 extern int sepol_iface_set_name(
 	sepol_handle_t* handle,
@@ -42,14 +42,14 @@ extern int sepol_iface_set_name(
 
 /* Context */
 extern sepol_context_t* sepol_iface_get_ifcon(
-	sepol_iface_t* iface);
+	const sepol_iface_t* iface);
 
 extern void sepol_iface_set_ifcon(
 	sepol_iface_t* iface, 
 	sepol_context_t* con);
 
 extern sepol_context_t* sepol_iface_get_msgcon(
-	sepol_iface_t* iface);
+	const sepol_iface_t* iface);
 
 extern void sepol_iface_set_msgcon(
 	sepol_iface_t* iface, 
@@ -62,7 +62,7 @@ extern int sepol_iface_create(
 
 extern int sepol_iface_clone(
 	sepol_handle_t* handle,
-	sepol_iface_t* iface, 
+	const sepol_iface_t* iface, 
 	sepol_iface_t** iface_ptr);
 
 extern void sepol_iface_free(
diff -Naurp --exclude libsemanage --exclude-from excludes old/libsepol/include/sepol/interfaces.h new/libsepol/include/sepol/interfaces.h
--- old/libsepol/include/sepol/interfaces.h	2005-10-27 17:39:08.000000000 -0400
+++ new/libsepol/include/sepol/interfaces.h	2006-01-05 12:49:58.000000000 -0500
@@ -8,22 +8,22 @@
 /* Return the number of interfaces */
 extern int sepol_iface_count(
 	sepol_handle_t* handle,
-	sepol_policydb_t* p,
+	const sepol_policydb_t* policydb,
 	unsigned int* response);
 
 /* Check if an interface exists */
 extern int sepol_iface_exists(
 	sepol_handle_t* handle,
-	sepol_policydb_t* policydb,
-	sepol_iface_key_t* key,
+	const sepol_policydb_t* policydb,
+	const sepol_iface_key_t* key,
 	int* response);
 
 /* Query an interface - returns the interface, 
  * or NULL if not found */
 extern int sepol_iface_query(
 	sepol_handle_t* handle,
-	sepol_policydb_t* policydb,
-	sepol_iface_key_t* key,
+	const sepol_policydb_t* policydb,
+	const sepol_iface_key_t* key,
 	sepol_iface_t** response);
 
 /* Modify an interface, or add it, if the key
@@ -31,8 +31,8 @@ extern int sepol_iface_query(
 extern int sepol_iface_modify(
 	sepol_handle_t* handle,
 	sepol_policydb_t* policydb,
-	sepol_iface_key_t* key,
-	sepol_iface_t* data);
+	const sepol_iface_key_t* key,
+	const sepol_iface_t* data);
 
 /* Iterate the interfaces
  * The handler may return:
@@ -42,9 +42,9 @@ extern int sepol_iface_modify(
 
 extern int sepol_iface_iterate(
 	sepol_handle_t* handle,
-	sepol_policydb_t* policydb,
+	const sepol_policydb_t* policydb,
 	int (*fn)(
-		sepol_iface_t* iface,
+		const sepol_iface_t* iface,
 		void* fn_arg),
 	void* arg);
 
diff -Naurp --exclude libsemanage --exclude-from excludes old/libsepol/include/sepol/policydb/ebitmap.h new/libsepol/include/sepol/policydb/ebitmap.h
--- old/libsepol/include/sepol/policydb/ebitmap.h	2005-10-07 16:45:17.000000000 -0400
+++ new/libsepol/include/sepol/policydb/ebitmap.h	2006-01-05 12:57:32.000000000 -0500
@@ -41,8 +41,10 @@ typedef struct ebitmap {
 #define ebitmap_startbit(e) ((e)->node ? (e)->node->startbit : 0)
 #define ebitmap_startnode(e) ((e)->node)
 
-static inline unsigned int ebitmap_start(ebitmap_t *e, ebitmap_node_t **n) 
-{
+static inline unsigned int ebitmap_start(
+	const ebitmap_t *e, 
+	ebitmap_node_t **n)  {
+
 	*n = e->node;
 	return ebitmap_startbit(e);
 }
diff -Naurp --exclude libsemanage --exclude-from excludes old/libsepol/include/sepol/policydb/policydb.h new/libsepol/include/sepol/policydb/policydb.h
--- old/libsepol/include/sepol/policydb/policydb.h	2005-10-25 10:17:27.000000000 -0400
+++ new/libsepol/include/sepol/policydb/policydb.h	2006-01-05 12:25:03.000000000 -0500
@@ -469,7 +469,9 @@ extern void policydb_destroy(policydb_t 
 extern int policydb_load_isids(policydb_t *p, sidtab_t *s);
 
 /* Deprecated */
-extern int policydb_context_isvalid(policydb_t *p, context_struct_t *c);
+extern int policydb_context_isvalid(
+	const policydb_t *p, 
+	const context_struct_t *c);
 
 extern void symtabs_destroy(symtab_t *symtab);
 extern int scope_destroy(hashtab_key_t key, hashtab_datum_t datum, void *p);
diff -Naurp --exclude libsemanage --exclude-from excludes old/libsepol/include/sepol/policydb/services.h new/libsepol/include/sepol/policydb/services.h
--- old/libsepol/include/sepol/policydb/services.h	2005-10-07 16:45:17.000000000 -0400
+++ new/libsepol/include/sepol/policydb/services.h	2006-01-05 13:13:17.000000000 -0500
@@ -108,9 +108,9 @@ extern int sepol_sid_to_context(
  * has the string representation specified by `scontext'.
  */
 extern int sepol_context_to_sid(
-	sepol_security_context_t scontext,		/* IN */
-	size_t  scontext_len,			/* IN */
-	sepol_security_id_t *out_sid);		/* OUT */
+	const sepol_security_context_t scontext, /* IN */
+	size_t  scontext_len,                    /* IN */
+	sepol_security_id_t *out_sid);           /* OUT */
 
 /*
  * Generate the set of SIDs for legal security contexts
diff -Naurp --exclude libsemanage --exclude-from excludes old/libsepol/include/sepol/port_record.h new/libsepol/include/sepol/port_record.h
--- old/libsepol/include/sepol/port_record.h	2005-10-31 11:09:39.000000000 -0500
+++ new/libsepol/include/sepol/port_record.h	2006-01-05 12:43:00.000000000 -0500
@@ -14,8 +14,8 @@ typedef struct sepol_port_key sepol_port
 
 /* Key */
 extern int sepol_port_compare(
-	sepol_port_t* port, 
-	sepol_port_key_t* key);
+	const sepol_port_t* port, 
+	const sepol_port_key_t* key);
 
 extern int sepol_port_key_create(
 	sepol_handle_t* handle,
@@ -23,12 +23,12 @@ extern int sepol_port_key_create(
 	sepol_port_key_t** key_ptr);
 
 extern void sepol_port_key_unpack(
-	sepol_port_key_t* key,
+	const sepol_port_key_t* key,
 	int* low, int* high, int* proto);
 
 extern int sepol_port_key_extract(
 	sepol_handle_t* handle,
-	sepol_port_t* port, 
+	const sepol_port_t* port, 
 	sepol_port_key_t** key_ptr);
 
 extern void sepol_port_key_free(
@@ -36,21 +36,21 @@ extern void sepol_port_key_free(
 
 /* Protocol */
 extern int sepol_port_get_proto(
-	sepol_port_t* port);
+	const sepol_port_t* port);
 
 extern void sepol_port_set_proto(
 	sepol_port_t* port, 
 	int proto);
 
 extern const char* sepol_port_get_proto_str(
-	sepol_port_t* port);
+	const sepol_port_t* port);
 
 /* Port */
 extern int sepol_port_get_low(
-	sepol_port_t* port);
+	const sepol_port_t* port);
 
 extern int sepol_port_get_high(
-	sepol_port_t* port);
+	const sepol_port_t* port);
 
 extern void sepol_port_set_port(
 	sepol_port_t* port, 
@@ -62,7 +62,7 @@ extern void sepol_port_set_range(
 
 /* Context */
 extern sepol_context_t* sepol_port_get_con(
-	sepol_port_t* port);
+	const sepol_port_t* port);
 
 extern void sepol_port_set_con(
 	sepol_port_t* port, 
@@ -75,7 +75,7 @@ extern int sepol_port_create(
 
 extern int sepol_port_clone(
 	sepol_handle_t* handle,
-	sepol_port_t* port, 
+	const sepol_port_t* port, 
 	sepol_port_t** port_ptr);
 
 extern void sepol_port_free(
diff -Naurp --exclude libsemanage --exclude-from excludes old/libsepol/include/sepol/ports.h new/libsepol/include/sepol/ports.h
--- old/libsepol/include/sepol/ports.h	2005-10-27 17:39:08.000000000 -0400
+++ new/libsepol/include/sepol/ports.h	2006-01-05 12:37:27.000000000 -0500
@@ -8,29 +8,29 @@
 /* Return the number of ports */
 extern int sepol_port_count(
 	sepol_handle_t* handle,
-	sepol_policydb_t* p,
+	const sepol_policydb_t* p,
 	unsigned int* response);
 
 /* Check if a port exists */
 extern int sepol_port_exists(
 	sepol_handle_t* handle,
-	sepol_policydb_t* policydb,
-	sepol_port_key_t* key,
+	const sepol_policydb_t* policydb,
+	const sepol_port_key_t* key,
 	int* response);
 
 /* Query a port - returns the port, or NULL if not found */
 extern int sepol_port_query(
 	sepol_handle_t* handle,
-	sepol_policydb_t* policydb,
-	sepol_port_key_t* key,
+	const sepol_policydb_t* policydb,
+	const sepol_port_key_t* key,
 	sepol_port_t** response);
 
 /* Modify a port, or add it, if the key is not found */
 extern int sepol_port_modify(
 	sepol_handle_t* handle,
 	sepol_policydb_t* policydb, 
-	sepol_port_key_t* key,
-	sepol_port_t* data);
+	const sepol_port_key_t* key,
+	const sepol_port_t* data);
 
 /* Iterate the ports 
  * The handler may return:
@@ -40,9 +40,9 @@ extern int sepol_port_modify(
 
 extern int sepol_port_iterate(
 	sepol_handle_t* handle,
-	sepol_policydb_t* policydb,
+	const sepol_policydb_t* policydb,
 	int (*fn)(
-		sepol_port_t* port,
+		const sepol_port_t* port,
 		void* fn_arg),
 	void* arg);
 
diff -Naurp --exclude libsemanage --exclude-from excludes old/libsepol/include/sepol/roles.h new/libsepol/include/sepol/roles.h
--- old/libsepol/include/sepol/roles.h	2005-10-21 09:54:18.000000000 -0400
+++ new/libsepol/include/sepol/roles.h	2006-01-05 12:10:36.000000000 -0500
@@ -2,12 +2,12 @@
 #define _SEPOL_ROLES_H_
 
 extern int sepol_role_exists(
-	sepol_policydb_t* policydb,
+	const sepol_policydb_t* policydb,
 	const char* role,
 	int* response);
 
 extern int sepol_role_list(
-	sepol_policydb_t* policydb,
+	const sepol_policydb_t* policydb,
 	char*** roles,
 	size_t* nroles);
 
diff -Naurp --exclude libsemanage --exclude-from excludes old/libsepol/include/sepol/user_record.h new/libsepol/include/sepol/user_record.h
--- old/libsepol/include/sepol/user_record.h	2005-12-05 15:00:29.000000000 -0500
+++ new/libsepol/include/sepol/user_record.h	2006-01-05 12:41:56.000000000 -0500
@@ -16,24 +16,24 @@ extern int sepol_user_key_create(
 	sepol_user_key_t** key);
 
 extern void sepol_user_key_unpack(
-	sepol_user_key_t* key,
+	const sepol_user_key_t* key,
 	const char** name);
 
 extern int sepol_user_key_extract(
 	sepol_handle_t* handle,
-	sepol_user_t* user,
+	const sepol_user_t* user,
 	sepol_user_key_t** key_ptr);
 
 extern void sepol_user_key_free(
 	sepol_user_key_t* key);
 
 extern int sepol_user_compare(
-	sepol_user_t* user,
-	sepol_user_key_t* key);
+	const sepol_user_t* user,
+	const sepol_user_key_t* key);
 	
 /* Name */
 extern const char* sepol_user_get_name(
-	sepol_user_t* user);
+	const sepol_user_t* user);
 
 extern int sepol_user_set_name(
 	sepol_handle_t* handle,
@@ -42,7 +42,7 @@ extern int sepol_user_set_name(
 
 /* MLS */
 extern const char* sepol_user_get_mlslevel(
-	sepol_user_t* user);
+	const sepol_user_t* user);
 
 extern int sepol_user_set_mlslevel(
 	sepol_handle_t* handle,
@@ -50,7 +50,7 @@ extern int sepol_user_set_mlslevel(
 	const char* mls_level);
 
 extern const char* sepol_user_get_mlsrange(
-	sepol_user_t* user);
+	const sepol_user_t* user);
 
 extern int sepol_user_set_mlsrange(
 	sepol_handle_t* handle,
@@ -59,7 +59,7 @@ extern int sepol_user_set_mlsrange(
 
 /* Role management */
 extern int sepol_user_get_num_roles(
-	sepol_user_t* user);
+	const sepol_user_t* user);
 
 extern int sepol_user_add_role(
 	sepol_handle_t* handle,
@@ -71,12 +71,12 @@ extern void sepol_user_del_role(
 	const char* role);
 
 extern int sepol_user_has_role(
-	sepol_user_t* user, 
+	const sepol_user_t* user, 
 	const char* role);
 
 extern int sepol_user_get_roles(
 	sepol_handle_t* handle,
-	sepol_user_t* user,
+	const sepol_user_t* user,
 	const char*** roles_arr, 
 	size_t* num_roles);
 
@@ -93,7 +93,7 @@ extern int sepol_user_create(
 
 extern int sepol_user_clone(
 	sepol_handle_t* handle,
-	sepol_user_t* user, 
+	const sepol_user_t* user, 
 	sepol_user_t** user_ptr);
 
 extern void sepol_user_free(
diff -Naurp --exclude libsemanage --exclude-from excludes old/libsepol/include/sepol/users.h new/libsepol/include/sepol/users.h
--- old/libsepol/include/sepol/users.h	2005-10-27 17:39:08.000000000 -0400
+++ new/libsepol/include/sepol/users.h	2006-01-05 12:50:10.000000000 -0500
@@ -28,27 +28,27 @@ extern void sepol_set_delusers(int on);
 extern int sepol_user_modify(
 	sepol_handle_t* handle,
 	sepol_policydb_t* policydb, 
-	sepol_user_key_t* key,
-	sepol_user_t* data);
+	const sepol_user_key_t* key,
+	const sepol_user_t* data);
 
 /* Return the number of users */
 extern int sepol_user_count(
 	sepol_handle_t* handle,
-	sepol_policydb_t* p,
+	const sepol_policydb_t* p,
 	unsigned int* response);
 
 /* Check if the specified user exists */
 extern int sepol_user_exists(
 	sepol_handle_t* handle,
-	sepol_policydb_t* policydb,
-	sepol_user_key_t* key,
+	const sepol_policydb_t* policydb,
+	const sepol_user_key_t* key,
 	int* response);
 
 /* Query a user - returns the user or NULL if not found */
 extern int sepol_user_query(
 	sepol_handle_t* handle,
-	sepol_policydb_t* p,
-	sepol_user_key_t* key,
+	const sepol_policydb_t* p,
+	const sepol_user_key_t* key,
 	sepol_user_t** response);
 
 /* Iterate the users
@@ -58,9 +58,9 @@ extern int sepol_user_query(
  * 0 to signal continue */
 extern int sepol_user_iterate(
 	sepol_handle_t* handle,
-	sepol_policydb_t* policydb,
+	const sepol_policydb_t* policydb,
 	int (*fn)(
-		sepol_user_t* user,
+		const sepol_user_t* user,
 		void* fn_arg),
 	void* arg);
 
diff -Naurp --exclude libsemanage --exclude-from excludes old/libsepol/man/man3/sepol_check_context.3 new/libsepol/man/man3/sepol_check_context.3
--- old/libsepol/man/man3/sepol_check_context.3	2005-03-17 12:52:37.000000000 -0500
+++ new/libsepol/man/man3/sepol_check_context.3	2006-01-05 13:15:48.000000000 -0500
@@ -4,7 +4,7 @@ sepol_check_context \- Check the validit
 .SH "SYNOPSIS"
 .B #include <sepol/sepol.h>
 .sp
-.BI "int sepol_check_context(char *" context ");"
+.BI "int sepol_check_context(const char *" context ");"
 .sp
 .BI "int sepol_set_policydb_from_file(FILE *" fp ");"
 
diff -Naurp --exclude libsemanage --exclude-from excludes old/libsepol/src/boolean_record.c new/libsepol/src/boolean_record.c
--- old/libsepol/src/boolean_record.c	2006-01-04 12:17:34.000000000 -0500
+++ new/libsepol/src/boolean_record.c	2006-01-05 12:45:16.000000000 -0500
@@ -40,7 +40,7 @@ int sepol_bool_key_create(
 hidden_def(sepol_bool_key_create)
 
 void sepol_bool_key_unpack(
-	sepol_bool_key_t* key,
+	const sepol_bool_key_t* key,
 	const char** name) {
 
 	*name = key->name;
@@ -49,7 +49,7 @@ hidden_def(sepol_bool_key_unpack)
 
 int sepol_bool_key_extract(
 	sepol_handle_t* handle,
-	sepol_bool_t* boolean, 
+	const sepol_bool_t* boolean, 
 	sepol_bool_key_t** key_ptr) {
 
 	if (sepol_bool_key_create(handle, boolean->name, key_ptr) < 0) {
@@ -61,19 +61,22 @@ int sepol_bool_key_extract(
 	return STATUS_SUCCESS;
 }	
 
-void sepol_bool_key_free(sepol_bool_key_t* key) {
+void sepol_bool_key_free(
+	sepol_bool_key_t* key) {
 	free(key);
 }
 
 int sepol_bool_compare(
-	sepol_bool_t* boolean,
-	sepol_bool_key_t* key) {
+	const sepol_bool_t* boolean,
+	const sepol_bool_key_t* key) {
 
 	return strcmp(boolean->name, key->name);
 }
 
 /* Name */
-const char* sepol_bool_get_name(sepol_bool_t* boolean) {
+const char* sepol_bool_get_name(
+	const sepol_bool_t* boolean) {
+
 	return boolean->name;
 }
 hidden_def(sepol_bool_get_name)
@@ -95,12 +98,17 @@ int sepol_bool_set_name(
 hidden_def(sepol_bool_set_name)
 
 /* Value */
-int sepol_bool_get_value(sepol_bool_t* boolean) {
+int sepol_bool_get_value(
+	const sepol_bool_t* boolean) {
+	
 	return boolean->value;
 }
 hidden_def(sepol_bool_get_value)
 
-void sepol_bool_set_value(sepol_bool_t* boolean, int value) {
+void sepol_bool_set_value(
+	sepol_bool_t* boolean, 
+	int value) {
+
 	boolean->value = value;
 }
 hidden_def(sepol_bool_set_value)
@@ -129,7 +137,7 @@ hidden_def(sepol_bool_create)
 /* Deep copy clone */
 int sepol_bool_clone(
 	sepol_handle_t* handle,
-	sepol_bool_t* boolean, 
+	const sepol_bool_t* boolean, 
 	sepol_bool_t** bool_ptr) {
 
 	sepol_bool_t* new_bool = NULL;
@@ -152,7 +160,9 @@ int sepol_bool_clone(
 }
 
 /* Destroy */
-void sepol_bool_free(sepol_bool_t* boolean) {
+void sepol_bool_free(
+	sepol_bool_t* boolean) {
+
 	if (!boolean)
 		return;
 	
diff -Naurp --exclude libsemanage --exclude-from excludes old/libsepol/src/booleans.c new/libsepol/src/booleans.c
--- old/libsepol/src/booleans.c	2005-11-01 17:32:58.000000000 -0500
+++ new/libsepol/src/booleans.c	2006-01-05 12:52:12.000000000 -0500
@@ -15,8 +15,8 @@
 static int bool_update (
 	sepol_handle_t* handle, 
 	policydb_t* policydb,
-	sepol_bool_key_t* key,
-	sepol_bool_t* data) {
+	const sepol_bool_key_t* key,
+	const sepol_bool_t* data) {
 
 	const char* cname;
 	char* name;
@@ -55,7 +55,7 @@ static int bool_update (
 
 static int bool_to_record (
 	sepol_handle_t* handle,
-	policydb_t* policydb,
+	const policydb_t* policydb,
 	int bool_idx,
 	sepol_bool_t** record) {
 
@@ -85,8 +85,8 @@ static int bool_to_record (
 int sepol_bool_set (
 	sepol_handle_t* handle,
 	sepol_policydb_t* p,
-	sepol_bool_key_t* key, 
-	sepol_bool_t* data) {
+	const sepol_bool_key_t* key, 
+	const sepol_bool_t* data) {
 
 	const char* name;
 	sepol_bool_key_unpack(key, &name);
@@ -109,10 +109,10 @@ int sepol_bool_set (
 
 int sepol_bool_count(
 	sepol_handle_t* handle,
-	sepol_policydb_t* p,
+	const sepol_policydb_t* p,
 	unsigned int* response) {
 
-	policydb_t* policydb = &p->p;
+	const policydb_t* policydb = &p->p;
 	*response = policydb->p_bools.nprim;
 
 	handle = NULL;
@@ -121,11 +121,11 @@ int sepol_bool_count(
 
 int sepol_bool_exists(
 	sepol_handle_t* handle,
-	sepol_policydb_t* p,
-	sepol_bool_key_t* key,
+	const sepol_policydb_t* p,
+	const sepol_bool_key_t* key,
 	int* response) {
 
-	policydb_t *policydb = &p->p;
+	const policydb_t *policydb = &p->p;
 
 	const char* cname;
 	char* name = NULL;
@@ -145,11 +145,11 @@ int sepol_bool_exists(
 
 int sepol_bool_query(
 	sepol_handle_t* handle,
-	sepol_policydb_t* p,	
-	sepol_bool_key_t* key,
+	const sepol_policydb_t* p,	
+	const sepol_bool_key_t* key,
 	sepol_bool_t** response) {
 
-	policydb_t* policydb = &p->p;
+	const policydb_t* policydb = &p->p;
 	cond_bool_datum_t* booldatum = NULL;
 
 	const char* cname;
@@ -184,13 +184,13 @@ int sepol_bool_query(
 
 int sepol_bool_iterate(
 	sepol_handle_t* handle,
-	sepol_policydb_t* p,
+	const sepol_policydb_t* p,
 	int (*fn)(
-		sepol_bool_t* boolean,
+		const sepol_bool_t* boolean,
 		void* fn_arg),
 	void* arg) {
 
-	policydb_t *policydb = &p->p;
+	const policydb_t *policydb = &p->p;
 	size_t nbools = policydb->p_bools.nprim;
 	sepol_bool_t* boolean = NULL;
 	size_t i;
diff -Naurp --exclude libsemanage --exclude-from excludes old/libsepol/src/context.c new/libsepol/src/context.c
--- old/libsepol/src/context.c	2006-01-04 12:17:34.000000000 -0500
+++ new/libsepol/src/context.c	2006-01-05 12:59:48.000000000 -0500
@@ -13,14 +13,14 @@
 
 /* ----- Compatibility ---- */
 int policydb_context_isvalid(
-	policydb_t *p, 
-	context_struct_t *c) {
+	const policydb_t *p, 
+	const context_struct_t *c) {
 
         return context_is_valid(p,c);
 }
 
 int sepol_check_context(
-	char *context) {
+	const char *context) {
 
 	return sepol_context_to_sid(context, strlen(context)+1, NULL);
 }
@@ -31,8 +31,10 @@ int sepol_check_context(
  * Return 1 if the fields in the security context
  * structure `c' are valid.  Return 0 otherwise.
  */
-int context_is_valid(policydb_t *p, context_struct_t *c)
-{
+int context_is_valid(
+	const policydb_t *p, 
+	const context_struct_t *c) {
+
 	role_datum_t *role;
 	user_datum_t *usrdatum;
 	ebitmap_t types, roles;
@@ -85,8 +87,8 @@ int context_is_valid(policydb_t *p, cont
  */
 int context_to_string(
 	sepol_handle_t* handle,
-	policydb_t* policydb,
-	context_struct_t * context,
+	const policydb_t* policydb,
+	const context_struct_t* context,
 	char **result,
 	size_t *result_len) {
 
@@ -141,9 +143,9 @@ int context_to_string(
  */
 int context_from_record(
 	sepol_handle_t* handle,
-	policydb_t* policydb, 
+	const policydb_t* policydb, 
 	context_struct_t** cptr, 
-	sepol_context_t* record) {
+	const sepol_context_t* record) {
 
 	context_struct_t* scontext = NULL;
 	user_datum_t* usrdatum;
@@ -241,8 +243,8 @@ int context_from_record(
  */
 int context_to_record(
 	sepol_handle_t* handle,
-	policydb_t* policydb,
-	context_struct_t* context,
+	const policydb_t* policydb,
+	const context_struct_t* context,
 	sepol_context_t** record) {
 
 	sepol_context_t* tmp_record = NULL;
@@ -287,7 +289,7 @@ int context_to_record(
  */
 int context_from_string(
 	sepol_handle_t* handle,
-	policydb_t* policydb,
+	const policydb_t* policydb,
 	context_struct_t** cptr,
 	const char* con_str,
 	size_t con_str_len) { 
@@ -325,8 +327,8 @@ int context_from_string(
 
 int sepol_context_check(
 	sepol_handle_t* handle,
-	sepol_policydb_t* policydb,
-	sepol_context_t* context) {
+	const sepol_policydb_t* policydb,
+	const sepol_context_t* context) {
 
 	context_struct_t* con = NULL;
 	int ret = context_from_record(handle, &policydb->p, &con, context);
diff -Naurp --exclude libsemanage --exclude-from excludes old/libsepol/src/context.h new/libsepol/src/context.h
--- old/libsepol/src/context.h	2006-01-04 12:17:34.000000000 -0500
+++ new/libsepol/src/context.h	2006-01-05 12:22:06.000000000 -0500
@@ -10,34 +10,34 @@
 /* Create a context structure from high level representation */
 extern int context_from_record(
 	sepol_handle_t* handle,
-	policydb_t* policydb,
+	const policydb_t* policydb,
 	context_struct_t** cptr,
-	sepol_context_t* data);
+	const sepol_context_t* data);
 
 extern int context_to_record(
 	sepol_handle_t* handle,
-	policydb_t* policydb,
-	context_struct_t* context,
+	const policydb_t* policydb,
+	const context_struct_t* context,
 	sepol_context_t** record);
 
 /* Create a context structure from string representation */
 extern int context_from_string(
 	sepol_handle_t* handle,
-	policydb_t* policydb,
+	const policydb_t* policydb,
 	context_struct_t** cptr,
 	const char* con_str,
 	size_t con_str_len);
 
 /* Check if the provided context is valid for this policy */
 extern int context_is_valid(
-	policydb_t* policydb,
-	context_struct_t* context);
+	const policydb_t* policydb,
+	const context_struct_t* context);
 
 /* Extract the context as string */
 extern int context_to_string(
 	sepol_handle_t* handle,
-	policydb_t* policydb,
-	context_struct_t* context,
+	const policydb_t* policydb,
+	const context_struct_t* context,
 	char ** result,
 	size_t *result_len);
 
diff -Naurp --exclude libsemanage --exclude-from excludes old/libsepol/src/context_record.c new/libsepol/src/context_record.c
--- old/libsepol/src/context_record.c	2005-11-03 12:48:03.000000000 -0500
+++ new/libsepol/src/context_record.c	2006-01-05 12:46:01.000000000 -0500
@@ -21,7 +21,9 @@ struct sepol_context {
 };
 
 /* User */
-const char* sepol_context_get_user(sepol_context_t* con) {
+const char* sepol_context_get_user(
+	const sepol_context_t* con) {
+
 	return con->user;
 }
 hidden_def(sepol_context_get_user)
@@ -45,7 +47,9 @@ int sepol_context_set_user(
 hidden_def(sepol_context_set_user)
 
 /* Role */
-const char* sepol_context_get_role(sepol_context_t* con) {
+const char* sepol_context_get_role(
+	const sepol_context_t* con) {
+
 	return con->role;
 }
 hidden_def(sepol_context_get_role)
@@ -68,7 +72,9 @@ int sepol_context_set_role(
 hidden_def(sepol_context_set_role)
 
 /* Type */
-const char* sepol_context_get_type(sepol_context_t* con) {
+const char* sepol_context_get_type(
+	const sepol_context_t* con) {
+
 	return con->type;
 }
 hidden_def(sepol_context_get_type)
@@ -91,7 +97,9 @@ int sepol_context_set_type(
 hidden_def(sepol_context_set_type)
 
 /* MLS */
-const char* sepol_context_get_mls(sepol_context_t* con) {
+const char* sepol_context_get_mls(
+	const sepol_context_t* con) {
+
 	return con->mls;
 }
 hidden_def(sepol_context_get_mls)
@@ -139,7 +147,7 @@ hidden_def(sepol_context_create)
 /* Deep copy clone */
 int sepol_context_clone(
 	sepol_handle_t* handle,
-	sepol_context_t* con,
+	const sepol_context_t* con,
 	sepol_context_t** con_ptr) {
 
 	sepol_context_t* new_con = NULL;	
@@ -172,7 +180,9 @@ int sepol_context_clone(
 hidden_def(sepol_context_clone)
 
 /* Destroy */
-void sepol_context_free(sepol_context_t* con) {
+void sepol_context_free(
+	sepol_context_t* con) {
+
 	if (!con)
 		return;
 
@@ -260,7 +270,7 @@ hidden_def(sepol_context_from_string)
 
 int sepol_context_to_string(
 	sepol_handle_t* handle,
-	sepol_context_t* con,
+	const sepol_context_t* con,
 	char** str_ptr) {
 
 	int rc;
diff -Naurp --exclude libsemanage --exclude-from excludes old/libsepol/src/iface_record.c new/libsepol/src/iface_record.c
--- old/libsepol/src/iface_record.c	2006-01-04 12:17:34.000000000 -0500
+++ new/libsepol/src/iface_record.c	2006-01-05 12:48:22.000000000 -0500
@@ -45,7 +45,7 @@ int sepol_iface_key_create(
 hidden_def(sepol_iface_key_create)
 
 void sepol_iface_key_unpack(
-	sepol_iface_key_t* key,
+	const sepol_iface_key_t* key,
 	const char** name) {
 
 	*name = key->name;	
@@ -54,7 +54,7 @@ hidden_def(sepol_iface_key_unpack)
 
 int sepol_iface_key_extract(
 	sepol_handle_t* handle,
-	sepol_iface_t* iface, 
+	const sepol_iface_t* iface, 
 	sepol_iface_key_t** key_ptr) {
 
 	if (sepol_iface_key_create(handle, iface->name, key_ptr) < 0) {
@@ -66,13 +66,14 @@ int sepol_iface_key_extract(
 	return STATUS_SUCCESS;
 }
 
-void sepol_iface_key_free(sepol_iface_key_t* key) {
+void sepol_iface_key_free(
+	sepol_iface_key_t* key) {
 	free(key);
 }
 
 int sepol_iface_compare(
-	sepol_iface_t* iface, 
-	sepol_iface_key_t* key) {
+	const sepol_iface_t* iface, 
+	const sepol_iface_key_t* key) {
 
 	return strcmp(iface->name, key->name);
 }
@@ -101,7 +102,9 @@ int sepol_iface_create(
 hidden_def(sepol_iface_create)
 
 /* Name */
-const char* sepol_iface_get_name(sepol_iface_t* iface) {
+const char* sepol_iface_get_name(
+	const sepol_iface_t* iface) {
+
 	return iface->name;
 }
 hidden_def(sepol_iface_get_name)
@@ -124,7 +127,9 @@ int sepol_iface_set_name(
 hidden_def(sepol_iface_set_name)
 
 /* Interface Context */
-sepol_context_t* sepol_iface_get_ifcon(sepol_iface_t* iface) {
+sepol_context_t* sepol_iface_get_ifcon(
+	const sepol_iface_t* iface) {
+
 	return iface->netif_con;
 }
 hidden_def(sepol_iface_get_ifcon)
@@ -139,7 +144,9 @@ void sepol_iface_set_ifcon(
 hidden_def(sepol_iface_set_ifcon)
 
 /* Message Context */
-sepol_context_t* sepol_iface_get_msgcon(sepol_iface_t* iface) {
+sepol_context_t* sepol_iface_get_msgcon(
+	const sepol_iface_t* iface) {
+
 	return iface->netmsg_con;
 }
 hidden_def(sepol_iface_get_msgcon)
@@ -156,7 +163,7 @@ hidden_def(sepol_iface_set_msgcon)
 /* Deep copy clone */
 int sepol_iface_clone(
 	sepol_handle_t* handle,
-	sepol_iface_t* iface, 
+	const sepol_iface_t* iface, 
 	sepol_iface_t** iface_ptr) {
 
 	sepol_iface_t* new_iface = NULL;
@@ -184,7 +191,9 @@ int sepol_iface_clone(
 }
 
 /* Destroy */
-void sepol_iface_free(sepol_iface_t* iface) {
+void sepol_iface_free(
+	sepol_iface_t* iface) {
+
 	if (!iface)
 		return;
 
diff -Naurp --exclude libsemanage --exclude-from excludes old/libsepol/src/interfaces.c new/libsepol/src/interfaces.c
--- old/libsepol/src/interfaces.c	2006-01-05 08:25:16.000000000 -0500
+++ new/libsepol/src/interfaces.c	2006-01-05 12:51:23.000000000 -0500
@@ -11,9 +11,9 @@
 /* Create a low level structure from record */
 static int iface_from_record (
 	sepol_handle_t* handle,
-	policydb_t* policydb,
+	const policydb_t* policydb,
 	ocontext_t** iface,
-	sepol_iface_t* record) {
+	const sepol_iface_t* record) {
 
 	ocontext_t* tmp_iface = NULL;
 	context_struct_t* tmp_con = NULL;
@@ -66,7 +66,7 @@ static int iface_from_record (
 
 static int iface_to_record (
 	sepol_handle_t* handle,
-	policydb_t* policydb,
+	const policydb_t* policydb,
 	ocontext_t* iface,
         sepol_iface_t** record) {
 
@@ -106,11 +106,11 @@ static int iface_to_record (
 /* Check if an interface exists */
 int sepol_iface_exists (
 	sepol_handle_t* handle,
-	sepol_policydb_t* p,
-	sepol_iface_key_t* key,
+	const sepol_policydb_t* p,
+	const sepol_iface_key_t* key,
 	int* response) {
 
-	policydb_t *policydb = &p->p;
+	const policydb_t *policydb = &p->p;
 	ocontext_t *c, *head;
 
 	const char* name;
@@ -132,11 +132,11 @@ int sepol_iface_exists (
 /* Query an interface */
 int sepol_iface_query (
 	sepol_handle_t* handle,
-	sepol_policydb_t* p,
-	sepol_iface_key_t* key,
+	const sepol_policydb_t* p,
+	const sepol_iface_key_t* key,
 	sepol_iface_t** response) {
 
-	policydb_t *policydb = &p->p;
+	const policydb_t *policydb = &p->p;
 	ocontext_t *c, *head;
 
 	const char* name;
@@ -165,8 +165,8 @@ int sepol_iface_query (
 int sepol_iface_modify(
 	sepol_handle_t* handle,
 	sepol_policydb_t* p,
-	sepol_iface_key_t* key, 
-	sepol_iface_t* data) {
+	const sepol_iface_key_t* key, 
+	const sepol_iface_t* data) {
 
 	policydb_t *policydb = &p->p;
 	ocontext_t *head, *prev, *c, *iface = NULL;
@@ -218,12 +218,12 @@ int sepol_iface_modify(
 /* Return the number of interfaces */
 extern int sepol_iface_count(
 	sepol_handle_t* handle,
-	sepol_policydb_t* p,
+	const sepol_policydb_t* p,
 	unsigned int* response) {
 
 	unsigned int count = 0;
 	ocontext_t *c, *head;
-	policydb_t* policydb = &p->p;
+	const policydb_t* policydb = &p->p;
 
 	head = policydb->ocontexts[OCON_NETIF];
 	for (c =  head; c != NULL; c = c->next) 
@@ -237,13 +237,13 @@ extern int sepol_iface_count(
 
 int sepol_iface_iterate(
 	sepol_handle_t* handle,
-	sepol_policydb_t* p,
+	const sepol_policydb_t* p,
 	int (*fn)(
-		sepol_iface_t* iface,
+		const sepol_iface_t* iface,
 		void* fn_arg),
 	void* arg) {
 
-	policydb_t *policydb = &p->p;
+	const policydb_t *policydb = &p->p;
 	ocontext_t *c, *l, *head;
 	sepol_iface_t* iface = NULL;
 
diff -Naurp --exclude libsemanage --exclude-from excludes old/libsepol/src/mls.c new/libsepol/src/mls.c
--- old/libsepol/src/mls.c	2006-01-04 12:17:34.000000000 -0500
+++ new/libsepol/src/mls.c	2006-01-05 13:01:58.000000000 -0500
@@ -41,8 +41,8 @@
 
 int mls_to_string(
 	sepol_handle_t* handle,
-	policydb_t* policydb, 
-	context_struct_t* mls, 
+	const policydb_t* policydb, 
+	const context_struct_t* mls, 
 	char** str) {
 
 	char *ptr = NULL, *ptr2 = NULL;
@@ -78,7 +78,7 @@ int mls_to_string(
 
 int mls_from_string(
 	sepol_handle_t* handle,
-	policydb_t* policydb, 
+	const policydb_t* policydb, 
 	const char* str, 
 	context_struct_t* mls) {
 
@@ -108,8 +108,10 @@ int mls_from_string(
  * Return the length in bytes for the MLS fields of the
  * security context string representation of `context'.
  */
-int mls_compute_context_len(policydb_t *policydb, context_struct_t * context)
-{
+int mls_compute_context_len(
+	const policydb_t *policydb, 
+	const context_struct_t * context) {
+
 	unsigned int i, l, len, range;
 	ebitmap_node_t *cnode;
 
@@ -158,10 +160,11 @@ int mls_compute_context_len(policydb_t *
  * the MLS fields of `context' into the string `*scontext'.
  * Update `*scontext' to point to the end of the MLS fields.
  */
-void mls_sid_to_context(policydb_t *policydb,
-                        context_struct_t * context,
-                        char **scontext)
-{
+void mls_sid_to_context(
+	const policydb_t *policydb,
+	const context_struct_t * context,
+	char **scontext) {
+
 	char *scontextp;
 	unsigned int i, l, range, wrote_sep;
 	ebitmap_node_t *cnode;
@@ -239,8 +242,10 @@ void mls_sid_to_context(policydb_t *poli
  * Return 1 if the MLS fields in the security context
  * structure `c' are valid.  Return 0 otherwise.
  */
-int mls_context_isvalid(policydb_t *p, context_struct_t * c)
-{
+int mls_context_isvalid(
+	const policydb_t *p, 
+	const context_struct_t * c) {
+
 	level_datum_t *levdatum;
 	user_datum_t *usrdatum;
 	unsigned int i, l;
@@ -306,7 +311,7 @@ int mls_context_isvalid(policydb_t *p, c
  * NULL characters to terminate the MLS fields.
  */
 int mls_context_to_sid(
-	policydb_t *policydb,
+	const policydb_t *policydb,
 	char oldc,
 	char **scontext,
 	context_struct_t * context) {
diff -Naurp --exclude libsemanage --exclude-from excludes old/libsepol/src/mls.h new/libsepol/src/mls.h
--- old/libsepol/src/mls.h	2005-11-15 08:06:55.000000000 -0500
+++ new/libsepol/src/mls.h	2006-01-05 13:02:05.000000000 -0500
@@ -29,38 +29,37 @@
 
 extern int mls_from_string(
 	sepol_handle_t* handle,
-	policydb_t* policydb,
+	const policydb_t* policydb,
 	const char* str,
 	context_struct_t* mls);
 
 extern int mls_to_string(
         sepol_handle_t* handle,
-        policydb_t* policydb,
-        context_struct_t* mls,
+        const policydb_t* policydb,
+        const context_struct_t* mls,
         char** str);
 
 /* Deprecated */
 extern int mls_compute_context_len(
-	policydb_t *policydb,
-	context_struct_t * context);
-
+	const policydb_t *policydb,
+	const context_struct_t * context);
 
 /* Deprecated */
 extern void mls_sid_to_context(
-	policydb_t *policydb,
-	context_struct_t *context,
+	const policydb_t *policydb,
+	const context_struct_t *context,
 	char **scontext);
 
 /* Deprecated */
 extern int mls_context_to_sid(
-	policydb_t *policydb,
+	const policydb_t *policydb,
 	char oldc,
 	char **scontext,
 	context_struct_t *context);
 
 extern int mls_context_isvalid(
-	policydb_t *p, 
-	context_struct_t * c);
+	const policydb_t *p, 
+	const context_struct_t * c);
 
 extern int mls_convert_context(
 	policydb_t * oldp,
diff -Naurp --exclude libsemanage --exclude-from excludes old/libsepol/src/port_record.c new/libsepol/src/port_record.c
--- old/libsepol/src/port_record.c	2006-01-05 08:25:16.000000000 -0500
+++ new/libsepol/src/port_record.c	2006-01-05 12:47:27.000000000 -0500
@@ -49,7 +49,7 @@ int sepol_port_key_create(
 hidden_def(sepol_port_key_create)
 
 void sepol_port_key_unpack(
-	sepol_port_key_t* key,
+	const sepol_port_key_t* key,
 	int* low, int* high, int* proto) {
 
 	*low = key->low;
@@ -60,7 +60,7 @@ hidden_def(sepol_port_key_unpack)
 
 int sepol_port_key_extract(
 	sepol_handle_t* handle,	
-	sepol_port_t* port, 
+	const sepol_port_t* port, 
 	sepol_port_key_t** key_ptr) {
 
 	if (sepol_port_key_create(
@@ -76,13 +76,14 @@ int sepol_port_key_extract(
 	return STATUS_SUCCESS;
 }
 
-void sepol_port_key_free(sepol_port_key_t* key) {
+void sepol_port_key_free(
+	sepol_port_key_t* key) {
 	free(key);
 }
 
 int sepol_port_compare(
-	sepol_port_t* port, 
-	sepol_port_key_t* key) {
+	const sepol_port_t* port, 
+	const sepol_port_key_t* key) {
 
 	if ((port->low == key->low) && 
 	    (port->high == key->high) &&
@@ -109,35 +110,48 @@ int sepol_port_compare(
 }
 
 /* Port */
-int sepol_port_get_low(sepol_port_t* port) {
+int sepol_port_get_low(
+	const sepol_port_t* port) {
+
 	return port->low;
 }
 hidden_def(sepol_port_get_low)
 
-int sepol_port_get_high(sepol_port_t* port) {
+int sepol_port_get_high(
+	const sepol_port_t* port) {
+	
 	return port->high;
 }
 hidden_def(sepol_port_get_high)
 
-void sepol_port_set_port(sepol_port_t* port, int port_num) {
+void sepol_port_set_port(
+	sepol_port_t* port, 
+	int port_num) {
+
 	port->low = port_num;
 	port->high = port_num;
 }
 
-void sepol_port_set_range(sepol_port_t* port, int low, int high) {
+void sepol_port_set_range(
+	sepol_port_t* port, 
+	int low, int high) {
+
 	port->low = low;
 	port->high = high;
 }
 hidden_def(sepol_port_set_range)
 
 /* Protocol */
-int sepol_port_get_proto(sepol_port_t* port) {
+int sepol_port_get_proto(
+	const sepol_port_t* port) {
 
 	return port->proto;
 }
 hidden_def(sepol_port_get_proto)
 
-const char* sepol_port_get_proto_str(sepol_port_t* port) {
+const char* sepol_port_get_proto_str(
+	const sepol_port_t* port) {
+
 	switch (port->proto) {
 		case SEPOL_PROTO_UDP:
 			return "udp";
@@ -184,7 +198,7 @@ hidden_def(sepol_port_create)
 /* Deep copy clone */
 int sepol_port_clone(
 	sepol_handle_t* handle,
-	sepol_port_t* port, 
+	const sepol_port_t* port, 
 	sepol_port_t** port_ptr) {
 
 	sepol_port_t* new_port = NULL;
@@ -209,7 +223,9 @@ int sepol_port_clone(
 }
 
 /* Destroy */
-void sepol_port_free(sepol_port_t* port) {
+void sepol_port_free(
+	sepol_port_t* port) {
+
 	if (!port)
 		return;
 	
@@ -219,12 +235,17 @@ void sepol_port_free(sepol_port_t* port)
 hidden_def(sepol_port_free)
 
 /* Context */
-sepol_context_t* sepol_port_get_con(sepol_port_t* port) {
+sepol_context_t* sepol_port_get_con(
+	const sepol_port_t* port) {
+
 	return port->con;
 }
 hidden_def(sepol_port_get_con)
 
-void sepol_port_set_con(sepol_port_t* port, sepol_context_t* con) {
+void sepol_port_set_con(
+	sepol_port_t* port, 
+	sepol_context_t* con) {
+
 	sepol_context_free(port->con);
 	port->con = con;
 }
diff -Naurp --exclude libsemanage --exclude-from excludes old/libsepol/src/ports.c new/libsepol/src/ports.c
--- old/libsepol/src/ports.c	2006-01-05 08:56:56.000000000 -0500
+++ new/libsepol/src/ports.c	2006-01-05 12:51:13.000000000 -0500
@@ -43,9 +43,9 @@ static inline int ipproto2sepol(
  * a high level representation */
 static int port_from_record(
 	sepol_handle_t* handle,
-	policydb_t* policydb,
+	const policydb_t* policydb,
 	ocontext_t** port,
-	sepol_port_t* data) {
+	const sepol_port_t* data) {
 
 	ocontext_t* tmp_port = NULL;
 	context_struct_t* tmp_con = NULL;
@@ -99,7 +99,7 @@ static int port_from_record(
 
 static int port_to_record (
 	sepol_handle_t* handle,
-	policydb_t* policydb,
+	const policydb_t* policydb,
 	ocontext_t* port,
 	sepol_port_t** record) {
 
@@ -143,12 +143,12 @@ static int port_to_record (
 /* Return the number of ports */
 extern int sepol_port_count(
 	sepol_handle_t* handle,
-	sepol_policydb_t* p,
+	const sepol_policydb_t* p,
 	unsigned int* response) {
 
 	unsigned int count = 0;
 	ocontext_t *c, *head;
-	policydb_t* policydb = &p->p;
+	const policydb_t* policydb = &p->p;
 
 	head = policydb->ocontexts[OCON_PORT];
 	for (c =  head; c != NULL; c = c->next)
@@ -163,11 +163,11 @@ extern int sepol_port_count(
 /* Check if a port exists */
 int sepol_port_exists (
 	sepol_handle_t* handle,
-	sepol_policydb_t* p,
-	sepol_port_key_t* key,
+	const sepol_policydb_t* p,
+	const sepol_port_key_t* key,
 	int* response) {
 
-	policydb_t *policydb = &p->p;
+	const policydb_t *policydb = &p->p;
 	ocontext_t *c, *head;
 
 	int low, high, proto;
@@ -201,11 +201,11 @@ int sepol_port_exists (
 /* Query a port */
 int sepol_port_query(
 	sepol_handle_t* handle,
-	sepol_policydb_t* p,
-	sepol_port_key_t* key,
+	const sepol_policydb_t* p,
+	const sepol_port_key_t* key,
 	sepol_port_t** response) {
 
-	policydb_t *policydb = &p->p;
+	const policydb_t *policydb = &p->p;
 	ocontext_t *c, *l, *head;
 
 	int low, high, proto;
@@ -242,8 +242,8 @@ int sepol_port_query(
 int sepol_port_modify(
 	sepol_handle_t* handle,
 	sepol_policydb_t* p, 
-	sepol_port_key_t* key,
-	sepol_port_t* data) {
+	const sepol_port_key_t* key,
+	const sepol_port_t* data) {
 
 	policydb_t *policydb = &p->p;
 	ocontext_t *c, *head, *prev = NULL, *port = NULL;
@@ -298,13 +298,13 @@ int sepol_port_modify(
 
 int sepol_port_iterate(
 	sepol_handle_t* handle,
-	sepol_policydb_t* p,
+	const sepol_policydb_t* p,
 	int (*fn)(
-		sepol_port_t* port,
+		const sepol_port_t* port,
 		void* fn_arg),
 	void* arg) {
 
-	policydb_t *policydb = &p->p;
+	const policydb_t *policydb = &p->p;
 	ocontext_t *c, *l, *head;
 	sepol_port_t* port = NULL;	
 
diff -Naurp --exclude libsemanage --exclude-from excludes old/libsepol/src/services.c new/libsepol/src/services.c
--- old/libsepol/src/services.c	2006-01-04 12:17:34.000000000 -0500
+++ new/libsepol/src/services.c	2006-01-05 13:12:11.000000000 -0500
@@ -530,10 +530,11 @@ out:
  * Return a SID associated with the security context that
  * has the string representation specified by `scontext'.
  */
-int hidden sepol_context_to_sid(sepol_security_context_t scontext,
-			    size_t scontext_len,
-			    sepol_security_id_t * sid)
-{
+int hidden sepol_context_to_sid(
+	const sepol_security_context_t scontext,
+	size_t scontext_len,
+	sepol_security_id_t * sid) {
+
 	context_struct_t* context = NULL;
 
 	/* First, create the context */
diff -Naurp --exclude libsemanage --exclude-from excludes old/libsepol/src/user_record.c new/libsepol/src/user_record.c
--- old/libsepol/src/user_record.c	2006-01-04 12:17:34.000000000 -0500
+++ new/libsepol/src/user_record.c	2006-01-05 12:49:37.000000000 -0500
@@ -50,7 +50,7 @@ int sepol_user_key_create(
 hidden_def(sepol_user_key_create)
 
 void sepol_user_key_unpack(
-	sepol_user_key_t* key,
+	const sepol_user_key_t* key,
 	const char** name) {
 
 	*name = key->name;
@@ -59,7 +59,7 @@ hidden_def(sepol_user_key_unpack)
 
 int sepol_user_key_extract(
 	sepol_handle_t* handle,
-	sepol_user_t* user, 
+	const sepol_user_t* user, 
 	sepol_user_key_t** key_ptr) {
 
 	if (sepol_user_key_create(handle, user->name, key_ptr) < 0) {
@@ -71,19 +71,22 @@ int sepol_user_key_extract(
 	return STATUS_SUCCESS;
 }	
 
-void sepol_user_key_free(sepol_user_key_t* key) {
+void sepol_user_key_free(
+	sepol_user_key_t* key) {
 	free(key);
 }
 
 int sepol_user_compare(
-	sepol_user_t* user,
-	sepol_user_key_t* key) {
+	const sepol_user_t* user,
+	const sepol_user_key_t* key) {
 
 	return strcmp(user->name, key->name);
 }
 
 /* Name */
-const char* sepol_user_get_name(sepol_user_t* user) {
+const char* sepol_user_get_name(
+	const sepol_user_t* user) {
+
 	return user->name;
 }
 
@@ -104,7 +107,9 @@ int sepol_user_set_name(
 hidden_def(sepol_user_set_name)
 
 /* MLS */
-const char* sepol_user_get_mlslevel(sepol_user_t* user) {
+const char* sepol_user_get_mlslevel(
+	const sepol_user_t* user) {
+
 	return user->mls_level;
 }
 hidden_def(sepol_user_get_mlslevel)
@@ -126,7 +131,9 @@ int sepol_user_set_mlslevel(
 }
 hidden_def(sepol_user_set_mlslevel)
 
-const char* sepol_user_get_mlsrange(sepol_user_t* user) {
+const char* sepol_user_get_mlsrange(
+	const sepol_user_t* user) {
+
 	return user->mls_range;
 }
 hidden_def(sepol_user_get_mlsrange)
@@ -149,7 +156,9 @@ int sepol_user_set_mlsrange(
 hidden_def(sepol_user_set_mlsrange)
 
 /* Roles */
-int sepol_user_get_num_roles(sepol_user_t* user) {
+int sepol_user_get_num_roles(
+	const sepol_user_t* user) {
+
 	return user->num_roles;
 }
 
@@ -185,7 +194,10 @@ int sepol_user_add_role(
 }
 hidden_def(sepol_user_add_role)
 
-int sepol_user_has_role(sepol_user_t* user, const char* role) {
+int sepol_user_has_role(
+	const sepol_user_t* user, 
+	const char* role) {
+
 	size_t i;
 
 	for (i = 0; i < user->num_roles; i++)
@@ -243,7 +255,7 @@ int sepol_user_set_roles(
 
 int sepol_user_get_roles(
 	sepol_handle_t* handle,
-	sepol_user_t* user, 
+	const sepol_user_t* user, 
 	const char*** roles_arr, 
 	size_t* num_roles) {
 
@@ -310,7 +322,7 @@ hidden_def(sepol_user_create)
 /* Deep copy clone */
 int sepol_user_clone(
 	sepol_handle_t* handle,
-	sepol_user_t* user, 
+	const sepol_user_t* user, 
 	sepol_user_t** user_ptr) {
 
 	sepol_user_t* new_user = NULL;
@@ -345,7 +357,9 @@ int sepol_user_clone(
 }
 
 /* Destroy */
-void sepol_user_free(sepol_user_t* user) {
+void sepol_user_free(
+	sepol_user_t* user) {
+
 	size_t i;
 
 	if (!user)
diff -Naurp --exclude libsemanage --exclude-from excludes old/libsepol/src/users.c new/libsepol/src/users.c
--- old/libsepol/src/users.c	2005-11-15 08:06:56.000000000 -0500
+++ new/libsepol/src/users.c	2006-01-05 12:37:53.000000000 -0500
@@ -13,7 +13,7 @@
 
 static int user_to_record (
 	sepol_handle_t* handle,
-	policydb_t* policydb,
+	const policydb_t* policydb,
 	int user_idx,
 	sepol_user_t** record) {
 
@@ -101,10 +101,10 @@ static int user_to_record (
 int sepol_user_modify(
 	sepol_handle_t* handle,
 	sepol_policydb_t* p, 
-	sepol_user_key_t* key,
-	sepol_user_t* user) {
+	const sepol_user_key_t* key,
+	const sepol_user_t* user) {
 
-	policydb_t *policydb = &p->p;
+	policydb_t* policydb = &p->p;
 
 	/* For user data */	
 	const char *cname, *cmls_level, *cmls_range;
@@ -291,11 +291,11 @@ int sepol_user_modify(
 
 int sepol_user_exists(
 	sepol_handle_t* handle,
-	sepol_policydb_t* p, 
-	sepol_user_key_t* key,
+	const sepol_policydb_t* p, 
+	const sepol_user_key_t* key,
 	int* response) {
 
-	policydb_t *policydb = &p->p;
+	const policydb_t* policydb = &p->p;
 
 	const char* cname;	
 	char* name = NULL;
@@ -314,10 +314,10 @@ int sepol_user_exists(
 
 int sepol_user_count(
 	sepol_handle_t* handle,
-	sepol_policydb_t* p,
+	const sepol_policydb_t* p,
 	unsigned int* response) {
 
-	policydb_t* policydb = &p->p;
+	const policydb_t* policydb = &p->p;
 	*response = policydb->p_users.nprim;
 
 	handle = NULL;
@@ -326,11 +326,11 @@ int sepol_user_count(
 
 int sepol_user_query(
 	sepol_handle_t* handle,
-	sepol_policydb_t* p,
-	sepol_user_key_t* key,
+	const sepol_policydb_t* p,
+	const sepol_user_key_t* key,
 	sepol_user_t** response) {
 
-	policydb_t* policydb = &p->p;
+	const policydb_t* policydb = &p->p;
 	user_datum_t* usrdatum = NULL;
 
 	const char* cname;
@@ -367,13 +367,13 @@ int sepol_user_query(
 
 int sepol_user_iterate(
 	sepol_handle_t* handle,
-	sepol_policydb_t* p, 
+	const sepol_policydb_t* p, 
 	int (*fn)(
-		sepol_user_t* user,
+		const sepol_user_t* user,
 		void* fn_arg),
 	void* arg) {
 
-	policydb_t *policydb = &p->p;
+	const policydb_t* policydb = &p->p;
 	size_t nusers = policydb->p_users.nprim;
 	sepol_user_t* user = NULL;
 	size_t i;

--------------020907060106050608020202--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
