Received: from facesaver.epoch.ncsc.mil (facesaver [144.51.25.10])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m5BEjmeq009005
	for <selinux@tycho.nsa.gov>; Wed, 11 Jun 2008 10:45:48 -0400
Subject: SELINUX: Add interface to compute MLS dominance relationship.
From: Dave Quigley <dpquigl@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Cc: Joshua Brindle <method@manicmethod.com>, bwhalen@tresys.com
In-Reply-To: <1213194852.16897.60.camel@moss-terrapins.epoch.ncsc.mil>
References: <1213194852.16897.60.camel@moss-terrapins.epoch.ncsc.mil>
Content-Type: text/plain
Date: Wed, 11 Jun 2008 10:37:12 -0400
Message-Id: <1213195032.16897.62.camel@moss-terrapins.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This patch adds a new entry into selinuxfs and the backing function to allow
userspace to request the dominance relationship of two mls labels. The new
entry uses the standard transactional interface that the other computer fields
use.

diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
index ad30ac4..453aad5 100644
--- a/security/selinux/include/security.h
+++ b/security/selinux/include/security.h
@@ -133,6 +133,8 @@ int security_get_allow_unknown(void);
 int security_fs_use(const char *fstype, unsigned int *behavior,
 	u32 *sid);
 
+int selinux_context_dom(u32 ctxid1, u32 ctxid2, u32 *result);
+
 int security_genfs_sid(const char *fstype, char *name, u16 sclass,
 	u32 *sid);
 
diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index ac1ccc1..bc3cb96 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -119,6 +119,7 @@ enum sel_inos {
 	SEL_COMPAT_NET,	/* whether to use old compat network packet controls */
 	SEL_REJECT_UNKNOWN, /* export unknown reject handling to userspace */
 	SEL_DENY_UNKNOWN, /* export unknown deny handling to userspace */
+	SEL_CONTEXT_DOM, /* compute dominance of two contexts */
 	SEL_INO_NEXT,	/* The next inode number to use */
 };
 
@@ -509,6 +510,7 @@ static ssize_t sel_write_create(struct file *file, char *buf, size_t size);
 static ssize_t sel_write_relabel(struct file *file, char *buf, size_t size);
 static ssize_t sel_write_user(struct file *file, char *buf, size_t size);
 static ssize_t sel_write_member(struct file *file, char *buf, size_t size);
+static ssize_t sel_write_context_dom(struct file *file, char *buf, size_t size);
 
 static ssize_t (*write_op[])(struct file *, char *, size_t) = {
 	[SEL_ACCESS] = sel_write_access,
@@ -517,6 +519,7 @@ static ssize_t (*write_op[])(struct file *, char *, size_t) = {
 	[SEL_USER] = sel_write_user,
 	[SEL_MEMBER] = sel_write_member,
 	[SEL_CONTEXT] = sel_write_context,
+	[SEL_CONTEXT_DOM] = sel_write_context_dom,
 };
 
 static ssize_t selinux_transaction_write(struct file *file, const char __user *buf, size_t size, loff_t *pos)
@@ -837,6 +840,45 @@ out:
 	return length;
 }
 
+static ssize_t sel_write_context_dom(struct file * file, char *buf, size_t size)
+{
+	char *scon1, *scon2;
+	u32 ssid1, ssid2, result;
+	ssize_t length;
+
+	length = task_has_security(current, SECURITY__CHECK_CONTEXT);
+	if (length)
+		return length;
+
+	length = -ENOMEM;
+	scon1 = kzalloc(size+1, GFP_KERNEL);
+	if (!scon1)
+		return length;
+
+	scon2 = kzalloc(size+1, GFP_KERNEL);
+	if (!scon2)
+		goto out;
+
+	length = -EINVAL;
+	if (sscanf(buf, "%s %s", scon1, scon2) != 2)
+		goto out2;
+	length = security_context_to_sid(scon1, strlen(scon1)+1, &ssid1);
+	if (length < 0)
+		goto out2;
+	length = security_context_to_sid(scon2, strlen(scon2)+1, &ssid2);
+	if (length < 0)
+		goto out2;
+	length = selinux_context_dom(ssid1, ssid2, &result);
+	if (length < 0)
+		goto out2;
+	length = scnprintf(buf, SIMPLE_TRANSACTION_LIMIT, "%d", result);
+out2:
+	kfree(scon2);
+out:
+	kfree(scon1);
+	return length;
+}
+
 static struct inode *sel_make_inode(struct super_block *sb, int mode)
 {
 	struct inode *ret = new_inode(sb);
@@ -1666,6 +1708,7 @@ static int sel_fill_super(struct super_block *sb, void *data, int silent)
 		[SEL_COMPAT_NET] = {"compat_net", &sel_compat_net_ops, S_IRUGO|S_IWUSR},
 		[SEL_REJECT_UNKNOWN] = {"reject_unknown", &sel_handle_unknown_ops, S_IRUGO},
 		[SEL_DENY_UNKNOWN] = {"deny_unknown", &sel_handle_unknown_ops, S_IRUGO},
+		[SEL_CONTEXT_DOM] = {"contexT_dom", &transaction_ops, S_IRUGO|S_IWUGO},
 		/* last one */ {""}
 	};
 	ret = simple_fill_super(sb, SELINUX_MAGIC, selinux_files);
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index dcc2e1c..c6e3e45 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -1752,6 +1752,55 @@ out:
 }
 
 /**
+ * selinux_context_dom - check which of two ctxids dominates another
+ * @ctxid1: first ctxid to check
+ * @ctxid2: second ctxid to check
+ * @result: result form the checl
+ *
+ * Perform a check to see which security context
+ * dominantes the two passed in. -1, 0, 1 placed in result
+ * for ctxid2 dominating ctxid1, ctxid1 and ctxid2 being equal,
+ * and ctxid1 dominating ctxid2 respectivly. The mls level checked
+ * is the lower of the two in the range.
+ */
+int selinux_context_dom(u32 ctxid1, u32 ctxid2, u32 *result)
+{
+	struct context *ctxt1, *ctxt2;
+	struct mls_level *level1, *level2;
+	int ret = 0;
+
+	//Grab contexts from sids
+	ctxt1 = sidtab_search(&sidtab, ctxid1);
+	if (!ctxt1) {
+		ret = -ENOENT;
+		goto out;
+	}
+	ctxt2 = sidtab_search(&sidtab, ctxid2);
+	if (!ctxt2) {
+		ret = -ENOENT;
+		goto out;
+	}
+	level1 = &ctxt1->range.level[0];
+	level2 = &ctxt2->range.level[0];
+
+	if(mls_level_eq(level1, level2)) {
+		*result = 0;
+		goto out;
+	}
+	if(mls_level_dom(level1, level2)) {
+		*result = 1;
+		goto out;
+	}
+	if (mls_level_dom(level2, level1)) {
+		*result = -1;
+		goto out;
+	}
+	*result = 0;
+out:
+	return ret;
+}
+
+/**
  * security_genfs_sid - Obtain a SID for a file in a filesystem
  * @fstype: filesystem type
  * @path: path from root of mount


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
