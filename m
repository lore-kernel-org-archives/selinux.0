Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id kA3KZFjC006119
	for <selinux@tycho.nsa.gov>; Fri, 3 Nov 2006 15:35:15 -0500
Received: from localhost.localdomain (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id kA3KYUEG007802
	for <selinux@tycho.nsa.gov>; Fri, 3 Nov 2006 20:34:31 GMT
Message-Id: <20061103203430.759007300@tresys.com>>
References: <20061103203354.331494899@tresys.com>>
Date: Fri, 03 Nov 2006 15:33:58 -0500
From: Chad Sellers <csellers@tresys.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH 4/4] SELinux: validate kernel object classes and permissions
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a new object class and permission validation scheme that validates against the defined kernel headers. This scheme allows extra classes and permissions that do not conflict with the kernel definitions to be added to the policy. This validation is now done for all policy loads, not just subsequent loads after the first policy load.

The implementation walks the three structrures containing the defined object class and permission values and ensures their values are the same in the policy being loaded. This includes verifying the object classes themselves, the permissions they contain, and the permissions they inherit from commons. Classes or permissions that are present in the kernel but missing from the policy cause a warning (printed to KERN_INFO) to be printed, but do not stop the policy from loading, emulating current behavior. Any other inconsistencies cause the load to fail.

Signed-off-by: Chad Sellers <csellers@tresys.com>

---
 security/selinux/ss/services.c |  159 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 158 insertions(+), 1 deletion(-)

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
@@ -1018,6 +1027,136 @@ int security_change_sid(u32 ssid,
 	return security_compute_sid(ssid, tsid, tclass, AVTAB_CHANGE, out_sid);
 }
 
+/*
+ * Verify that each kernel class that is defined in the
+ * policy is correct
+ */
+static int validate_classes(struct policydb *p)
+{
+	int i, j;
+	struct class_datum *cladatum;
+	struct perm_datum *perdatum;
+	u32 val, tmp, common_pts_len;
+
+	for (i = 1; i < defined_classes_perms.class_to_string_len; i++) {
+		if (i > p->p_classes.nprim) {
+			printk(KERN_INFO
+			       "security:  class %s not defined in policy\n",
+			       defined_classes_perms.class_to_string[i]);
+			continue;
+		}
+		if (strcmp(p->p_class_val_to_name[i-1],
+		           defined_classes_perms.class_to_string[i])) {
+			printk(KERN_ERR
+			       "security:  class number %d is incorrect, found %s but should be %s\n",
+			       i, p->p_class_val_to_name[i-1],
+			       defined_classes_perms.class_to_string[i]);
+			return -EINVAL;
+		}
+		cladatum = hashtab_search(p->p_classes.table,
+		                          defined_classes_perms.class_to_string[i]);
+		if (cladatum == NULL) {
+			printk(KERN_ERR "security:  class %s not found in policy\n",
+			       defined_classes_perms.class_to_string[i]);
+			return -EINVAL;
+		}
+		if (i != cladatum->value) {
+			printk(KERN_ERR
+			       "security:  class %s has incorrect value, found %d but should be %d\n",
+			       defined_classes_perms.class_to_string[i],
+			       cladatum->value, i);
+			return -EINVAL;
+		}
+	}
+	for (i = 0; i < defined_classes_perms.av_perm_to_string_len; i++) {
+		if (defined_classes_perms.av_perm_to_string[i].tclass > p->p_classes.nprim)
+			continue;
+		cladatum = hashtab_search(p->p_classes.table,
+		                          p->p_class_val_to_name[defined_classes_perms.av_perm_to_string[i].tclass-1]);
+		if (cladatum == NULL) {
+			printk(KERN_ERR
+			       "security:  class %s for permission %s not found in policy\n",
+			        p->p_class_val_to_name[defined_classes_perms.av_perm_to_string[i].tclass-1],
+			        defined_classes_perms.av_perm_to_string[i].name);
+			return -EINVAL;
+		}
+		val = 1 << (cladatum->permissions.nprim - 1);
+		if (defined_classes_perms.av_perm_to_string[i].value > val) {
+			printk(KERN_INFO
+			       "security:  permission %s in class %s not defined in policy\n",
+			       defined_classes_perms.av_perm_to_string[i].name,
+			       p->p_class_val_to_name[defined_classes_perms.av_perm_to_string[i].tclass-1]);
+			continue;
+		}
+		perdatum = hashtab_search(cladatum->permissions.table,
+		                          defined_classes_perms.av_perm_to_string[i].name);
+		if (perdatum == NULL) {
+			printk(KERN_ERR
+			       "security:  permission %s in class %s not found in policy\n",
+			       defined_classes_perms.av_perm_to_string[i].name,
+			       p->p_class_val_to_name[defined_classes_perms.av_perm_to_string[i].tclass-1]);
+			return -EINVAL;
+		}
+		val = 1 << (perdatum->value - 1);
+		if (val != defined_classes_perms.av_perm_to_string[i].value) {
+			printk(KERN_ERR
+			       "security:  permission %s in class %s has incorrect value\n",
+			       defined_classes_perms.av_perm_to_string[i].name,
+			       p->p_class_val_to_name[defined_classes_perms.av_perm_to_string[i].tclass-1]);
+			return -EINVAL;
+		}
+	}
+	for (i = 0; i < defined_classes_perms.av_inherit_len; i++) {
+		if (defined_classes_perms.av_inherit[i].tclass > p->p_classes.nprim)
+			continue;
+		cladatum = hashtab_search(p->p_classes.table,
+		                          p->p_class_val_to_name[defined_classes_perms.av_inherit[i].tclass-1]);
+		if (cladatum == NULL) {
+			printk(KERN_ERR"security:  class %s not found in policy\n",
+			       p->p_class_val_to_name[defined_classes_perms.av_inherit[i].tclass-1]);
+			return -EINVAL;
+		}
+		if (!cladatum->comdatum) {
+			printk(KERN_ERR
+			       "security:  class %s should have an inherits clause but does not\n",
+			       p->p_class_val_to_name[defined_classes_perms.av_inherit[i].tclass-1]);
+			return -EINVAL;
+		}
+		tmp = defined_classes_perms.av_inherit[i].common_base;
+		common_pts_len = 0;
+		while (!(tmp & 0x01)) {
+			common_pts_len++;
+			tmp >>= 1;
+		}
+		for (j = 0; j < common_pts_len; j++) {
+			if (j >= cladatum->comdatum->permissions.nprim) {
+				printk(KERN_INFO
+				       "security:  permission %s in class %s not defined in policy\n",
+				       defined_classes_perms.av_inherit[i].common_pts[j],
+				       p->p_class_val_to_name[defined_classes_perms.av_inherit[i].tclass-1]);
+				continue;
+			}
+			perdatum = hashtab_search(cladatum->comdatum->permissions.table,
+			                          defined_classes_perms.av_inherit[i].common_pts[j]);
+			if (perdatum == NULL) {
+				printk(KERN_ERR
+				       "security:  permission %s in class %s not found in policy\n",
+				       defined_classes_perms.av_inherit[i].common_pts[j],
+				       p->p_class_val_to_name[defined_classes_perms.av_inherit[i].tclass-1]);
+				return -EINVAL;
+			}
+			if (perdatum->value != j + 1) {
+				printk(KERN_ERR
+				       "security:  permission %s in class %s has incorrect value\n",
+				       defined_classes_perms.av_inherit[i].common_pts[j],
+				       p->p_class_val_to_name[defined_classes_perms.av_inherit[i].tclass-1]);
+				return -EINVAL;
+			}
+		}
+	}
+	return 0;
+}
+
 /* Clone the SID into the new SID table. */
 static int clone_sid(u32 sid,
 		     struct context *context,
@@ -1160,6 +1299,16 @@ int security_load_policy(void *data, siz
 			avtab_cache_destroy();
 			return -EINVAL;
 		}
+		/* Verify that the kernel defined classes are correct. */
+		if (validate_classes(&policydb)) {
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
@@ -1182,6 +1331,14 @@ int security_load_policy(void *data, siz
 
 	sidtab_init(&newsidtab);
 
+	/* Verify that the kernel defined classes are correct. */
+	if (validate_classes(&newpolicydb)) {
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
