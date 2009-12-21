Subject: [PATCH] Dynamic port labeling V3
From: Paul Nuzzi <pjnuzzi@tycho.ncsc.mil>
To: selinux@tycho.nsa.gov
Cc: Stephen Smalley <sds@tycho.nsa.gov>,
        "George S. Coker, II" <gscoker@alpha.ncsc.mil>
Content-Type: text/plain
Date: Mon, 21 Dec 2009 15:14:40 -0500
Message-Id: <1261426480.25365.42.camel@moss-stripedbass.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I reworked the patch based on Joshua's input after talking to Steve.
Instead of adding and deleting a port at a time, we can ingest all the
port labels into the kernel at once.  This takes care of any atomic
issues that were brought up.  There is no locking mechanism to handle
multiple users modifying labels.  Whoever writes last wins.
Unfortunately you can't open up the node in vi/emacs and modify it on
the fly.

Modifications can be done by saving the output of "/selinux/portcon" to
a file, modify it and then writing changes to a node.  When writing to
the node there can be no comments or newlines in the file.  If the file
consists of one newline character than all the port labels are removed.
If there is a newline in the middle of the file only the labels before
it will be ingested into the kernel.  I have preliminary patches for
userspace.  I'll look into trying to get an editor to open that lets the
user edit everything.  Let me know what you think of it and then I could
resubmit it to the kernel mailing list.

Signed-off-by: Paul Nuzzi <pjnuzzi@tycho.ncsc.mil>

--- 

 security/selinux/hooks.c            |    1
 security/selinux/include/classmap.h |    2
 security/selinux/include/security.h |    7 +
 security/selinux/selinuxfs.c        |   76 ++++++++++++++
 security/selinux/ss/services.c      |  189
++++++++++++++++++++++++++++++++++++
 5 files changed, 273 insertions(+), 2 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 7a374c2..f32bd9b 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -1224,7 +1224,6 @@ static int inode_doinit_with_dentry(struct inode *inode, struct dentry *opt_dent
 	struct inode_security_struct *isec = inode->i_security;
 	u32 sid;
 	struct dentry *dentry;
-#define INITCONTEXTLEN 255
 	char *context = NULL;
 	unsigned len = 0;
 	int rc = 0;
diff --git a/security/selinux/include/classmap.h b/security/selinux/include/classmap.h
index 8b32e95..925edb6 100644
--- a/security/selinux/include/classmap.h
+++ b/security/selinux/include/classmap.h
@@ -16,7 +16,7 @@ struct security_class_mapping secclass_map[] = {
 	  { "compute_av", "compute_create", "compute_member",
 	    "check_context", "load_policy", "compute_relabel",
 	    "compute_user", "setenforce", "setbool", "setsecparam",
-	    "setcheckreqprot", NULL } },
+	    "setcheckreqprot", "portcon", NULL } },
 	{ "process",
 	  { "fork", "transition", "sigchld", "sigkill",
 	    "sigstop", "signull", "signal", "ptrace", "getsched", "setsched",
diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
index 2553266..c196ef1 100644
--- a/security/selinux/include/security.h
+++ b/security/selinux/include/security.h
@@ -169,6 +169,13 @@ int security_fs_use(const char *fstype, unsigned int *behavior,
 int security_genfs_sid(const char *fstype, char *name, u16 sclass,
 	u32 *sid);
 
+int security_ocon_port_write(char *buf);
+int security_ocon_port_read(char **buf);
+#define INITCONTEXTLEN 255
+#define OCON_TCP_STR "tcp"
+#define OCON_UDP_STR "udp"
+#define OCON_MAX_PROTOCOL_STR 4
+
 #ifdef CONFIG_NETLABEL
 int security_netlbl_secattr_to_sid(struct netlbl_lsm_secattr *secattr,
 				   u32 *sid);
diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index fab36fd..5d3bc7b 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -110,6 +110,7 @@ enum sel_inos {
 	SEL_COMPAT_NET,	/* whether to use old compat network packet controls */
 	SEL_REJECT_UNKNOWN, /* export unknown reject handling to userspace */
 	SEL_DENY_UNKNOWN, /* export unknown deny handling to userspace */
+	SEL_OCON_PORT,  /* add OCON_PORT to the list */
 	SEL_INO_NEXT,	/* The next inode number to use */
 };
 
@@ -253,6 +254,80 @@ static const struct file_operations sel_disable_ops = {
 	.write		= sel_write_disable,
 };
 
+static ssize_t sel_write_ocon_port(struct file *file, const char __user *buf,
+				 size_t count, loff_t *ppos)
+{
+	ssize_t length;
+	char *data;
+#define OCON_PAGE_MAX 16
+
+	mutex_lock(&sel_mutex);
+
+	length = task_has_security(current, SECURITY__PORTCON);
+	if (length) {
+		mutex_unlock(&sel_mutex);
+		return length;
+	}
+
+	if (count > (PAGE_SIZE * OCON_PAGE_MAX) - 1) {
+		mutex_unlock(&sel_mutex);
+		return -EINVAL;
+	}
+	if (*ppos != 0) {
+		/* No partial writes. */
+		mutex_unlock(&sel_mutex);
+		return -EINVAL;
+	}
+
+	data = vmalloc(count + 1);
+	if (!data) {
+		mutex_unlock(&sel_mutex);
+		return -ENOMEM;
+	}
+	memset(data, 0, count + 1);
+
+	length = -EFAULT;
+	if (copy_from_user(data, buf, count) != 0)
+		goto out;
+
+	length = security_ocon_port_write(data);
+	if (length < 0)
+		goto out;
+	length = count;
+out:
+	vfree(data);
+	mutex_unlock(&sel_mutex);
+	return length;
+}
+
+static ssize_t sel_read_ocon_port(struct file *filp, char __user *buf,
+				   size_t count, loff_t *ppos)
+{
+	ssize_t length;
+	char *buf_tmp = NULL;
+
+	mutex_lock(&sel_mutex);
+	length = task_has_security(current, SECURITY__PORTCON);
+	if (length) {
+		mutex_unlock(&sel_mutex);
+		return length;
+	}
+
+	length = security_ocon_port_read(&buf_tmp);
+	if (length > 0) {
+		length = simple_read_from_buffer(buf, count, ppos, buf_tmp,
+						 length);
+		vfree(buf_tmp);
+	}
+	mutex_unlock(&sel_mutex);
+	return length;
+}
+
+static const struct file_operations sel_ocon_port_ops = {
+	.write		= sel_write_ocon_port,
+	.read		= sel_read_ocon_port,
+};
+
 static ssize_t sel_read_policyvers(struct file *filp, char __user *buf,
 				   size_t count, loff_t *ppos)
 {
@@ -1596,6 +1671,7 @@ static int sel_fill_super(struct super_block *sb, void *data, int silent)
 		[SEL_CHECKREQPROT] = {"checkreqprot", &sel_checkreqprot_ops, S_IRUGO|S_IWUSR},
 		[SEL_REJECT_UNKNOWN] = {"reject_unknown", &sel_handle_unknown_ops, S_IRUGO},
 		[SEL_DENY_UNKNOWN] = {"deny_unknown", &sel_handle_unknown_ops, S_IRUGO},
+		[SEL_OCON_PORT] = {"portcon", &sel_ocon_port_ops, S_IRUSR|S_IWUSR},
 		/* last one */ {""}
 	};
 	ret = simple_fill_super(sb, SELINUX_MAGIC, selinux_files);
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index 07ddc81..fbbccd2 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -1838,6 +1838,195 @@ err:
 
 }
 
+int security_ocon_port_write(char *buf)
+{
+	int seqno = 0, rc = 0;
+	char *line;
+	char scontext[INITCONTEXTLEN + 1], protocol[OCON_MAX_PROTOCOL_STR];
+	unsigned int low_port, high_port, line_num = 0;
+	struct ocontext *new_list = NULL, **new_list_head = NULL,
+			 *old_list = NULL, *c = NULL;
+	u32 sid;
+	struct context ctx;
+
+	read_lock(&policy_rwlock);
+	while ((line = strsep(&buf, "\n")) != NULL) {
+		line_num++;
+		if (strcmp(line, "") == 0)
+			break;
+
+		if (sscanf(line, "%3s %u-%u %255s",
+			   protocol, &low_port, &high_port, scontext) != 4) {
+			rc = -EINVAL;
+			goto out;
+		}
+		c = kzalloc(sizeof(struct ocontext), GFP_KERNEL);
+		if (!c) {
+			rc = -ENOMEM;
+			goto out;
+		}
+
+		if (low_port > high_port) {
+			rc = -EINVAL;
+			goto out1;
+		}
+		if (low_port >= 65536 || high_port >= 65536) {
+			rc = -EINVAL;
+			goto out1;
+		}
+		c->u.port.low_port = low_port;
+		c->u.port.high_port = high_port;
+
+		if (strcmp(protocol, OCON_TCP_STR) == 0)
+			c->u.port.protocol = IPPROTO_TCP;
+		else if (strcmp(protocol, OCON_UDP_STR) == 0)
+			c->u.port.protocol = IPPROTO_UDP;
+		else {
+			rc = -EINVAL;
+			goto out1;
+		}
+
+		rc = security_context_to_sid(scontext, strlen(scontext), &sid);
+		if (rc < 0) {
+			rc = -EINVAL;
+			goto out1;
+		}
+		c->sid[0] = sid;
+
+		rc = string_to_context_struct(&policydb, &sidtab, scontext,
+					 strlen(scontext), &ctx, sid);
+		if (rc) {
+			rc = -EINVAL;
+			goto out1;
+		}
+		c->context[0] = ctx;
+
+		if (!new_list) {
+			new_list = c;
+			new_list_head = &new_list;
+		} else {
+			(*new_list_head)->next = c;
+			new_list_head = &(*new_list_head)->next;
+		}
+
+	}
+	read_unlock(&policy_rwlock);
+
+	write_lock_irq(&policy_rwlock);
+	old_list = policydb.ocontexts[OCON_PORT];
+	policydb.ocontexts[OCON_PORT] = new_list;
+	write_unlock_irq(&policy_rwlock);
+
+	seqno = ++latest_granting;
+	avc_ss_reset(seqno);
+
+	while (old_list) {
+		context_destroy(&old_list->context[0]);
+		new_list_head = &old_list;
+		old_list = old_list->next;
+		kfree(*new_list_head);
+	}
+	rc = 0;
+
+	return rc;
+
+ out1:
+	kfree(c);
+ out:
+	read_unlock(&policy_rwlock);
+	printk(KERN_DEBUG "SELinux: Invalid line #%i \"%s\"\n", line_num,
+		 line);
+	while (new_list) {
+		context_destroy(&new_list->context[0]);
+		new_list_head = &new_list;
+		new_list = new_list->next;
+		kfree(*new_list_head);
+	}
+	return rc;
+}
+
+int security_ocon_port_read(char **buf)
+{
+	unsigned int buf_size = 0, addline_size = 0, len;
+	struct ocontext *c;
+	char *scontext, protocol_str[OCON_MAX_PROTOCOL_STR];
+	char *buf_tmp = NULL, *buf_ptr = NULL;
+	int rc = 0;
+	int line_size = (sizeof(unsigned int) * 2) + (sizeof(char) * 4) +
+			 OCON_MAX_PROTOCOL_STR;
+	int max_line_size = line_size + INITCONTEXTLEN;
+	char addline[max_line_size];
+
+	/* protocol low-high scontext */
+	read_lock(&policy_rwlock);
+	if (policydb.ocontexts[OCON_PORT] == NULL)
+		goto out;
+
+	for (c = policydb.ocontexts[OCON_PORT]; c; c = c->next) {
+		rc = context_struct_to_string(&(c->context[0]), &scontext,
+					      &len);
+		if (rc < 0) {
+			rc = -EINVAL;
+			goto out;
+		}
+		buf_size += line_size + strlen(scontext);
+		kfree(scontext);
+	}
+
+	buf_ptr = (char *) vmalloc(buf_size + 1);
+	if (!buf_ptr) {
+		rc = -ENOMEM;
+		goto out;
+	}
+	memset(buf_ptr, 0, buf_size + 1);
+	buf_tmp = buf_ptr;
+
+	for (c = policydb.ocontexts[OCON_PORT]; c; c = c->next) {
+		rc = context_struct_to_string(&(c->context[0]), &scontext,
+					      &len);
+		if (rc < 0) {
+			vfree(buf_ptr);
+			rc = -EINVAL;
+			goto out;
+		}
+		if (len > INITCONTEXTLEN) {
+			vfree(buf_ptr);
+			kfree(scontext);
+			rc = -EOVERFLOW;
+			goto out;
+		}
+		if (c->u.port.protocol == IPPROTO_TCP)
+			strcpy(protocol_str, OCON_TCP_STR);
+		else if (c->u.port.protocol == IPPROTO_UDP)
+			strcpy(protocol_str, OCON_UDP_STR);
+		else {
+			vfree(buf_ptr);
+			kfree(scontext);
+			rc = -EINVAL;
+			goto out;
+		}
+		snprintf(addline, max_line_size, "%s %u-%u %s\n",
+			protocol_str, c->u.port.low_port,
+			c->u.port.high_port, scontext);
+		addline_size = strlen(addline);
+		kfree(scontext);
+		if (buf_tmp + addline_size < buf_ptr + buf_size)
+			strcpy(buf_tmp, addline);
+		else {
+			vfree(buf_ptr);
+			rc = -EOVERFLOW;
+			goto out;
+		}
+		buf_tmp += addline_size;
+	}
+
+	*buf = buf_ptr;
+	rc = strlen(buf_ptr);
+out:
+	read_unlock(&policy_rwlock);
+	return rc;
+}
+
 /**
  * security_port_sid - Obtain the SID for a port.
  * @protocol: protocol number



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
