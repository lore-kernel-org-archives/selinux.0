Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id kA6Hev1s005930
	for <selinux@tycho.nsa.gov>; Mon, 6 Nov 2006 12:40:57 -0500
Received: from localhost.localdomain (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id kA6HdKPI000493
	for <selinux@tycho.nsa.gov>; Mon, 6 Nov 2006 17:39:21 GMT
Message-Id: <20061106173950.246905998@tresys.com>>
References: <20061106173814.457967976@tresys.com>>
Date: Mon, 06 Nov 2006 12:38:18 -0500
From: Chad Sellers <csellers@tresys.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH 4/4] SELinux: validate kernel object classes and permissions
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a new object class and permission validation scheme that validates against the defined kernel headers. This scheme allows extra classes and permissions that do not conflict with the kernel definitions to be added to the policy. This validation is now done for all policy loads, not just subsequent loads after the first policy load.

The implementation walks the three structrures containing the defined object class and permission values and ensures their values are the same in the policy being loaded. This includes verifying the object classes themselves, the permissions they contain, and the permissions they inherit from commons. Classes or permissions that are present in the kernel but missing from the policy cause a warning (printed to KERN_INFO) to be printed, but do not stop the policy from loading, emulating current behavior. Any other inconsistencies cause the load to fail.

Signed-off-by: Chad Sellers <csellers@tresys.com>

---
 security/selinux/ss/services.c |  138 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 137 insertions(+), 1 deletion(-)

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
+extern const struct selinux_class_perm selinux_class_perm;
+
 static DEFINE_RWLOCK(policy_rwlock);
 #define POLICY_RDLOCK read_lock(&policy_rwlock)
 #define POLICY_WRLOCK write_lock_irq(&policy_rwlock)
@@ -1018,6 +1027,115 @@ int security_change_sid(u32 ssid,
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
+	u32 nprim, tmp, common_pts_len, perm_val, pol_val;
+	u16 class_val;
+	const struct selinux_class_perm *kdefs = &selinux_class_perm;
+	const char *def_class, *def_perm, *pol_class;
+	struct symtab *perms;
+
+	for (i = 1; i < kdefs->cts_len; i++) {
+		def_class = kdefs->class_to_string[i];
+		if (i > p->p_classes.nprim) {
+			printk(KERN_INFO
+			       "security:  class %s not defined in policy\n",
+			       def_class);
+			continue;
+		}
+		pol_class = p->p_class_val_to_name[i-1];
+		if (strcmp(pol_class, def_class)) {
+			printk(KERN_ERR
+			       "security:  class %d is incorrect, found %s but should be %s\n",
+			       i, pol_class, def_class);
+			return -EINVAL;
+		}
+	}
+	for (i = 0; i < kdefs->av_pts_len; i++) {
+		class_val = kdefs->av_perm_to_string[i].tclass;
+		perm_val = kdefs->av_perm_to_string[i].value;
+		def_perm = kdefs->av_perm_to_string[i].name;
+		if (class_val > p->p_classes.nprim)
+			continue;
+		pol_class = p->p_class_val_to_name[class_val-1];
+		cladatum = hashtab_search(p->p_classes.table, pol_class);
+		BUG_ON(!cladatum);
+		perms = &cladatum->permissions;
+		nprim = 1 << (perms->nprim - 1);
+		if (perm_val > nprim) {
+			printk(KERN_INFO
+			       "security:  permission %s in class %s not defined in policy\n",
+			       def_perm, pol_class);
+			continue;
+		}
+		perdatum = hashtab_search(perms->table, def_perm);
+		if (perdatum == NULL) {
+			printk(KERN_ERR
+			       "security:  permission %s in class %s not found in policy\n",
+			       def_perm, pol_class);
+			return -EINVAL;
+		}
+		pol_val = 1 << (perdatum->value - 1);
+		if (pol_val != perm_val) {
+			printk(KERN_ERR
+			       "security:  permission %s in class %s has incorrect value\n",
+			       def_perm, pol_class);
+			return -EINVAL;
+		}
+	}
+	for (i = 0; i < kdefs->av_inherit_len; i++) {
+		class_val = kdefs->av_inherit[i].tclass;
+		if (class_val > p->p_classes.nprim)
+			continue;
+		pol_class = p->p_class_val_to_name[class_val-1];
+		cladatum = hashtab_search(p->p_classes.table, pol_class);
+		BUG_ON(!cladatum);
+		if (!cladatum->comdatum) {
+			printk(KERN_ERR
+			       "security:  class %s should have an inherits clause but does not\n",
+			       pol_class);
+			return -EINVAL;
+		}
+		tmp = kdefs->av_inherit[i].common_base;
+		common_pts_len = 0;
+		while (!(tmp & 0x01)) {
+			common_pts_len++;
+			tmp >>= 1;
+		}
+		perms = &cladatum->comdatum->permissions;
+		for (j = 0; j < common_pts_len; j++) {
+			def_perm = kdefs->av_inherit[i].common_pts[j];
+			if (j >= perms->nprim) {
+				printk(KERN_INFO
+				       "security:  permission %s in class %s not defined in policy\n",
+				       def_perm, pol_class);
+				continue;
+			}
+			perdatum = hashtab_search(perms->table, def_perm);
+			if (perdatum == NULL) {
+				printk(KERN_ERR
+				       "security:  permission %s in class %s not found in policy\n",
+				       def_perm, pol_class);
+				return -EINVAL;
+			}
+			if (perdatum->value != j + 1) {
+				printk(KERN_ERR
+				       "security:  permission %s in class %s has incorrect value\n",
+				       def_perm, pol_class);
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
@@ -1160,6 +1278,16 @@ int security_load_policy(void *data, siz
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
@@ -1182,6 +1310,14 @@ int security_load_policy(void *data, siz
 
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
