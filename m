Subject: [RFC] Ability to allow undefined permissions and classes -v3
From: Eric Paris <eparis@redhat.com>
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov, jmorris@namei.org, csellers@tresys.com
Content-Type: text/plain
Date: Wed, 25 Apr 2007 17:39:31 -0400
Message-Id: <1177537171.4221.25.camel@dhcp59-235.rdu.redhat.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

After many months this RFC is back again!  Still has the selinuxfs
boolean to turn it on and off that will get changed to a policy option
when the actual functionality seems reasonable to everyone.  The only
change between -v2 and -v3 is in context_struct_compute_av().  In wake
of the last discussion I had to make the class checking more stringent
so I wouldn't be allowing userspace classes.  Previously the decision
for an 'unknown class' was anything larger than the last defined in
policy.  Now it should be a bit more kernel specific and should check

less than policy
greater than policy but less than number of kernel classes
greater than policy and greater than number of kernel classes

less than policy means it is defined in policy and so just deal with the
permissions.  greater than both means its invalid.  So the case in the
middle is interesting if the request is actually 'hole' in the kernel
defs because of the removal of userspace classes.  So that check makes
it a little more complex.  Until the userspace class definitions
actually turn to NULL in kernel this isn't 'perfect' and might mistake a
userspace class for a kernel class but that should only temporarily
(until the classes are actually gone which will likely be the case when
this patch is applied) affect selinuxfs answers.

I think what this means though is that I don't need a special call from
selinuxfs to answer access questions.  If the request from selinuxfs is
asking about kernel permissions it will get exactly the answer the
kernel would have made.  If the check is about userspace permissions it
will answer as best the policy knows but the 'allow unknown' stuff won't
change that answer since it only mucks with things defined by the kdefs.

I do have a question if my method of storing an array of size
kdefs->cts_len is going to work going forward.  How is the policy going
to grow?  Will we have gaps of potentially hundreds of classes and then
add a new kernel class?  If so I will have a large waste in my array.
Its already the case that this proposed array is wasting space for all
of the userspace classes as it stands.

-Eric

 security/selinux/hooks.c       |    2 +
 security/selinux/include/avc.h |    2 +
 security/selinux/selinuxfs.c   |   56 +++++++++++++++++++++++++++++++++
 security/selinux/ss/policydb.c |    2 +
 security/selinux/ss/policydb.h |    2 +
 security/selinux/ss/services.c |   68 +++++++++++++++++++++++++++++++++------
 6 files changed, 121 insertions(+), 11 deletions(-)

diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index 0ac1021..92316c7 100644
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
index 1e52356..03728fa 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -59,6 +59,7 @@
 
 extern void selnl_notify_policyload(u32 seqno);
 unsigned int policydb_loaded_version;
+int selinux_allow_unknown = 0;
 
 /*
  * This is declared in avc.c
@@ -293,6 +294,7 @@ static int context_struct_compute_av(struct context *scontext,
 	struct class_datum *tclass_datum;
 	struct ebitmap *sattr, *tattr;
 	struct ebitmap_node *snode, *tnode;
+	const struct selinux_class_perm *kdefs = &selinux_class_perm;
 	unsigned int i, j;
 
 	/*
@@ -306,13 +308,6 @@ static int context_struct_compute_av(struct context *scontext,
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
@@ -323,6 +318,39 @@ static int context_struct_compute_av(struct context *scontext,
 	avd->seqno = latest_granting;
 
 	/*
+	 * Check if the class in question is a kernel class and if it
+	 * is defined in policy.  If yes to both it will pad the allow
+	 * for undefined perms if appropriete.
+	 */
+	if (unlikely(!tclass)) {
+		printk(KERN_ERR "security_compute_av:  unrecognized class 0");
+		return -EINVAL;
+	}
+	if (unlikely(tclass > policydb.p_classes.nprim)) {
+		if (tclass > kdefs->cts_len || !selinux_allow_unknown) {
+			printk(KERN_ERR "security_compute_av:  unrecognized ",
+				"class %d\n", tclass);
+			return -EINVAL;
+		} else {
+			/* 
+			 * kernel class not in policy, but we
+			 * allow uknown, so let everything through
+			 */
+			avd->allowed = 0xffffffff;
+			return 0;
+		}
+	} else
+		if (tclass < kdefs->cts_len && selinux_allow_unknown)
+			/* 
+			 * kernel class, defined in policy, allow unknown.
+			 * might have undefined permissions, so default 
+			 * those perms to allow
+			 */
+			avd->allowed = policydb.undefined_perms[tclass - 1];
+
+	tclass_datum = policydb.class_val_to_struct[tclass - 1];
+
+	/*
 	 * If a specific type enforcement rule was defined for
 	 * this permission check, then use it.
 	 */
@@ -1048,6 +1076,13 @@ static int validate_classes(struct policydb *p)
 	const char *def_class, *def_perm, *pol_class;
 	struct symtab *perms;
 
+	if (selinux_allow_unknown) {
+		u32 num_classes = kdefs->cts_len;
+		p->undefined_perms = kzalloc(sizeof(u32)*num_classes, GFP_KERNEL);
+		if (!p->undefined_perms)
+			return -ENOMEM;
+	}
+
 	for (i = 1; i < kdefs->cts_len; i++) {
 		def_class = kdefs->class_to_string[i];
 		if (i > p->p_classes.nprim) {
@@ -1079,14 +1114,18 @@ static int validate_classes(struct policydb *p)
 			printk(KERN_INFO
 			       "security:  permission %s in class %s not defined in policy\n",
 			       def_perm, pol_class);
+			if (selinux_allow_unknown)
+				p->undefined_perms[class_val-1] |= perm_val;
 			continue;
 		}
 		perdatum = hashtab_search(perms->table, def_perm);
 		if (perdatum == NULL) {
-			printk(KERN_ERR
+			printk(KERN_INFO
 			       "security:  permission %s in class %s not found in policy\n",
 			       def_perm, pol_class);
-			return -EINVAL;
+			if (selinux_allow_unknown)
+				p->undefined_perms[class_val-1] |= perm_val;
+			continue;
 		}
 		pol_val = 1 << (perdatum->value - 1);
 		if (pol_val != perm_val) {
@@ -1122,14 +1161,18 @@ static int validate_classes(struct policydb *p)
 				printk(KERN_INFO
 				       "security:  permission %s in class %s not defined in policy\n",
 				       def_perm, pol_class);
+				if (selinux_allow_unknown)
+					p->undefined_perms[class_val-1] |= (1 << j);
 				continue;
 			}
 			perdatum = hashtab_search(perms->table, def_perm);
 			if (perdatum == NULL) {
-				printk(KERN_ERR
+				printk(KERN_INFO
 				       "security:  permission %s in class %s not found in policy\n",
 				       def_perm, pol_class);
-				return -EINVAL;
+				if (selinux_allow_unknown)
+					p->undefined_perms[class_val-1] |= (1 << j);
+				continue;
 			}
 			if (perdatum->value != j + 1) {
 				printk(KERN_ERR
@@ -1271,6 +1314,9 @@ int security_load_policy(void *data, size_t len)
 
 	LOAD_LOCK;
 
+	/* pay not attention to me as I am part of the /selinux madness!! */
+	selinux_allow_unknown = selinux_allow_unknown_sysctl_value;
+
 	if (!ss_initialized) {
 		avtab_cache_init();
 		if (policydb_read(&policydb, fp)) {
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index d41e24d..dafff79 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -86,6 +86,8 @@ extern unsigned int policydb_loaded_version;
 extern int selinux_nlmsg_lookup(u16 sclass, u16 nlmsg_type, u32 *perm);
 extern int selinux_compat_net;
 
+int selinux_allow_unknown_sysctl_value = 0;
+
 #ifdef CONFIG_SECURITY_SELINUX_DEVELOP
 int selinux_enforcing = 0;
 
diff --git a/security/selinux/include/avc.h b/security/selinux/include/avc.h
index 6ed10c3..27f96ae 100644
--- a/security/selinux/include/avc.h
+++ b/security/selinux/include/avc.h
@@ -18,6 +18,8 @@
 #include "av_permissions.h"
 #include "security.h"
 
+extern int selinux_allow_unknown_sysctl_value;
+
 #ifdef CONFIG_SECURITY_SELINUX_DEVELOP
 extern int selinux_enforcing;
 #else
diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index 93b3177..ca39ca4 100644
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
 static const struct file_operations sel_enforce_ops = {
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
