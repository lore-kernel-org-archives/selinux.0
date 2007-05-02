Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l42IPeWR011049
	for <selinux@tycho.nsa.gov>; Wed, 2 May 2007 14:25:40 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l42IPe38004085
	for <selinux@tycho.nsa.gov>; Wed, 2 May 2007 18:25:40 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.1/8.13.1) with ESMTP id l42IPdvU000855
	for <selinux@tycho.nsa.gov>; Wed, 2 May 2007 14:25:39 -0400
Received: from pobox.corp.redhat.com (pobox.corp.redhat.com [10.11.255.20])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l42IPdDE022007
	for <selinux@tycho.nsa.gov>; Wed, 2 May 2007 14:25:39 -0400
Received: from [172.16.59.235] (dhcp59-235.rdu.redhat.com [172.16.59.235])
	by pobox.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l42IPbXN013589
	for <selinux@tycho.nsa.gov>; Wed, 2 May 2007 14:25:37 -0400
Subject: [RFC] Ability to allow unknown class and permissions -v4
From: Eric Paris <eparis@redhat.com>
To: selinux@tycho.nsa.gov
Content-Type: text/plain
Date: Wed, 02 May 2007 14:25:37 -0400
Message-Id: <1178130337.3897.14.camel@dhcp59-235.rdu.redhat.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I need 4+ RFC's for a small patch, I'm sure everyone is tired of this
darn thing.  But this is a possibly a finished kernel patch (against
linus git as of today) to allow a policy flag to specify how the kernel
should handle a policy which does not cover all of the potential kernel
checks.  The three options are

0 - allow the policy to load but deny all checks (applies to old policy)
1 - reject the policy.  load return with EINVAL
2 - allow the policy to load and allow all unknown checks

Note that since the flags in old policy are all zero (outside of the MLS
flag) running an old policy on a new kernel means there will be no
behavioral change from how things are today.  I'm still fighting with
userspace and should have those patches out soon, but as of this moment
I've been testing by using a hex editor on the policy.21 by hand,
changing the flags, and then rebooting.  (If I use any userspace tools
like load_policy it is blanking the flags on me)  All three options seem
to be working as expected.  But I do need a lot more testing especially
to make sure everything works when i switch between the options on
reloads.  

-Eric

---

 security/selinux/ss/policydb.c |    4 ++
 security/selinux/ss/policydb.h |   13 +++++++
 security/selinux/ss/services.c |   79 ++++++++++++++++++++++++++++++++++------
 3 files changed, 85 insertions(+), 11 deletions(-)

diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index 0ac1021..8599e71 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -670,6 +670,8 @@ void policydb_destroy(struct policydb *p)
 	}
 	kfree(p->type_attr_map);
 
+	kfree(p->undefined_perms);
+
 	return;
 }
 
@@ -1523,6 +1525,8 @@ int policydb_read(struct policydb *p, void *fp)
 			goto bad;
 		}
 	}
+	p->handle_unknown = le32_to_cpu(buf[1]) & POLICYDB_CONFIG_UNKNOWN_MASK;
+	p->handle_unknown >>= POLICYDB_CONFIG_UNKNOWN_SHIFT;
 
 	info = policydb_lookup_compat(p->policyvers);
 	if (!info) {
diff --git a/security/selinux/ss/policydb.h b/security/selinux/ss/policydb.h
index 8319d5f..b92324f 100644
--- a/security/selinux/ss/policydb.h
+++ b/security/selinux/ss/policydb.h
@@ -242,6 +242,9 @@ struct policydb {
 	struct ebitmap *type_attr_map;
 
 	unsigned int policyvers;
+
+	int handle_unknown;
+	u32 *undefined_perms;
 };
 
 extern void policydb_destroy(struct policydb *p);
@@ -253,6 +256,16 @@ extern int policydb_read(struct policydb *p, void *fp);
 
 #define POLICYDB_CONFIG_MLS    1
 
+/* the config flags related to unknown classes/perms are bits 2 and 3 */
+#define POLICYDB_CONFIG_UNKNOWN_MASK 	6
+#define POLICYDB_CONFIG_UNKNOWN_SHIFT 	1
+
+enum policy_with_unknown_perms {
+        DENY_UNKNOWN = 0,
+        REJECT_UNKNOWN = 1,
+        ALLOW_UNKNOWN = 2
+};
+
 #define OBJECT_R "object_r"
 #define OBJECT_R_VAL 1
 
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index 40660ff..17c293c 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -292,6 +292,7 @@ static int context_struct_compute_av(struct context *scontext,
 	struct class_datum *tclass_datum;
 	struct ebitmap *sattr, *tattr;
 	struct ebitmap_node *snode, *tnode;
+	const struct selinux_class_perm *kdefs = &selinux_class_perm;
 	unsigned int i, j;
 
 	/*
@@ -305,13 +306,6 @@ static int context_struct_compute_av(struct context *scontext,
 		    tclass <= SECCLASS_NETLINK_DNRT_SOCKET)
 			tclass = SECCLASS_NETLINK_SOCKET;
 
-	if (!tclass || tclass > policydb.p_classes.nprim) {
-		printk(KERN_ERR "security_compute_av:  unrecognized class %d\n",
-		       tclass);
-		return -EINVAL;
-	}
-	tclass_datum = policydb.class_val_to_struct[tclass - 1];
-
 	/*
 	 * Initialize the access vectors to the default values.
 	 */
@@ -322,6 +316,40 @@ static int context_struct_compute_av(struct context *scontext,
 	avd->seqno = latest_granting;
 
 	/*
+	 * Check if the class in question is a kernel class and if it
+	 * is defined in policy.  If yes to both it will pad the allow
+	 * for undefined perms if appropriate.
+	 */
+	if (unlikely(!tclass))
+		goto inval_class;
+	if (unlikely(tclass > policydb.p_classes.nprim)) {
+		if (tclass > kdefs->cts_len || (policydb.handle_unknown == DENY_UNKNOWN))
+			goto inval_class;
+		/* 
+		 * kernel class not in policy, but we
+		 * allow unknown, so let everything through
+		 */
+		if (kdefs->class_to_string[tclass - 1]) {
+			avd->allowed = 0xffffffff;
+			return 0;
+		}
+		/* 
+		 * this is a 'hole' in policy where a userspace
+		 * class exists
+		 */
+		goto inval_class;
+	}
+	if (tclass < kdefs->cts_len && (policydb.handle_unknown == ALLOW_UNKNOWN))
+		/* 
+		 * kernel class, defined in policy, allow unknown.
+		 * might have undefined permissions, so default 
+		 * those perms to allow
+		 */
+		avd->allowed = policydb.undefined_perms[tclass - 1];
+
+	tclass_datum = policydb.class_val_to_struct[tclass - 1];
+
+	/*
 	 * If a specific type enforcement rule was defined for
 	 * this permission check, then use it.
 	 */
@@ -387,6 +415,10 @@ static int context_struct_compute_av(struct context *scontext,
 	}
 
 	return 0;
+
+inval_class:
+	printk(KERN_ERR "security_compute_av:  unrecognized class %d\n", tclass);
+	return -EINVAL;
 }
 
 static int security_validtrans_handle_fail(struct context *ocontext,
@@ -1054,6 +1086,13 @@ static int validate_classes(struct policydb *p)
 	const char *def_class, *def_perm, *pol_class;
 	struct symtab *perms;
 
+	if (p->handle_unknown == ALLOW_UNKNOWN) {
+		u32 num_classes = kdefs->cts_len;
+		p->undefined_perms = kcalloc(num_classes, sizeof(u32), GFP_KERNEL);
+		if (!p->undefined_perms)
+			return -ENOMEM;
+	}
+
 	for (i = 1; i < kdefs->cts_len; i++) {
 		def_class = kdefs->class_to_string[i];
 		if (!def_class)
@@ -1062,6 +1101,8 @@ static int validate_classes(struct policydb *p)
 			printk(KERN_INFO
 			       "security:  class %s not defined in policy\n",
 			       def_class);
+			if (p->handle_unknown == REJECT_UNKNOWN)
+				return -EINVAL;
 			continue;
 		}
 		pol_class = p->p_class_val_to_name[i-1];
@@ -1087,14 +1128,22 @@ static int validate_classes(struct policydb *p)
 			printk(KERN_INFO
 			       "security:  permission %s in class %s not defined in policy\n",
 			       def_perm, pol_class);
+			if (p->handle_unknown == ALLOW_UNKNOWN)
+				p->undefined_perms[class_val-1] |= perm_val;
+			else if (p->handle_unknown == REJECT_UNKNOWN)
+				return -EINVAL;
 			continue;
 		}
 		perdatum = hashtab_search(perms->table, def_perm);
 		if (perdatum == NULL) {
-			printk(KERN_ERR
+			printk(KERN_INFO
 			       "security:  permission %s in class %s not found in policy\n",
 			       def_perm, pol_class);
-			return -EINVAL;
+			if (p->handle_unknown == ALLOW_UNKNOWN)
+				p->undefined_perms[class_val-1] |= perm_val;
+			else if (p->handle_unknown == REJECT_UNKNOWN)
+				return -EINVAL;
+			continue;
 		}
 		pol_val = 1 << (perdatum->value - 1);
 		if (pol_val != perm_val) {
@@ -1130,14 +1179,22 @@ static int validate_classes(struct policydb *p)
 				printk(KERN_INFO
 				       "security:  permission %s in class %s not defined in policy\n",
 				       def_perm, pol_class);
+				if (p->handle_unknown == ALLOW_UNKNOWN)
+					p->undefined_perms[class_val-1] |= (1 << j);
+				else if (p->handle_unknown == REJECT_UNKNOWN)
+					return -EINVAL;
 				continue;
 			}
 			perdatum = hashtab_search(perms->table, def_perm);
 			if (perdatum == NULL) {
-				printk(KERN_ERR
+				printk(KERN_INFO
 				       "security:  permission %s in class %s not found in policy\n",
 				       def_perm, pol_class);
-				return -EINVAL;
+				if (p->handle_unknown == ALLOW_UNKNOWN)
+					p->undefined_perms[class_val-1] |= (1 << j);
+				else if (p->handle_unknown == REJECT_UNKNOWN)
+					return -EINVAL;
+				continue;
 			}
 			if (perdatum->value != j + 1) {
 				printk(KERN_ERR



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
