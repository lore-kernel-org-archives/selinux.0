Subject: [PATCH] selinuxfs to globally disable dontaudit rules
From: Eric Paris <eparis@redhat.com>
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov, jmorris@namei.org, dwalsh@redhat.com
Content-Type: text/plain
Date: Thu, 09 Aug 2007 17:58:57 -0400
Message-Id: <1186696737.20393.10.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Currently to disable dontaudit rules best you can do it to load the
enableaudit.pp base policy.  Which still doesn't remove the dontaudit
rules from modules.  This patch introduces a /selinux interface
"allaudit" which ignores dontaudit rules.  (I'm open to suggestions for
a good name 'enabledisabledontaudit' seemed like a good name to me, but
I don't know if everyone would agree)

I decided to use the same security permission as setenforce and as a
result did a little bit of code merging in selinuxfs between enforcing
and allaudit.

Signed-off-by: Eric Paris <eparis@redhat.com>

---

diff --git a/security/selinux/avc.c b/security/selinux/avc.c
index 0e69adf..bfd979a 100644
--- a/security/selinux/avc.c
+++ b/security/selinux/avc.c
@@ -117,6 +117,7 @@ struct avc_callback_node {
 
 /* Exported via selinufs */
 unsigned int avc_cache_threshold = AVC_DEF_CACHE_THRESHOLD;
+unsigned int selinux_allaudit = 0;
 
 #ifdef CONFIG_SECURITY_SELINUX_AVC_STATS
 DEFINE_PER_CPU(struct avc_cache_stats, avc_cache_stats) = { 0 };
@@ -537,7 +538,7 @@ void avc_audit(u32 ssid, u32 tsid,
 	denied = requested & ~avd->allowed;
 	if (denied) {
 		audited = denied;
-		if (!(audited & avd->auditdeny))
+		if (!(audited & avd->auditdeny) && !selinux_allaudit)
 			return;
 	} else if (result) {
 		audited = denied = requested;
diff --git a/security/selinux/include/avc.h b/security/selinux/include/avc.h
index e145f6e..99b31ec 100644
--- a/security/selinux/include/avc.h
+++ b/security/selinux/include/avc.h
@@ -130,6 +130,7 @@ int avc_add_callback(int (*callback)(u32 event, u32 ssid, u32 tsid,
 /* Exported to selinuxfs */
 int avc_get_hash_stats(char *page);
 extern unsigned int avc_cache_threshold;
+extern unsigned int selinux_allaudit;
 
 #ifdef CONFIG_SECURITY_SELINUX_AVC_STATS
 DECLARE_PER_CPU(struct avc_cache_stats, avc_cache_stats);
diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index c9e92da..89f11b9 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -60,6 +60,14 @@ static int __init selinux_compat_net_setup(char *str)
 __setup("selinux_compat_net=", selinux_compat_net_setup);
 
 
+static int __init selinux_allaudit_setup(char *str)
+{
+	selinux_allaudit = simple_strtoul(str,NULL,0) ? 1 : 0;
+	return 1;
+}
+__setup("selinux_allaudit=", selinux_allaudit_setup);
+
+
 static DEFINE_MUTEX(sel_mutex);
 
 /* global data for booleans */
@@ -103,6 +111,7 @@ enum sel_inos {
 	SEL_MEMBER,	/* compute polyinstantiation membership decision */
 	SEL_CHECKREQPROT, /* check requested protection, not kernel-applied one */
 	SEL_COMPAT_NET,	/* whether to use old compat network packet controls */
+	SEL_ALLAUDIT,	/* globally disable donaudit */
 	SEL_INO_NEXT,	/* The next inode number to use */
 };
 
@@ -114,19 +123,31 @@ static unsigned long sel_last_ino = SEL_INO_NEXT - 1;
 #define SEL_INO_MASK		0x00ffffff
 
 #define TMPBUFLEN	12
-static ssize_t sel_read_enforce(struct file *filp, char __user *buf,
-				size_t count, loff_t *ppos)
+static ssize_t sel_read_generic(struct file *filp, char __user *buf,
+				size_t count, loff_t *ppos, int *to_change)
 {
 	char tmpbuf[TMPBUFLEN];
 	ssize_t length;
 
-	length = scnprintf(tmpbuf, TMPBUFLEN, "%d", selinux_enforcing);
+	length = scnprintf(tmpbuf, TMPBUFLEN, "%d", *to_change);
 	return simple_read_from_buffer(buf, count, ppos, tmpbuf, length);
 }
 
+static ssize_t sel_read_enforce(struct file *filp, char __user *buf,
+				size_t count, loff_t *ppos)
+{
+	return sel_read_generic(filp, buf, count, ppos, &selinux_enforcing);
+}
+
+static ssize_t sel_read_allaudit(struct file *filp, char __user *buf,
+				size_t count, loff_t *ppos)
+{
+	return sel_read_generic(filp, buf, count, ppos, &selinux_allaudit);
+}
+
 #ifdef CONFIG_SECURITY_SELINUX_DEVELOP
-static ssize_t sel_write_enforce(struct file * file, const char __user * buf,
-				 size_t count, loff_t *ppos)
+static ssize_t sel_write_enforce_generic(struct file * file, const char __user * buf,
+				 size_t count, loff_t *ppos, int *to_change)
 
 {
 	char *page;
@@ -150,26 +171,58 @@ static ssize_t sel_write_enforce(struct file * file, const char __user * buf,
 	if (sscanf(page, "%d", &new_value) != 1)
 		goto out;
 
-	if (new_value != selinux_enforcing) {
+	if (new_value != *to_change) {
 		length = task_has_security(current, SECURITY__SETENFORCE);
 		if (length)
 			goto out;
+		*to_change = new_value;
+	}
+	length = count;
+out:
+	free_page((unsigned long) page);
+	return length;
+}
+
+static ssize_t sel_write_enforce(struct file * file, const char __user * buf,
+				 size_t count, loff_t *ppos)
+
+{
+	int old_value = selinux_enforcing;
+
+	int rc = sel_write_enforce_generic(file, buf, count, ppos,
+					   &selinux_enforcing);
+
+	if ((rc > 0) && (old_value != selinux_enforcing)) {
 		audit_log(current->audit_context, GFP_KERNEL, AUDIT_MAC_STATUS,
-			"enforcing=%d old_enforcing=%d auid=%u", new_value, 
-			selinux_enforcing,
+			"enforcing=%d old_enforcing=%d auid=%u",
+			selinux_enforcing, old_value,
 			audit_get_loginuid(current->audit_context));
-		selinux_enforcing = new_value;
 		if (selinux_enforcing)
 			avc_ss_reset(0);
 		selnl_notify_setenforce(selinux_enforcing);
 	}
-	length = count;
-out:
-	free_page((unsigned long) page);
-	return length;
+	return rc;
+}
+
+static ssize_t sel_write_allaudit(struct file * file, const char __user * buf,
+				 size_t count, loff_t *ppos)
+
+{
+	int old_value = selinux_allaudit;
+
+	int rc = sel_write_enforce_generic(file, buf, count, ppos,
+					   &selinux_allaudit);
+
+	if ((rc > 0) && (old_value != selinux_allaudit))
+		audit_log(current->audit_context, GFP_KERNEL, AUDIT_MAC_STATUS,
+			"allaudit=%d old_allaudit=%d auid=%u",
+			selinux_allaudit, old_value,
+			audit_get_loginuid(current->audit_context));
+	return rc;
 }
 #else
 #define sel_write_enforce NULL
+#define sel_write_allaudit NULL
 #endif
 
 static const struct file_operations sel_enforce_ops = {
@@ -177,6 +230,11 @@ static const struct file_operations sel_enforce_ops = {
 	.write		= sel_write_enforce,
 };
 
+static const struct file_operations sel_allaudit_ops = {
+	.read		= sel_read_allaudit,
+	.write		= sel_write_allaudit,
+};
+
 #ifdef CONFIG_SECURITY_SELINUX_DISABLE
 static ssize_t sel_write_disable(struct file * file, const char __user * buf,
 				 size_t count, loff_t *ppos)
@@ -1575,6 +1633,7 @@ static int sel_fill_super(struct super_block * sb, void * data, int silent)
 		[SEL_MEMBER] = {"member", &transaction_ops, S_IRUGO|S_IWUGO},
 		[SEL_CHECKREQPROT] = {"checkreqprot", &sel_checkreqprot_ops, S_IRUGO|S_IWUSR},
 		[SEL_COMPAT_NET] = {"compat_net", &sel_compat_net_ops, S_IRUGO|S_IWUSR},
+		[SEL_ALLAUDIT] = {"allaudit", &sel_allaudit_ops, S_IRUGO|S_IWUSR},
 		/* last one */ {""}
 	};
 	ret = simple_fill_super(sb, SELINUX_MAGIC, selinux_files);



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
