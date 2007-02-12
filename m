Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l1CJgj83030778
	for <selinux@tycho.nsa.gov>; Mon, 12 Feb 2007 14:42:45 -0500
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l1CJhsWk019481
	for <selinux@tycho.nsa.gov>; Mon, 12 Feb 2007 19:43:56 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.1/8.13.1) with ESMTP id l1CJhrGV006152
	for <selinux@tycho.nsa.gov>; Mon, 12 Feb 2007 14:43:53 -0500
Received: from pobox.corp.redhat.com (pobox.corp.redhat.com [10.11.255.20])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l1CJhqXo003956
	for <selinux@tycho.nsa.gov>; Mon, 12 Feb 2007 14:43:52 -0500
Received: from vpn-15-31.rdu.redhat.com (vpn-15-31.rdu.redhat.com [10.11.15.31])
	by pobox.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l1CJhpFO018962
	for <selinux@tycho.nsa.gov>; Mon, 12 Feb 2007 14:43:51 -0500
Subject: [RFC] Ability to allow undefined permissions and classes -v2
From: Eric Paris <eparis@redhat.com>
To: selinux@tycho.nsa.gov
Content-Type: text/plain
Date: Mon, 12 Feb 2007 14:43:50 -0500
Message-Id: <1171309430.10871.2.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This an obviously incomplete second attempt at creating a mechanism to
allow permissions and classes which are defined in the kernel but not in
the policy being loaded.  It has a /selinux tunable which is used to
enable or disable the feature.  The real submission will not have this
and will instead be passed to the kernel much the same way as we pass
the MLS flag today.  So do not comment on the /selinux tunable portion
of the patch.  I also have not implemented the 3 state system (allow
unknown, deny unknown, deny policy with unknown) which was discussed,
but will do that if this method seems reasonable.

I started off doing as Stephen suggested and padding the avtab entries
with permissions which were unknown to the kernel.  But upon (completing
this implementation and then) re-reading the whole thread Stephen also
mentioned the case where NO TE rules existed but we still would want to
give a 'default' avd.allow which included undefined perms.  And when I
went back to look at this I threw out all of my previous padding at load
time.  Adding checks into context_struct_compute_av to see 'did we find
any avtab entry' appeared to me that it would take more work than simply
making the 'default' .allow created by context_struct_compute_av include
all the undefined perms.  In doing this I was able to stop padding avtab
entries on load.  Permission check time now has a single new if
statement and simple |=.  Neither of which do I guess will have
meaningful performance impact.

I do still have a problem.  I don't really understand the 'inherits'
ideas and so I'm not sure how to pad my p->undefined_perms[tclass] with
permissions which are missing in policy due to an incorrect or missing
inherits statement.  If this approach seems good and reasonable I will
try to better understand how I can glean those bits from
validate_classes() and I will also move this to use config flags and
have multiple options on how to handle policies.

Right now to make changes you need to:

echo 1 > /selinux/allow_unknown
semodule -R

-Eric

diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index cd79c63..364d872 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -670,6 +670,8 @@ void policydb_destroy(struct policydb *p)
 	}
 	kfree(p->type_attr_map);
 
+	kfree(p->undefined_perms);
+
 	return;
 }
 
diff --git a/security/selinux/ss/policydb.h b/security/selinux/ss/policydb.h
index 8319d5f..257b836 100644
--- a/security/selinux/ss/policydb.h
+++ b/security/selinux/ss/policydb.h
@@ -242,6 +242,8 @@ struct policydb {
 	struct ebitmap *type_attr_map;
 
 	unsigned int policyvers;
+
+	u32 *undefined_perms;
 };
 
 extern void policydb_destroy(struct policydb *p);
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index ca9154d..e6a60a5 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -306,22 +306,30 @@ static int context_struct_compute_av(struct context *scontext,
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
+	 * This will pad the allow for undefined perms if appropriete.
 	 */
-	avd->allowed = 0;
+	if(selinux_allow_unknown)
+		avd->allowed = policydb.undefined_perms[tclass];
+	else
+		avd->allowed = 0;
 	avd->decided = 0xffffffff;
 	avd->auditallow = 0;
 	avd->auditdeny = 0xffffffff;
 	avd->seqno = latest_granting;
 
+	if (!tclass || tclass > policydb.p_classes.nprim) {
+		if(selinux_allow_unknown && tclass) {
+			avd->allowed = 0xffffffff;
+			return 0;
+		}
+		else {
+			return -EINVAL;
+		}
+	}
+	tclass_datum = policydb.class_val_to_struct[tclass - 1];
+
 	/*
 	 * If a specific type enforcement rule was defined for
 	 * this permission check, then use it.
@@ -1037,6 +1045,7 @@ int security_change_sid(u32 ssid,
 static int validate_classes(struct policydb *p)
 {
 	int i, j;
+	int rc = 0;
 	struct class_datum *cladatum;
 	struct perm_datum *perdatum;
 	u32 nprim, tmp, common_pts_len, perm_val, pol_val;
@@ -1045,6 +1054,19 @@ static int validate_classes(struct policydb *p)
 	const char *def_class, *def_perm, *pol_class;
 	struct symtab *perms;
 
+	if (selinux_allow_unknown) {
+		int num_classes;
+		if (kdefs->cts_len > p->p_classes.nprim)
+			num_classes = kdefs->cts_len;
+		else
+			num_classes = p->p_classes.nprim;
+		p->undefined_perms = kzalloc(sizeof(u32)*num_classes, GFP_KERNEL);
+		if (!p->undefined_perms) {
+			rc = -ENOMEM;
+			goto out;
+		}
+	}
+
 	for (i = 1; i < kdefs->cts_len; i++) {
 		def_class = kdefs->class_to_string[i];
 		if (i > p->p_classes.nprim) {
@@ -1058,7 +1080,8 @@ static int validate_classes(struct policydb *p)
 			printk(KERN_ERR
 			       "security:  class %d is incorrect, found %s but should be %s\n",
 			       i, pol_class, def_class);
-			return -EINVAL;
+			rc = -EINVAL;
+			goto out;
 		}
 	}
 	for (i = 0; i < kdefs->av_pts_len; i++) {
@@ -1076,6 +1099,8 @@ static int validate_classes(struct policydb *p)
 			printk(KERN_INFO
 			       "security:  permission %s in class %s not defined in policy\n",
 			       def_perm, pol_class);
+			if (selinux_allow_unknown)
+				p->undefined_perms[class_val] |= perm_val;
 			continue;
 		}
 		perdatum = hashtab_search(perms->table, def_perm);
@@ -1083,14 +1108,16 @@ static int validate_classes(struct policydb *p)
 			printk(KERN_ERR
 			       "security:  permission %s in class %s not found in policy\n",
 			       def_perm, pol_class);
-			return -EINVAL;
+			rc = -EINVAL;
+			goto out;
 		}
 		pol_val = 1 << (perdatum->value - 1);
 		if (pol_val != perm_val) {
 			printk(KERN_ERR
 			       "security:  permission %s in class %s has incorrect value\n",
 			       def_perm, pol_class);
-			return -EINVAL;
+			rc = -EINVAL;
+			goto out;
 		}
 	}
 	for (i = 0; i < kdefs->av_inherit_len; i++) {
@@ -1104,7 +1131,8 @@ static int validate_classes(struct policydb *p)
 			printk(KERN_ERR
 			       "security:  class %s should have an inherits clause but does not\n",
 			       pol_class);
-			return -EINVAL;
+			rc = -EINVAL;
+			goto out;
 		}
 		tmp = kdefs->av_inherit[i].common_base;
 		common_pts_len = 0;
@@ -1126,17 +1154,24 @@ static int validate_classes(struct policydb *p)
 				printk(KERN_ERR
 				       "security:  permission %s in class %s not found in policy\n",
 				       def_perm, pol_class);
-				return -EINVAL;
+				rc = -EINVAL;
+				goto out;
 			}
 			if (perdatum->value != j + 1) {
 				printk(KERN_ERR
 				       "security:  permission %s in class %s has incorrect value\n",
 				       def_perm, pol_class);
-				return -EINVAL;
+				rc = -EINVAL;
+				goto out;
 			}
 		}
 	}
-	return 0;
+out:
+	if (rc && selinux_allow_unknown) {
+		kfree(p->undefined_perms);
+		p->undefined_perms = NULL;
+	}
+	return rc;
 }
 
 /* Clone the SID into the new SID table. */
@@ -1268,6 +1303,9 @@ int security_load_policy(void *data, size_t len)
 
 	LOAD_LOCK;
 
+	/* pay not attention to me as I am part of the /selinux madness!! */
+	selinux_allow_unknown = selinux_allow_unknown_sysctl_value;
+
 	if (!ss_initialized) {
 		avtab_cache_init();
 		if (policydb_read(&policydb, fp)) {
diff --git a/security/selinux/avc.c b/security/selinux/avc.c
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 65fb5e8..10af3d0 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -86,6 +86,9 @@ extern unsigned int policydb_loaded_version;
 extern int selinux_nlmsg_lookup(u16 sclass, u16 nlmsg_type, u32 *perm);
 extern int selinux_compat_net;
 
+int selinux_allow_unknown = 0;
+int selinux_allow_unknown_sysctl_value = 0;
+
 #ifdef CONFIG_SECURITY_SELINUX_DEVELOP
 int selinux_enforcing = 0;
 
diff --git a/security/selinux/include/avc.h b/security/selinux/include/avc.h
index 6ed10c3..1b02289 100644
--- a/security/selinux/include/avc.h
+++ b/security/selinux/include/avc.h
@@ -18,6 +18,9 @@
 #include "av_permissions.h"
 #include "security.h"
 
+extern int selinux_allow_unknown;
+extern int selinux_allow_unknown_sysctl_value;
+
 #ifdef CONFIG_SECURITY_SELINUX_DEVELOP
 extern int selinux_enforcing;
 #else
diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index c8bf6e1..67c7810 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -100,6 +100,7 @@ enum sel_inos {
 	SEL_MEMBER,	/* compute polyinstantiation membership decision */
 	SEL_CHECKREQPROT, /* check requested protection, not kernel-applied one */
 	SEL_COMPAT_NET,	/* whether to use old compat network packet controls */
+	SEL_UNKNOWN,	/* allows unknown perms and classes */
 };
 
 #define TMPBUFLEN	12
@@ -113,6 +114,16 @@ static ssize_t sel_read_enforce(struct file *filp, char __user *buf,
 	return simple_read_from_buffer(buf, count, ppos, tmpbuf, length);
 }
 
+static ssize_t sel_read_unknown(struct file *filp, char __user *buf,
+				size_t count, loff_t *ppos)
+{
+	char tmpbuf[TMPBUFLEN];
+	ssize_t length;
+
+	length = scnprintf(tmpbuf, TMPBUFLEN, "%d", selinux_allow_unknown_sysctl_value);
+	return simple_read_from_buffer(buf, count, ppos, tmpbuf, length);
+}
+
 #ifdef CONFIG_SECURITY_SELINUX_DEVELOP
 static ssize_t sel_write_enforce(struct file * file, const char __user * buf,
 				 size_t count, loff_t *ppos)
@@ -161,11 +172,55 @@ out:
 #define sel_write_enforce NULL
 #endif
 
+static ssize_t sel_write_unknown(struct file * file, const char __user * buf,
+				 size_t count, loff_t *ppos)
+
+{
+	char *page;
+	ssize_t length;
+	int new_value;
+
+	if (count >= PAGE_SIZE)
+		return -ENOMEM;
+	if (*ppos != 0) {
+		/* No partial writes. */
+		return -EINVAL;
+	}
+	page = (char*)get_zeroed_page(GFP_KERNEL);
+	if (!page)
+		return -ENOMEM;
+	length = -EFAULT;
+	if (copy_from_user(page, buf, count))
+		goto out;
+
+	length = -EINVAL;
+	if (sscanf(page, "%d", &new_value) != 1)
+		goto out;
+
+	if (new_value != selinux_allow_unknown_sysctl_value) {
+		length = 0;
+		audit_log(current->audit_context, GFP_KERNEL, AUDIT_MAC_STATUS,
+			"allow_unknown=%d old_allow_unknown%d auid=%u", new_value, 
+			selinux_allow_unknown_sysctl_value,
+			audit_get_loginuid(current->audit_context));
+		selinux_allow_unknown_sysctl_value = new_value;
+	}
+	length = count;
+out:
+	free_page((unsigned long) page);
+	return length;
+}
+
 static struct file_operations sel_enforce_ops = {
 	.read		= sel_read_enforce,
 	.write		= sel_write_enforce,
 };
 
+static struct file_operations sel_unknown_ops = {
+	.read		= sel_read_unknown,
+	.write		= sel_write_unknown,
+};
+
 #ifdef CONFIG_SECURITY_SELINUX_DISABLE
 static ssize_t sel_write_disable(struct file * file, const char __user * buf,
 				 size_t count, loff_t *ppos)
@@ -1283,6 +1338,7 @@ static int sel_fill_super(struct super_block * sb, void * data, int silent)
 		[SEL_MEMBER] = {"member", &transaction_ops, S_IRUGO|S_IWUGO},
 		[SEL_CHECKREQPROT] = {"checkreqprot", &sel_checkreqprot_ops, S_IRUGO|S_IWUSR},
 		[SEL_COMPAT_NET] = {"compat_net", &sel_compat_net_ops, S_IRUGO|S_IWUSR},
+		[SEL_UNKNOWN] = {"allow_unknown", &sel_unknown_ops, S_IRUGO|S_IWUSR},
 		/* last one */ {""}
 	};
 	ret = simple_fill_super(sb, SELINUX_MAGIC, selinux_files);



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
