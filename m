Message-ID: <435D4BD9.1040207@cornell.edu>
Date: Mon, 24 Oct 2005 17:02:17 -0400
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov, Stephen Smalley <sds@tycho.nsa.gov>
Subject: [ SEPOL ] Users/booleans - add some missing functions
Content-Type: multipart/mixed;
 boundary="------------030301040704050208000009"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------030301040704050208000009
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

- Implement users query()
- Implement booleans query()
- Implement booleans exists()

- Change ports and interface query() to set response to NULL, and return 
STATUS_SUCCESS if not found, instead of STATUS_NODATA (I'll only use 
this code in special situations - here this is expected behavior).

Passes valgrind.

--------------030301040704050208000009
Content-Type: text/x-patch;
 name="libsepol.query_exists.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libsepol.query_exists.diff"

diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude direct_api.c --exclude semanage_store.c --exclude libsemanage.map --exclude 'module_record*' --exclude 'database_directory*' --exclude Makefile old/libsepol/include/sepol/booleans.h new/libsepol/include/sepol/booleans.h
--- old/libsepol/include/sepol/booleans.h	2005-10-24 12:30:31.000000000 -0400
+++ new/libsepol/include/sepol/booleans.h	2005-10-24 16:58:34.000000000 -0400
@@ -27,12 +27,24 @@ extern int sepol_genbools_array(
 	int nel);
 /*---------------end compatbility------------*/
 
-/* Load a boolean into the policy */
+/* Set the specified boolean */
 extern int sepol_bool_set (
 	sepol_policydb_t* policydb, 
 	sepol_bool_key_t* key,
 	sepol_bool_t* data);
 
+/* Check if the specified boolean exists */
+extern int sepol_bool_exists(
+	sepol_policydb_t* policydb,
+	sepol_bool_key_t* key,
+	int* response);
+
+/* Query a boolean - returns the boolean, or NULL if not found */
+extern int sepol_bool_query(
+	sepol_policydb_t* p,
+	sepol_bool_key_t* key,
+	sepol_bool_t** response);
+
 /* Iterate the booleans
  * The handler may return:
  * -1 to signal an error condition,
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude direct_api.c --exclude semanage_store.c --exclude libsemanage.map --exclude 'module_record*' --exclude 'database_directory*' --exclude Makefile old/libsepol/include/sepol/interfaces.h new/libsepol/include/sepol/interfaces.h
--- old/libsepol/include/sepol/interfaces.h	2005-10-24 12:30:31.000000000 -0400
+++ new/libsepol/include/sepol/interfaces.h	2005-10-24 16:57:11.000000000 -0400
@@ -11,13 +11,15 @@ extern int sepol_iface_exists(
 	sepol_iface_key_t* key,
 	int* response);
 
-/* Query an interface */
+/* Query an interface - returns the interface, 
+ * or NULL if not found */
 extern int sepol_iface_query(
 	sepol_policydb_t* policydb,
 	sepol_iface_key_t* key,
 	sepol_iface_t** response);
 
-/* Add an interface to policy */
+/* Modify an interface, or add it, if the key
+ * is not found */
 extern int sepol_iface_modify(
 	sepol_policydb_t* policydb,
 	sepol_iface_key_t* key,
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude direct_api.c --exclude semanage_store.c --exclude libsemanage.map --exclude 'module_record*' --exclude 'database_directory*' --exclude Makefile old/libsepol/include/sepol/ports.h new/libsepol/include/sepol/ports.h
--- old/libsepol/include/sepol/ports.h	2005-10-24 12:30:31.000000000 -0400
+++ new/libsepol/include/sepol/ports.h	2005-10-24 16:57:20.000000000 -0400
@@ -11,13 +11,13 @@ extern int sepol_port_exists(
 	sepol_port_key_t* key,
 	int* response);
 
-/* Query a port */
+/* Query a port - returns the port, or NULL if not found */
 extern int sepol_port_query(
 	sepol_policydb_t* policydb,
 	sepol_port_key_t* key,
 	sepol_port_t** response);
 
-/* Modify a port into policy */
+/* Modify a port, or add it, if the key is not found */
 extern int sepol_port_modify(
 	sepol_policydb_t* policydb, 
 	sepol_port_key_t* key,
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude direct_api.c --exclude semanage_store.c --exclude libsemanage.map --exclude 'module_record*' --exclude 'database_directory*' --exclude Makefile old/libsepol/include/sepol/users.h new/libsepol/include/sepol/users.h
--- old/libsepol/include/sepol/users.h	2005-10-24 12:30:31.000000000 -0400
+++ new/libsepol/include/sepol/users.h	2005-10-24 16:57:52.000000000 -0400
@@ -23,7 +23,7 @@ extern void sepol_set_delusers(int on);
 
 /*--------end compatibility----------*/
 
-/* Add the user if missing, or modify otherwise */
+/* Modify the user, or add it, if the key is not found */
 extern int sepol_user_modify(
 	sepol_policydb_t* policydb, 
 	sepol_user_key_t* key,
@@ -35,6 +35,12 @@ extern int sepol_user_exists(
 	sepol_user_key_t* key,
 	int* response);
 
+/* Query a user - returns the user or NULL if not found */
+extern int sepol_user_query(
+	sepol_policydb_t* p,
+	sepol_user_key_t* key,
+	sepol_user_t** response);
+
 /* Iterate the users
  * The handler may return:
  * -1 to signal an error condition,
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude direct_api.c --exclude semanage_store.c --exclude libsemanage.map --exclude 'module_record*' --exclude 'database_directory*' --exclude Makefile old/libsepol/src/booleans.c new/libsepol/src/booleans.c
--- old/libsepol/src/booleans.c	2005-10-24 12:32:51.000000000 -0400
+++ new/libsepol/src/booleans.c	2005-10-24 16:54:26.000000000 -0400
@@ -102,6 +102,64 @@ int sepol_bool_set (
 	return STATUS_ERR;
 }
 
+int sepol_bool_exists(
+	sepol_policydb_t* p,
+	sepol_bool_key_t* key,
+	int* response) {
+
+	policydb_t *policydb = &p->p;
+
+	const char* cname;
+	char* name = NULL;
+	sepol_bool_key_unpack(key, &cname);
+	name = strdup(cname);
+
+	if (!name) {
+		/* FIXME: handle error */
+		return STATUS_ERR;
+	}
+
+	*response = (hashtab_search(policydb->p_bools.table, name) != NULL);
+	free(name);
+	return STATUS_SUCCESS;
+}
+
+int sepol_bool_query(
+	sepol_policydb_t* p,	
+	sepol_bool_key_t* key,
+	sepol_bool_t** response) {
+
+	policydb_t* policydb = &p->p;
+	cond_bool_datum_t* booldatum = NULL;
+
+	const char* cname;
+	char* name = NULL;
+	sepol_bool_key_unpack(key, &cname);
+	name = strdup(cname);
+
+	if (!name) {
+		/* FIXME: handle error */
+		goto err;
+	}
+
+	booldatum = hashtab_search(policydb->p_bools.table, name);
+	if (!booldatum) {
+		*response = NULL;
+		return STATUS_SUCCESS;
+	}
+
+	if (bool_to_record(policydb, booldatum->value - 1, response) < 0)
+		goto err;
+
+	free(name);
+	return STATUS_SUCCESS;
+
+	err:
+	/* FIXME: handle error */
+	free(name);
+	return STATUS_ERR;
+}
+
 int sepol_bool_iterate(
 	sepol_policydb_t* p,
 	int (*fn)(
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude direct_api.c --exclude semanage_store.c --exclude libsemanage.map --exclude 'module_record*' --exclude 'database_directory*' --exclude Makefile old/libsepol/src/interfaces.c new/libsepol/src/interfaces.c
--- old/libsepol/src/interfaces.c	2005-10-24 12:32:51.000000000 -0400
+++ new/libsepol/src/interfaces.c	2005-10-24 16:54:58.000000000 -0400
@@ -143,7 +143,9 @@ int sepol_iface_query (
 			return STATUS_SUCCESS;
 		}
 	} 
-	return STATUS_NODATA;
+
+	*response = NULL;
+	return STATUS_SUCCESS;
 
 	err: 
 	DEBUG(__FUNCTION__, "could not query interface %s\n", name);
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude direct_api.c --exclude semanage_store.c --exclude libsemanage.map --exclude 'module_record*' --exclude 'database_directory*' --exclude Makefile old/libsepol/src/ports.c new/libsepol/src/ports.c
--- old/libsepol/src/ports.c	2005-10-24 12:32:51.000000000 -0400
+++ new/libsepol/src/ports.c	2005-10-24 16:55:25.000000000 -0400
@@ -194,7 +194,8 @@ int sepol_port_query(
 		}
 	}
 
-	return STATUS_NODATA;
+	*response = NULL;
+	return STATUS_SUCCESS;
 
 	err: 
 	DEBUG(__FUNCTION__, "could not get context for port %i:%d-%d\n", 
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude direct_api.c --exclude semanage_store.c --exclude libsemanage.map --exclude 'module_record*' --exclude 'database_directory*' --exclude Makefile old/libsepol/src/users.c new/libsepol/src/users.c
--- old/libsepol/src/users.c	2005-10-24 12:32:51.000000000 -0400
+++ new/libsepol/src/users.c	2005-10-24 16:54:06.000000000 -0400
@@ -312,6 +312,42 @@ int sepol_user_exists(
 	return STATUS_SUCCESS;
 }
 
+int sepol_user_query(
+	sepol_policydb_t* p,
+	sepol_user_key_t* key,
+	sepol_user_t** response) {
+
+	policydb_t* policydb = &p->p;
+	user_datum_t* usrdatum = NULL;
+
+	const char* cname;
+	char* name = NULL;
+	sepol_user_key_unpack(key, &cname);
+	name = strdup(cname);
+
+	if (!name) {
+		/* FIXME: handle error */
+		goto err;
+	}
+
+	usrdatum = hashtab_search(policydb->p_users.table, name);
+	if (!usrdatum) {
+		*response = NULL;
+		return STATUS_SUCCESS; 
+	}
+
+	if (user_to_record(policydb, usrdatum->value - 1, response) < 0)
+		goto err;
+
+	free(name);
+	return STATUS_SUCCESS;
+
+	err:
+	/* FIXME: handle error */
+	free(name);
+	return STATUS_ERR;
+}
+
 int sepol_user_iterate(
 	sepol_policydb_t* p, 
 	int (*fn)(

--------------030301040704050208000009--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
