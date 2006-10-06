Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k96KB59B007838
	for <selinux@tycho.nsa.gov>; Fri, 6 Oct 2006 16:11:05 -0400
Received: from localhost.localdomain (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k96K9pQW024034
	for <selinux@tycho.nsa.gov>; Fri, 6 Oct 2006 20:09:51 GMT
Message-Id: <20061006201104.682339000@tresys.com>>
References: <20061006200951.006196000@tresys.com>>
Date: Fri, 06 Oct 2006 16:09:55 -0400
From: Chad Sellers <csellers@tresys.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH 4/4] Validate kernel object classes and permissions
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This patch replaces the object class and permission validation code to validate against the defined kernel headers, and allow extra classes and permissions that do not conflict with the kernel definitions. Note that validation is now done for all policy loads, not just subsequent loads after the first policy load.

Signed-off-by: Chad Sellers <csellers@tresys.com>

---
 security/selinux/ss/services.c |  161 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 160 insertions(+), 1 deletion(-)

Index: linux-2.6-discovery/security/selinux/ss/services.c
===================================================================
--- linux-2.6-discovery.orig/security/selinux/ss/services.c
+++ linux-2.6-discovery/security/selinux/ss/services.c
@@ -17,9 +17,13 @@
  *
  *      Added support for NetLabel
  *
+ * Updated: Chad Sellers <csellers@tresys.com>
+ *
+ *  Added validation of kernel classes and permissions
+ *
  * Copyright (C) 2006 Hewlett-Packard Development Company, L.P.
  * Copyright (C) 2004-2006 Trusted Computer Solutions, Inc.
- * Copyright (C) 2003 - 2004 Tresys Technology, LLC
+ * Copyright (C) 2003 - 2004, 2006 Tresys Technology, LLC
  * Copyright (C) 2003 Red Hat, Inc., James Morris <jmorris@redhat.com>
  *	This program is free software; you can redistribute it and/or modify
  *  	it under the terms of the GNU General Public License as published by
@@ -53,6 +57,11 @@
 extern void selnl_notify_policyload(u32 seqno);
 unsigned int policydb_loaded_version;
 
+/*
+ * This is declared in avc.c
+ */
+extern const struct defined_classes_perms_t defined_classes_perms;
+
 static DEFINE_RWLOCK(policy_rwlock);
 #define POLICY_RDLOCK read_lock(&policy_rwlock)
 #define POLICY_WRLOCK write_lock_irq(&policy_rwlock)
@@ -1018,6 +1027,138 @@ int security_change_sid(u32 ssid,
 	return security_compute_sid(ssid, tsid, tclass, AVTAB_CHANGE, out_sid);
 }
 
+/*
+ * Verify that each kernel permission that is defined in a
+ * policy class is correct
+ */
+static int validate_class_perm(void *key, void *datum, void *p)
+{
+	struct perm_datum *perdatum;
+	u32 *class, val;
+	char *name;
+	int rc = 0, i;
+
+	class = p;
+	perdatum = datum;
+	name = key;
+	val = 1 << (perdatum->value - 1);
+
+	for (i = 0; i < defined_classes_perms.av_perm_to_string_len; i++) {
+		if ((defined_classes_perms.av_perm_to_string[i].tclass == *class)
+		    && (defined_classes_perms.av_perm_to_string[i].value == val)) {
+			if (strcmp(name, defined_classes_perms.av_perm_to_string[i].name)) {
+				printk(KERN_ERR
+				       "security:  the value of permission %s is incorrect",
+				       (char *)key);
+				rc = -EINVAL;
+			}
+			break;
+		}
+	}
+	return rc;
+}
+
+/*
+ * Verify that each kernel permission that is defined in a
+ * policy common is correct
+ */
+static int validate_common_perm(void *key, void *datum, void *p)
+{
+	struct perm_datum *perdatum;
+	u32 *class, tmp, common_pts_len = 0;
+	char *name;
+	int rc = 0, i;
+
+	class = p;
+	perdatum = datum;
+	name = key;
+
+	for (i = 0; i < defined_classes_perms.av_inherit_len; i++) {
+		if (defined_classes_perms.av_inherit[i].tclass == *class) {
+			tmp = defined_classes_perms.av_inherit[i].common_base;
+			while (!(tmp & 0x01)) {
+				common_pts_len++;
+				tmp >>= 1;
+			}
+			if (perdatum->value > common_pts_len)
+				break;
+			if (strcmp(name, defined_classes_perms.av_inherit[i].
+			     common_pts[perdatum->value - 1])) {
+				printk(KERN_ERR
+				       "security:  the value of permission %s is incorrect",
+				       (char *)key);
+				rc = -EINVAL;
+			}
+			break;
+		}
+	}
+	return rc;
+}
+
+/*
+ * Verify that each kernel class that is defined in the
+ * policy is correct
+ */
+static int validate_class(void *key, void *datum, void *p)
+{
+	struct class_datum *cladatum;
+	int rc, i;
+	char *name;
+	u8 has_common = 0;
+
+	cladatum = datum;
+	name = key;
+
+	if (cladatum->value >= defined_classes_perms.class_to_string_len) {
+		rc = 0;
+		goto out;
+	}
+	if (strcmp(name, defined_classes_perms.class_to_string[cladatum->value])) {
+		printk(KERN_ERR "security:  the value of class %s is incorrect\n",
+		       (char *)key);
+		rc = -EINVAL;
+		goto out;
+	}
+	for (i = 0; i < defined_classes_perms.av_inherit_len; i++) {
+		if (defined_classes_perms.av_inherit[i].tclass == cladatum->value) {
+			has_common = 1;
+			break;
+		}
+	}
+	if (!((cladatum->comdatum && has_common) ||
+	      (!cladatum->comdatum && !has_common))) {
+		if (has_common) {
+			printk(KERN_ERR
+			       "security:  the access vector definition for class"
+			       "%s should have an inherits clause but does not\n",
+			       (char *)key);
+		} else {
+			printk(KERN_ERR
+			       "security:  the access vector definition for class"
+			       "%s should not have an inherits clause but does\n",
+			       (char *)key);
+		}
+		rc = -EINVAL;
+		goto out;
+	}
+	if (cladatum->comdatum) {
+		rc = hashtab_map(cladatum->comdatum->permissions.table,
+				 validate_common_perm, &cladatum->value);
+		if (rc) {
+			printk(" in the access vector definition for class "
+			       "%s\n", (char *)key);
+			goto out;
+		}
+	}
+	rc = hashtab_map(cladatum->permissions.table, validate_class_perm,
+			 &cladatum->value);
+	if (rc)
+		printk(" in access vector definition for class %s\n",
+		       (char *)key);
+out:
+	return rc;
+}
+
 /* Clone the SID into the new SID table. */
 static int clone_sid(u32 sid,
 		     struct context *context,
@@ -1160,6 +1301,16 @@ int security_load_policy(void *data, siz
 			avtab_cache_destroy();
 			return -EINVAL;
 		}
+		/* Verify that the kernel defined classes are correct. */
+		if (hashtab_map(policydb.p_classes.table, validate_class, NULL)) {
+			printk(KERN_ERR
+			       "security:  the definition of a class is incorrect\n");
+			LOAD_UNLOCK;
+			sidtab_destroy(&sidtab);
+			policydb_destroy(&policydb);
+			avtab_cache_destroy();
+			return -EINVAL;
+		}
 		policydb_loaded_version = policydb.policyvers;
 		ss_initialized = 1;
 		seqno = ++latest_granting;
@@ -1182,6 +1333,14 @@ int security_load_policy(void *data, siz
 
 	sidtab_init(&newsidtab);
 
+	/* Verify that the kernel defined classes are correct. */
+	if (hashtab_map(newpolicydb.p_classes.table, validate_class, NULL)) {
+		printk(KERN_ERR
+		       "security:  the definition of a class is incorrect\n");
+		rc = -EINVAL;
+		goto err;
+	}
+
 	/* Clone the SID table. */
 	sidtab_shutdown(&sidtab);
 	if (sidtab_map(&sidtab, clone_sid, &newsidtab)) {

--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
