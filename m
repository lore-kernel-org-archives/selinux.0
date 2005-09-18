Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j8IHPPNs011609
	for <selinux@tycho.nsa.gov>; Sun, 18 Sep 2005 13:25:25 -0400 (EDT)
Received: from postoffice9.mail.cornell.edu (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j8IHLZ1I000748
	for <selinux@tycho.nsa.gov>; Sun, 18 Sep 2005 17:21:35 GMT
Message-ID: <432DA3D5.3000304@cornell.edu>
Date: Sun, 18 Sep 2005 13:28:53 -0400
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
CC: dwalsh@redhat.com
Subject: [ SEPOL/SEMANAGE ] Interface record
Content-Type: multipart/mixed;
 boundary="------------040908000309080504080704"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------040908000309080504080704
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

The attached patches add the interface record to libsepol and libsemanage,
which replaces the current sepol_iface_t structure. They also fix a minor
namespace issue, and add include guards to sepol/interfaces.h.


--------------040908000309080504080704
Content-Type: text/x-patch;
 name="libsemanage.iface.record.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libsemanage.iface.record.diff"

diff -Naur libsemanage.new/include/semanage/iface_record.h libsemanage/include/semanage/iface_record.h
--- libsemanage.new/include/semanage/iface_record.h	1969-12-31 19:00:00.000000000 -0500
+++ libsemanage/include/semanage/iface_record.h	2005-09-18 13:25:40.000000000 -0400
@@ -0,0 +1,83 @@
+#ifndef _SEMANAGE_IFACE_RECORD_H_
+#define _SEMANAGE_IFACE_RECORD_H_ 
+
+#include <semanage/context_record.h>
+
+/* Implentation via sepol */
+#include <sepol/iface_record.h>
+typedef sepol_iface_t semanage_iface_t;
+typedef sepol_iface_key_t semanage_iface_key_t;
+
+/* Key */
+static inline
+int semanage_iface_compare(semanage_iface_t iface, semanage_iface_key_t key) {
+	return sepol_iface_compare(iface, key);
+}
+
+static inline
+int semanage_iface_key_create(
+	const char* name,
+	semanage_iface_key_t* key_ptr) {
+	return sepol_iface_key_create(name, key_ptr);
+}
+
+static inline
+int semanage_iface_key_extract(
+	semanage_iface_t iface,
+	semanage_iface_key_t* key_ptr) {
+	return sepol_iface_key_extract(iface, key_ptr);
+}
+
+static inline
+void semanage_iface_key_free(semanage_iface_key_t key) {
+	sepol_iface_key_free(key);
+}
+
+/* Name */
+static inline
+const char* semanage_iface_get_name(semanage_iface_t iface) {
+        return sepol_iface_get_name(iface);
+}
+
+static inline
+int semanage_iface_set_name(semanage_user_t iface, const char* name) {
+        return sepol_iface_set_name(iface, name);
+}
+	
+/* Context */
+static inline
+semanage_context_t semanage_iface_get_ifcon(semanage_iface_t iface) {
+	return sepol_iface_get_ifcon(iface);
+}
+
+static inline
+int semanage_iface_set_ifcon(semanage_iface_t iface, semanage_context_t con) {
+	return sepol_iface_set_ifcon(iface, con);
+}
+
+static inline
+semanage_context_t semanage_iface_get_msgcon(semanage_iface_t iface) {
+	return sepol_iface_get_msgcon(iface);	
+}
+
+static inline
+int semanage_iface_set_msgcon(semanage_iface_t iface, semanage_context_t con) {
+	return sepol_iface_set_msgcon(iface, con);
+}
+
+/* Create/Clone/Destroy */
+static inline
+int semanage_iface_create(semanage_iface_t* iface_ptr) {
+	return sepol_iface_create(iface_ptr);
+}
+
+static inline
+int semanage_iface_clone(semanage_iface_t iface, semanage_iface_t* iface_ptr) {
+	return sepol_iface_clone(iface, iface_ptr);
+}
+
+static inline
+void semanage_iface_free(semanage_iface_t iface) {
+	sepol_iface_free(iface);
+}
+#endif

--------------040908000309080504080704
Content-Type: text/x-patch;
 name="libsepol.iface.record.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libsepol.iface.record.diff"

diff -Naur libsepol.new/ChangeLog libsepol/ChangeLog
--- libsepol.new/ChangeLog	2005-09-14 14:57:30.000000000 -0400
+++ libsepol/ChangeLog	2005-09-17 23:02:56.000000000 -0400
@@ -1,3 +1,7 @@
+1.9.3 2005-09-14
+	* Merged fix for sepol_enable/disable_debug from Ivan
+	Gyurdiev.
+
 1.9.2 2005-09-14
 	* Merged stddef.h patch and debug conversion patch from 
 	Ivan Gyurdiev.
diff -Naur libsepol.new/CVS/Entries libsepol/CVS/Entries
--- libsepol.new/CVS/Entries	2005-09-14 14:57:30.000000000 -0400
+++ libsepol/CVS/Entries	2005-09-17 23:02:56.000000000 -0400
@@ -1,8 +1,8 @@
 /COPYING/1.2/Fri May 20 15:43:20 2005//
 /Makefile/1.3/Wed Feb  9 22:04:52 2005/-ko/
-D/include////
 D/man////
-D/src////
 D/utils////
-/ChangeLog/1.58/Wed Sep 14 18:57:30 2005//
-/VERSION/1.56/Wed Sep 14 18:57:30 2005/-ko/
+D/include////
+D/src////
+/ChangeLog/1.59/Sun Sep 18 03:02:56 2005//
+/VERSION/1.57/Sun Sep 18 03:02:56 2005/-ko/
diff -Naur libsepol.new/CVS/Entries.Log libsepol/CVS/Entries.Log
--- libsepol.new/CVS/Entries.Log	2005-09-14 14:58:05.000000000 -0400
+++ libsepol/CVS/Entries.Log	1969-12-31 19:00:00.000000000 -0500
@@ -1,2 +0,0 @@
-A D/include////
-A D/src////
diff -Naur libsepol.new/include/sepol/iface_record.h libsepol/include/sepol/iface_record.h
--- libsepol.new/include/sepol/iface_record.h	1969-12-31 19:00:00.000000000 -0500
+++ libsepol/include/sepol/iface_record.h	2005-09-18 13:15:33.000000000 -0400
@@ -0,0 +1,43 @@
+#ifndef _SEPOL_IFACE_RECORD_H_
+#define _SEPOL_IFACE_RECORD_H_ 
+
+#include <sepol/context_record.h>
+
+struct sepol_iface;
+struct sepol_iface_key;
+typedef struct sepol_iface* sepol_iface_t;
+typedef struct sepol_iface_key* sepol_iface_key_t;
+
+/* Key */
+extern int sepol_iface_compare(
+	sepol_iface_t iface, 
+	sepol_iface_key_t key);
+
+extern int sepol_iface_key_create(
+	const char* name,
+	sepol_iface_key_t* key_ptr);
+
+extern int sepol_iface_key_extract(
+	sepol_iface_t iface, 
+	sepol_iface_key_t* key_ptr);
+
+extern void sepol_iface_key_free(
+	sepol_iface_key_t key);
+
+/* Name */
+extern const char* sepol_iface_get_name(sepol_iface_t iface);
+extern int sepol_iface_set_name(sepol_iface_t iface, const char* name);
+
+/* Context */
+extern sepol_context_t sepol_iface_get_ifcon(sepol_iface_t iface);
+extern int sepol_iface_set_ifcon(sepol_iface_t iface, sepol_context_t con);
+
+extern sepol_context_t sepol_iface_get_msgcon(sepol_iface_t iface);
+extern int sepol_iface_set_msgcon(sepol_iface_t iface, sepol_context_t con);
+
+/* Create/Clone/Destroy */
+extern int sepol_iface_create(sepol_iface_t* iface_ptr);
+extern int sepol_iface_clone(sepol_iface_t iface, sepol_iface_t* iface_ptr);
+extern void sepol_iface_free(sepol_iface_t iface);
+
+#endif
diff -Naur libsepol.new/include/sepol/interfaces.h libsepol/include/sepol/interfaces.h
--- libsepol.new/include/sepol/interfaces.h	2005-09-14 11:44:44.000000000 -0400
+++ libsepol/include/sepol/interfaces.h	2005-09-18 13:16:05.000000000 -0400
@@ -1,29 +1,27 @@
+#ifndef __SEPOL_INTERFACES_H_
+#define __SEPOL_INTERFACES_H_
+
 #include <sepol/policydb.h>
-#include <sepol/context_record.h>
+#include <sepol/iface_record.h>
 #include <stddef.h>
 
-/* High level representation of an interface */
-typedef struct sepol_iface {
-        const char* name;
-        sepol_context_t netif_con;
-        sepol_context_t netmsg_con;
-} sepol_iface_t;
-
 /* Create a low level interface structure from
  * a high level representation */
-extern int sepol_iface_create(
+extern int sepol_iface_struct_create(
 	policydb_t* policydb,
 	ocontext_t** iface,
-	sepol_iface_t* data);
+	sepol_iface_t data);
 
 /* Get the current context mapping for this interface */
 extern int sepol_iface_get_context(
 	policydb_t* policydb,
-	sepol_iface_t* data,
+	sepol_iface_t data,
 	char** ifcon_str, size_t* ifcon_str_len,
 	char** msgcon_str, size_t* msgcon_str_len);
 
 /* Load an interface into policy */
 extern int sepol_iface_load(
 	policydb_t* policydb,
-	sepol_iface_t* data);
+	sepol_iface_t data);
+
+#endif
diff -Naur libsepol.new/src/CVS/Entries libsepol/src/CVS/Entries
--- libsepol.new/src/CVS/Entries	2005-09-14 14:58:07.000000000 -0400
+++ libsepol/src/CVS/Entries	2005-09-17 23:02:56.000000000 -0400
@@ -8,7 +8,6 @@
 /constraint.c/1.4/Wed Aug 10 17:39:31 2005//
 /context.c/1.3/Tue Aug  2 13:17:09 2005//
 /context_record.c/1.2/Thu Aug 18 20:42:25 2005//
-/debug.c/1.2/Wed Sep 14 15:44:44 2005//
 /debug.h/1.1/Mon Jul 18 14:28:43 2005//
 /ebitmap.c/1.4/Wed Jul  6 17:45:07 2005/-ko/
 /expand.c/1.10/Fri Sep  9 15:42:25 2005//
@@ -21,7 +20,6 @@
 /link.c/1.5/Wed Aug 31 16:31:31 2005//
 /mls.c/1.9/Thu Aug 11 16:57:51 2005//
 /module.c/1.1/Tue Aug  2 19:41:19 2005//
-/policydb.c/1.24/Wed Sep 14 15:44:44 2005/-ko/
 /policydb_convert.c/1.2/Tue Jul 26 18:43:30 2005//
 /port_record.c/1.1/Tue Aug  2 13:17:09 2005//
 /ports.c/1.2/Tue Aug  2 13:17:09 2005//
@@ -33,4 +31,6 @@
 /users.c/1.4/Thu Aug 11 16:57:51 2005//
 /util.c/1.5/Wed Aug 31 20:19:30 2005//
 /write.c/1.14/Fri Aug 12 19:05:25 2005/-ko/
+/debug.c/1.3/Sun Sep 18 03:02:56 2005//
+/policydb.c/1.25/Sun Sep 18 03:02:56 2005/-ko/
 D
diff -Naur libsepol.new/src/iface_record.c libsepol/src/iface_record.c
--- libsepol.new/src/iface_record.c	1969-12-31 19:00:00.000000000 -0500
+++ libsepol/src/iface_record.c	2005-09-18 13:14:45.000000000 -0400
@@ -0,0 +1,159 @@
+#include <stdlib.h>
+#include <string.h>
+
+#include <sepol/iface_record.h>
+#include <sepol/context_record.h>
+#include "debug.h"
+
+struct sepol_iface {
+	
+	/* Interface name */
+	char* name;
+
+	/* Interface context */
+	sepol_context_t netif_con;
+
+	/* Message context */
+	sepol_context_t netmsg_con;
+};
+
+struct sepol_iface_key {
+
+	/* Interface name */
+	const char* name;
+};
+
+/* Key */
+int sepol_iface_key_create(
+	const char* name,
+	sepol_iface_key_t* key_ptr) {
+
+	sepol_iface_key_t tmp_key = 
+		(sepol_iface_key_t) malloc(sizeof(struct sepol_iface_key));
+
+	if (!tmp_key) {
+		DEBUG(__FUNCTION__, "out of memory, could not create "
+			"interface key\n");
+		return STATUS_ERR;
+	}
+
+	tmp_key->name = name;
+	
+	*key_ptr = tmp_key;
+	return STATUS_SUCCESS;
+}
+
+int sepol_iface_key_extract(sepol_iface_t iface, sepol_iface_key_t* key_ptr) {
+	if (sepol_iface_key_create(iface->name, key_ptr) < 0) {
+		DEBUG(__FUNCTION__, "could not extract key from "
+			"interface %s\n", iface->name);
+		return STATUS_ERR;
+	}
+
+	return STATUS_SUCCESS;
+}
+
+void sepol_iface_key_free(sepol_iface_key_t key) {
+	free(key);
+}
+
+int sepol_iface_compare(
+	sepol_iface_t iface, 
+	sepol_iface_key_t key) {
+	
+	if (!strcmp(iface->name, key->name)) 
+		return 0;
+	return 1;
+}
+
+/* Create */
+int sepol_iface_create(sepol_iface_t* iface) {
+	sepol_iface_t tmp_iface = 
+		(sepol_iface_t) malloc(sizeof(struct sepol_iface));
+
+        if (!tmp_iface) {
+		DEBUG(__FUNCTION__, "out of memory, could not create "
+			"interface record\n");
+		return STATUS_ERR;
+	}
+
+	tmp_iface->name = NULL;
+	tmp_iface->netif_con = NULL;
+	tmp_iface->netmsg_con = NULL;
+	*iface = tmp_iface;	
+
+	return STATUS_SUCCESS;
+}
+
+/* Name */
+const char* sepol_iface_get_name(sepol_iface_t iface) {
+	return iface->name;
+}
+
+int sepol_iface_set_name(sepol_iface_t iface, const char* name) {
+        iface->name = strdup(name);
+        if (!iface->name) {
+		DEBUG(__FUNCTION__, "out of memory, "
+			"could not set interface name\n");
+		return STATUS_ERR;
+	}
+	return STATUS_SUCCESS;
+}
+
+/* Interface Context */
+sepol_context_t sepol_iface_get_ifcon(sepol_iface_t iface) {
+	return iface->netif_con;
+}
+
+int sepol_iface_set_ifcon(sepol_iface_t iface, sepol_context_t con) {
+	iface->netif_con = con;
+	return STATUS_SUCCESS;
+}
+
+/* Message Context */
+sepol_context_t sepol_iface_get_msgcon(sepol_iface_t iface) {
+	return iface->netmsg_con;
+}
+
+int sepol_iface_set_msgcon(sepol_iface_t iface, sepol_context_t con) {
+	iface->netmsg_con = con;
+	return STATUS_SUCCESS;
+}
+
+/* Deep copy clone */
+int sepol_iface_clone(sepol_iface_t iface, sepol_iface_t* iface_ptr) {
+
+	sepol_iface_t new_iface = NULL;
+	if (sepol_iface_create(&new_iface) < 0)
+		goto err;
+
+	if (sepol_iface_set_name(new_iface, iface->name) < 0)
+		goto err;
+
+	if (iface->netif_con && 
+	   (sepol_context_clone(iface->netif_con, &new_iface->netif_con) < 0))
+		goto err;	
+
+	if (iface->netmsg_con &&
+	   (sepol_context_clone(iface->netmsg_con, &new_iface->netmsg_con) < 0))
+		goto err;
+
+	*iface_ptr = new_iface;
+	return STATUS_SUCCESS;
+
+	err:
+	DEBUG(__FUNCTION__, "could not clone interface record\n");
+	sepol_iface_free(new_iface);
+	return STATUS_ERR;
+}
+
+/* Destroy */
+void sepol_iface_free(sepol_iface_t iface) {
+	if (!iface)
+		return;
+
+	free(iface->name);
+	sepol_context_free(iface->netif_con);
+	sepol_context_free(iface->netmsg_con);
+	free(iface);
+}
diff -Naur libsepol.new/src/interfaces.c libsepol/src/interfaces.c
--- libsepol.new/src/interfaces.c	2005-08-02 09:17:09.000000000 -0400
+++ libsepol/src/interfaces.c	2005-09-18 13:09:55.000000000 -0400
@@ -8,13 +8,14 @@
 #include <sepol/sidtab.h>
 #include <sepol/services.h>
 #include <sepol/interfaces.h>
+#include <sepol/iface_record.h>
 
 /* Create a low level interface structure from
  * a high level representation */
-int sepol_iface_create(
+int sepol_iface_struct_create(
 	policydb_t* policydb,
 	ocontext_t** iface,
-	sepol_iface_t* data) {
+	sepol_iface_t data) {
 
 	ocontext_t* tmp_iface = NULL;
 	context_struct_t* tmp_ifcon = NULL;
@@ -25,20 +26,20 @@
 		goto omem;
 
 	/* Name */
-	tmp_iface->u.name = strdup(data->name);
+	tmp_iface->u.name = strdup(sepol_iface_get_name(data));
 	if (!tmp_iface->u.name)
 		goto omem;
 
 	/* Interface Context */
 	if (sepol_ctx_struct_create(policydb, 
-		&tmp_ifcon, data->netif_con) < 0)
+		&tmp_ifcon, sepol_iface_get_ifcon(data)) < 0)
 		goto err;
 	context_cpy(&tmp_iface->context[0], tmp_ifcon);
 	free(tmp_ifcon);
 
 	/* Message Context */
-	if (sepol_ctx_struct_create(policydb, &tmp_msgcon, 
-		data->netmsg_con) < 0)
+	if (sepol_ctx_struct_create(policydb, 
+		&tmp_msgcon, sepol_iface_get_msgcon(data)) < 0)
 		goto err;
 	context_cpy(&tmp_iface->context[1], tmp_msgcon);
 	free(tmp_msgcon);
@@ -58,15 +59,16 @@
 /* Get the current context mapping for this interface */
 int sepol_iface_get_context(
 	policydb_t* policydb,
-	sepol_iface_t* data,
+	sepol_iface_t data,
 	char** ifcon_str, size_t* ifcon_str_len,	
 	char** msgcon_str, size_t* msgcon_str_len) {
 
 	ocontext_t *c, *head;
+	const char* name = sepol_iface_get_name(data);
 
 	head = policydb->ocontexts[OCON_NETIF];
 	for (c = head; c; c = c->next) {
-		if (!strcmp(data->name, c->u.name)) { 
+		if (!strcmp(name, c->u.name)) { 
 			if (sepol_ctx_struct_to_string(policydb, 
 				&c->context[0], ifcon_str, ifcon_str_len) < 0)
 				goto err;
@@ -83,21 +85,23 @@
 
 	err: 
 	DEBUG(__FUNCTION__, "could not construct context string for "
-		"interface %s\n", data->name);
+		"interface %s\n", name);
 	return STATUS_ERR;
 }
 
 /* Load an interface into policy */
 int sepol_iface_load(
 	policydb_t* policydb, 
-	sepol_iface_t* data) {
+	sepol_iface_t data) {
 
 	ocontext_t* iface = NULL;
 	char *ifcon_str, *msgcon_str;
 	size_t ifcon_str_len, msgcon_str_len;
 	int rc;
 
-	if (sepol_iface_create(policydb, &iface, data) < 0)
+	const char* name = sepol_iface_get_name(data);
+
+	if (sepol_iface_struct_create(policydb, &iface, data) < 0)
 		goto err;
 
 	rc = sepol_iface_get_context(
@@ -110,7 +114,7 @@
 	else if (rc != STATUS_NODATA) {
 		DEBUG(__FUNCTION__, "interface %s is already mapped to " 
 			"context %s with message context %s\n", 
-			data->name, ifcon_str, msgcon_str);
+			name, ifcon_str, msgcon_str);
 		goto err;
 	}
 	
@@ -121,8 +125,7 @@
 	return STATUS_SUCCESS;
 
 	err:
-	DEBUG(__FUNCTION__, "error while loading interface %s\n",
-		data->name);
+	DEBUG(__FUNCTION__, "error while loading interface %s\n", name);
 	free(iface);
 	return STATUS_ERR;
 }
diff -Naur libsepol.new/src/policydb.c libsepol/src/policydb.c
--- libsepol.new/src/policydb.c	2005-09-14 11:44:44.000000000 -0400
+++ libsepol/src/policydb.c	2005-09-17 23:02:56.000000000 -0400
@@ -51,6 +51,7 @@
 #include <sepol/avrule_block.h>
 
 #include "private.h"
+#include "debug.h"
 
 /* These need to be updated if SYM_NUM or OCON_NUM changes */
 static struct policydb_compat_info policydb_compat[] = {
diff -Naur libsepol.new/VERSION libsepol/VERSION
--- libsepol.new/VERSION	2005-09-14 14:57:30.000000000 -0400
+++ libsepol/VERSION	2005-09-17 23:02:56.000000000 -0400
@@ -1 +1 @@
-1.9.2
+1.9.3

--------------040908000309080504080704--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
