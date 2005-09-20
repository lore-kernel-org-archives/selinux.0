Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j8K7bZNs026362
	for <selinux@tycho.nsa.gov>; Tue, 20 Sep 2005 03:37:35 -0400 (EDT)
Received: from postoffice9.mail.cornell.edu (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j8K7XUJV013407
	for <selinux@tycho.nsa.gov>; Tue, 20 Sep 2005 07:33:30 GMT
Received: from [192.168.2.105] (cpe-24-59-125-231.twcny.res.rr.com [24.59.125.231])
	by postoffice9.mail.cornell.edu (8.12.10/8.12.6) with ESMTP id j8K7XZxU023171
	for <selinux@tycho.nsa.gov>; Tue, 20 Sep 2005 03:33:36 -0400 (EDT)
Message-ID: <432FBD08.2050903@cornell.edu>
Date: Tue, 20 Sep 2005 03:40:56 -0400
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: [ SEPOL/SEMANAGE ] Boolean record
Content-Type: multipart/mixed;
 boundary="------------050309050907080603030300"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------050309050907080603030300
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

The attached patches replace the boolinfo structure with a record.
They also fix improper use of DEBUG, which would cause corrupt error 
messages.


--------------050309050907080603030300
Content-Type: text/x-patch;
 name="libsemanage.boolean.record.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libsemanage.boolean.record.diff"

diff -Naur libsemanage/include/semanage/boolean_record.h libsemanage.new/include/semanage/boolean_record.h
--- libsemanage/include/semanage/boolean_record.h	1969-12-31 19:00:00.000000000 -0500
+++ libsemanage.new/include/semanage/boolean_record.h	2005-09-20 03:29:38.000000000 -0400
@@ -0,0 +1,67 @@
+#ifndef _SEMANAGE_BOOLEAN_RECORD_H_
+#define _SEMANAGE_BOOLEAN_RECORD_H_
+
+/* Implementation via sepol */
+#include <sepol/bool_record.h>
+typedef sepol_bool_t semanage_bool_t;
+typedef sepol_bool_key_t semanage_bool_key_t;
+
+/* Key */
+static inline
+int semanage_bool_key_create(const char* name, semanage_bool_key_t* key) {
+	return sepol_bool_key_create(name, key);
+}
+
+static inline
+int semanage_bool_key_extract(semanage_bool_t boolean, semanage_bool_key_t* key) {
+	return sepol_bool_key_extract(boolean, key);
+}
+
+static inline 
+void semanage_bool_key_free(semanage_bool_key_t key) {
+	sepol_bool_key_free(key);
+}
+
+static inline
+int semanage_bool_compare(semanage_bool_t boolean, semanage_bool_key_t key) {
+	return sepol_bool_compare(boolean, key);
+}
+	
+/* Name */
+static inline
+const char* semanage_bool_get_name(semanage_bool_t boolean) {
+	return sepol_bool_get_name(boolean);
+}
+
+static inline
+int semanage_bool_set_name(semanage_bool_t boolean, const char* name) {
+	return sepol_bool_set_name(boolean, name);
+}
+
+/* Value */
+static inline
+int semanage_bool_get_value(semanage_bool_t boolean) {
+	return sepol_bool_get_value(boolean);
+}
+
+static inline
+void semanage_bool_set_value(semanage_bool_t boolean, int value) {
+	sepol_bool_set_value(boolean, value);
+}
+
+/* Create/Clone/Destroy */
+static inline
+int semanage_bool_create(semanage_bool_t* bool_ptr) {
+	return sepol_bool_create(bool_ptr);
+}
+
+static inline
+int semanage_bool_clone(semanage_bool_t boolean, semanage_bool_t* bool_ptr) {
+	return sepol_bool_clone(boolean, bool_ptr);
+}
+
+static inline
+void semanage_bool_free(semanage_bool_t boolean) {
+	sepol_bool_free(boolean);
+}
+#endif

--------------050309050907080603030300
Content-Type: text/x-patch;
 name="libsepol.boolean.record.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libsepol.boolean.record.diff"

diff -Naur libsepol/include/sepol/boolean_record.h libsepol.new/include/sepol/boolean_record.h
--- libsepol/include/sepol/boolean_record.h	1969-12-31 19:00:00.000000000 -0500
+++ libsepol.new/include/sepol/boolean_record.h	2005-09-20 03:20:51.000000000 -0400
@@ -0,0 +1,40 @@
+#ifndef _SEPOL_BOOLEAN_RECORD_H_
+#define _SEPOL_BOOLEAN_RECORD_H_
+
+#include <stddef.h>
+
+struct sepol_bool;
+struct sepol_bool_key;
+typedef struct sepol_bool* sepol_bool_t;
+typedef struct sepol_bool_key* sepol_bool_key_t;
+
+/* Key */
+extern int sepol_bool_key_create(
+	const char* name,
+	sepol_bool_key_t* key);
+
+extern int sepol_bool_key_extract(
+	sepol_bool_t boolean,
+	sepol_bool_key_t* key_ptr);
+
+extern void sepol_bool_key_free(
+	sepol_bool_key_t key);
+
+extern int sepol_bool_compare(
+	sepol_bool_t boolean,
+	sepol_bool_key_t key);
+	
+/* Name */
+extern const char* sepol_bool_get_name(sepol_bool_t boolean);
+extern int sepol_bool_set_name(sepol_bool_t boolean, const char* name);
+
+/* Value */
+extern int sepol_bool_get_value(sepol_bool_t boolean);
+extern void sepol_bool_set_value(sepol_bool_t boolean, int value);
+
+/* Create/Clone/Destroy */
+extern int sepol_bool_create(sepol_bool_t* bool_ptr);
+extern int sepol_bool_clone(sepol_bool_t boolean, sepol_bool_t* bool_ptr);
+extern void sepol_bool_free(sepol_bool_t boolean);
+
+#endif
diff -Naur libsepol/include/sepol/booleans.h libsepol.new/include/sepol/booleans.h
--- libsepol/include/sepol/booleans.h	2005-07-26 14:43:29.000000000 -0400
+++ libsepol.new/include/sepol/booleans.h	2005-09-20 03:20:49.000000000 -0400
@@ -2,22 +2,17 @@
 #define _SEPOL_BOOLEANS_H_
 
 #include <sepol/policydb.h>
-
-/* High level representation of a boolean */
-typedef struct sepol_boolinfo {
-	char* name;
-	int value;
-} sepol_boolinfo_t;
+#include <sepol/boolean_record.h>
 
 /* Load a boolean into the policy */
 extern int sepol_bool_load (
 	policydb_t* policydb, 
-	sepol_boolinfo_t* boolean);
+	sepol_bool_t boolean);
 
 /* Load a boolean array into the policy */
 extern int sepol_bool_load_array(
 	policydb_t* policydb,
-	sepol_boolinfo_t* bool_arr,
+	sepol_bool_t* bool_arr,
 	int bool_arr_len);
 
-#endif /* _SEPOL_BOOLEANS_H_ */
+#endif
diff -Naur libsepol/src/boolean_record.c libsepol.new/src/boolean_record.c
--- libsepol/src/boolean_record.c	1969-12-31 19:00:00.000000000 -0500
+++ libsepol.new/src/boolean_record.c	2005-09-20 03:12:40.000000000 -0400
@@ -0,0 +1,133 @@
+#include <errno.h>
+#include <stdlib.h>
+#include <string.h>
+
+#include <sepol/boolean_record.h>
+#include "debug.h"
+
+struct sepol_bool {
+	/* This boolean's name */
+	char* name;
+
+	/* Its value */
+	int value;
+};
+
+struct sepol_bool_key {
+	/* This boolean's name */
+	const char* name;
+};
+
+int sepol_bool_key_create(
+	const char* name,
+	sepol_bool_key_t* key_ptr) {
+
+	sepol_bool_key_t tmp_key = 
+		(sepol_bool_key_t) malloc(sizeof (struct sepol_bool_key));
+
+	if (!tmp_key) {
+		DEBUG(__FUNCTION__, "out of memory, "
+			"could not create boolean key\n");
+		return STATUS_ERR;
+	}
+
+	tmp_key->name = name;
+
+	*key_ptr = tmp_key;
+	return STATUS_SUCCESS;
+}
+
+int sepol_bool_key_extract(sepol_bool_t boolean, sepol_bool_key_t* key_ptr) {
+	if (sepol_bool_key_create(boolean->name, key_ptr) < 0) {
+		DEBUG(__FUNCTION__, "could not extract key from boolean %s\n",
+			boolean->name);
+		return STATUS_ERR;
+	}
+
+	return STATUS_SUCCESS;
+}	
+
+void sepol_bool_key_free(sepol_bool_key_t key) {
+	free(key);
+}
+
+int sepol_bool_compare(
+	sepol_bool_t boolean,
+	sepol_bool_key_t key) {
+	
+	if (!strcmp(boolean->name, key->name))
+		return 0;
+	return 1;
+}
+
+/* Name */
+const char* sepol_bool_get_name(sepol_bool_t boolean) {
+	return boolean->name;
+}
+
+int sepol_bool_set_name(sepol_bool_t boolean, const char* name) {
+	boolean->name = strdup(name);
+	if (!boolean->name) {
+		DEBUG(__FUNCTION__, "out of memory, "
+			"could not set boolean name\n");
+		return STATUS_ERR;
+	}
+	return STATUS_SUCCESS;
+}
+
+/* Value */
+int sepol_bool_get_value(sepol_bool_t boolean) {
+	return boolean->value;
+}
+
+void sepol_bool_set_value(sepol_bool_t boolean, int value) {
+	boolean->value = value;
+}
+
+/* Create */
+int sepol_bool_create(sepol_bool_t* bool_ptr) {
+	sepol_bool_t boolean = (sepol_bool_t) 
+		malloc(sizeof (struct sepol_bool));
+
+        if (!boolean) {
+		DEBUG(__FUNCTION__, "out of memory, "
+			"could not create boolean record\n"); 
+		return STATUS_ERR;
+	}
+
+        boolean->name = NULL;
+	boolean->value = 0;
+	
+	*bool_ptr = boolean;
+	return STATUS_SUCCESS;
+}
+
+/* Deep copy clone */
+int sepol_bool_clone(sepol_bool_t boolean, sepol_bool_t* bool_ptr) {
+	sepol_bool_t new_bool = NULL;
+
+	if (sepol_bool_create(&new_bool) < 0)
+		goto err;
+
+	if (sepol_bool_set_name(new_bool, boolean->name) < 0)
+		goto err;
+
+	new_bool->value = boolean->value;
+
+	*bool_ptr = new_bool;
+	return STATUS_SUCCESS;
+
+	err:
+	DEBUG(__FUNCTION__, "could not clone boolean record\n");
+	sepol_bool_free(new_bool);
+	return STATUS_ERR;
+}
+
+/* Destroy */
+void sepol_bool_free(sepol_bool_t boolean) {
+	if (!boolean)
+		return;
+	
+	free(boolean->name);
+	free(boolean);
+}
diff -Naur libsepol/src/booleans.c libsepol.new/src/booleans.c
--- libsepol/src/booleans.c	2005-07-26 14:43:29.000000000 -0400
+++ libsepol.new/src/booleans.c	2005-09-20 03:26:44.000000000 -0400
@@ -9,29 +9,42 @@
 #include <sepol/hashtab.h>
 #include <sepol/policydb.h>
 #include <sepol/conditional.h>
+#include <sepol/boolean_record.h>
 
 static inline int bool_update (
 	policydb_t* policydb,
-	sepol_boolinfo_t* boolean) {
+	sepol_bool_t boolean) {
+
+	char* name = strdup(sepol_bool_get_name(boolean));
+	int value = sepol_bool_get_value(boolean);
+
+	if (!name) {
+		DEBUG(__FUNCTION__, "out of memory\n");
+		goto err;
+	}
 
 	cond_bool_datum_t *datum = 
-		hashtab_search(policydb->p_bools.table, boolean->name);
+		hashtab_search(policydb->p_bools.table, name);
 	if (!datum) {
-		DEBUG(__FUNCTION__, "boolean %s no longer in policy\n",
-			boolean->name);
-		return STATUS_ERR;
-        }
-	if (boolean->value != 0 && boolean->value != 1) {
-		DEBUG(__FUNCTION__, "illegal value %d for boolean %s\n",
-			boolean->value, boolean->name);
-		return STATUS_ERR;
-        }
-        datum->state = boolean->value;
+		DEBUG(__FUNCTION__, "boolean %s no longer in policy\n", name);
+		goto err;
+	}
+	if (value != 0 && value != 1) {
+		DEBUG(__FUNCTION__, "illegal value %d for boolean %s\n", value, name);
+		goto err;
+	}
+	datum->state = value;
 	return STATUS_SUCCESS;
+
+	err:
+	free(name);
+	DEBUG(__FUNCTION__, "unable to update boolean %s\n", 
+		sepol_bool_get_name(boolean));
+	return STATUS_ERR;		
 }
 
 int sepol_bool_load (
-	policydb_t* policydb, sepol_boolinfo_t* boolean) {
+	policydb_t* policydb, sepol_bool_t boolean) {
 
 	if (bool_update(policydb, boolean) < 0)
 		goto err;	
@@ -44,27 +57,27 @@
 	return STATUS_SUCCESS;
 
 	err:
-	DEBUG(__FUNCTION__, "could not load boolean %s\n", boolean->name);
+	DEBUG(__FUNCTION__, "could not load boolean %s\n", 
+		sepol_bool_get_name(boolean));
 	errno = EINVAL;
 	return STATUS_ERR;
 }
 
 int sepol_bool_load_array(
 	policydb_t* policydb,
-	sepol_boolinfo_t* bool_arr,
+	sepol_bool_t* bool_arr,
 	int bool_arr_len) {	
 
 	int i, errors = 0;
 
 	for (i = 0; i < bool_arr_len; i++)
-		if (bool_update(policydb, &bool_arr[i]) < 0) {
+		if (bool_update(policydb, bool_arr[i]) < 0) {
 			errors++;
 			continue;
 		}	
 
 	if (evaluate_conds(policydb) < 0) {
-		DEBUG("%s: error while re-evaluating conditionals\n", 
-			__FUNCTION__);
+		DEBUG(__FUNCTION__, "error while re-evaluating conditionals\n");
 		goto err;
 	}
 
@@ -74,6 +87,6 @@
 	return STATUS_SUCCESS;
 	err:
 	errno = EINVAL;
-	DEBUG("%s: error while loading booleans\n", __FUNCTION__);
+	DEBUG(__FUNCTION__, "error while loading booleans\n");
 	return STATUS_ERR;
 }

--------------050309050907080603030300--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
