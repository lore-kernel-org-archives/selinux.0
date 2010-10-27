From: Eric Paris <eparis@redhat.com>
Subject: [PATCH 2/4] SELinux: standardize return code handling in selinuxfs.c
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov, jmorris@namei.org
Date: Wed, 27 Oct 2010 13:31:53 -0400
Message-ID: <20101027173153.22048.30130.stgit@paris.rdu.redhat.com>
In-Reply-To: <20101027173146.22048.82500.stgit@paris.rdu.redhat.com>
References: <20101027173146.22048.82500.stgit@paris.rdu.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

selinuxfs.c has lots of different standards on how to handle return paths on
error.  For the most part transition to

	rc=errno
	if (failure)
		goto out;
[...]
out:
	cleanup()
	return rc;

Instead of doing cleanup mid function, or having multiple returns or other
options.  This doesn't do that for every function, but most of the complex
functions which have cleanup routines on error.

Signed-off-by: Eric Paris <eparis@redhat.com>
---

 security/selinux/selinuxfs.c |  648 ++++++++++++++++++++----------------------
 1 files changed, 311 insertions(+), 337 deletions(-)

diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index 87e0556..8710d7a 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -141,19 +141,24 @@ static ssize_t sel_write_enforce(struct file *file, const char __user *buf,
 				 size_t count, loff_t *ppos)
 
 {
-	char *page;
+	char *page = NULL;
 	ssize_t length;
 	int new_value;
 
+	length = -ENOMEM;
 	if (count >= PAGE_SIZE)
-		return -ENOMEM;
-	if (*ppos != 0) {
-		/* No partial writes. */
-		return -EINVAL;
-	}
+		goto out;
+
+	/* No partial writes. */
+	length = EINVAL;
+	if (*ppos != 0)
+		goto out;
+
+	length = -ENOMEM;
 	page = (char *)get_zeroed_page(GFP_KERNEL);
 	if (!page)
-		return -ENOMEM;
+		goto out;
+
 	length = -EFAULT;
 	if (copy_from_user(page, buf, count))
 		goto out;
@@ -268,20 +273,25 @@ static ssize_t sel_write_disable(struct file *file, const char __user *buf,
 				 size_t count, loff_t *ppos)
 
 {
-	char *page;
+	char *page = NULL;
 	ssize_t length;
 	int new_value;
 	extern int selinux_disable(void);
 
+	length = -ENOMEM;
 	if (count >= PAGE_SIZE)
-		return -ENOMEM;
-	if (*ppos != 0) {
-		/* No partial writes. */
-		return -EINVAL;
-	}
+		goto out;;
+
+	/* No partial writes. */
+	length = -EINVAL;
+	if (*ppos != 0)
+		goto out;
+
+	length = -ENOMEM;
 	page = (char *)get_zeroed_page(GFP_KERNEL);
 	if (!page)
-		return -ENOMEM;
+		goto out;
+
 	length = -EFAULT;
 	if (copy_from_user(page, buf, count))
 		goto out;
@@ -292,7 +302,7 @@ static ssize_t sel_write_disable(struct file *file, const char __user *buf,
 
 	if (new_value) {
 		length = selinux_disable();
-		if (length < 0)
+		if (length)
 			goto out;
 		audit_log(current->audit_context, GFP_KERNEL, AUDIT_MAC_STATUS,
 			"selinux=0 auid=%u ses=%u",
@@ -493,7 +503,6 @@ static ssize_t sel_write_load(struct file *file, const char __user *buf,
 			      size_t count, loff_t *ppos)
 
 {
-	int ret;
 	ssize_t length;
 	void *data = NULL;
 
@@ -503,17 +512,19 @@ static ssize_t sel_write_load(struct file *file, const char __user *buf,
 	if (length)
 		goto out;
 
-	if (*ppos != 0) {
-		/* No partial writes. */
-		length = -EINVAL;
+	/* No partial writes. */
+	length = -EINVAL;
+	if (*ppos != 0)
 		goto out;
-	}
 
-	if ((count > 64 * 1024 * 1024)
-	    || (data = vmalloc(count)) == NULL) {
-		length = -ENOMEM;
+	length = -EFBIG;
+	if (count > 64 * 1024 * 1024)
+		goto out;
+
+	length = -ENOMEM;
+	data = vmalloc(count);
+	if (!data)
 		goto out;
-	}
 
 	length = -EFAULT;
 	if (copy_from_user(data, buf, count) != 0)
@@ -523,23 +534,19 @@ static ssize_t sel_write_load(struct file *file, const char __user *buf,
 	if (length)
 		goto out;
 
-	ret = sel_make_bools();
-	if (ret) {
-		length = ret;
+	length = sel_make_bools();
+	if (length)
 		goto out1;
-	}
 
-	ret = sel_make_classes();
-	if (ret) {
-		length = ret;
+	length = sel_make_classes();
+	if (length)
 		goto out1;
-	}
 
-	ret = sel_make_policycap();
-	if (ret)
-		length = ret;
-	else
-		length = count;
+	length = sel_make_policycap();
+	if (length)
+		goto out1;
+
+	length = count;
 
 out1:
 	audit_log(current->audit_context, GFP_KERNEL, AUDIT_MAC_POLICY_LOAD,
@@ -559,26 +566,26 @@ static const struct file_operations sel_load_ops = {
 
 static ssize_t sel_write_context(struct file *file, char *buf, size_t size)
 {
-	char *canon;
+	char *canon = NULL;
 	u32 sid, len;
 	ssize_t length;
 
 	length = task_has_security(current, SECURITY__CHECK_CONTEXT);
 	if (length)
-		return length;
+		goto out;
 
 	length = security_context_to_sid(buf, size, &sid);
-	if (length < 0)
-		return length;
+	if (length)
+		goto out;
 
 	length = security_sid_to_context(sid, &canon, &len);
-	if (length < 0)
-		return length;
+	if (length)
+		goto out;
 
+	length = -ERANGE;
 	if (len > SIMPLE_TRANSACTION_LIMIT) {
 		printk(KERN_ERR "SELinux: %s:  context size (%u) exceeds "
 			"payload max\n", __func__, len);
-		length = -ERANGE;
 		goto out;
 	}
 
@@ -602,23 +609,28 @@ static ssize_t sel_read_checkreqprot(struct file *filp, char __user *buf,
 static ssize_t sel_write_checkreqprot(struct file *file, const char __user *buf,
 				      size_t count, loff_t *ppos)
 {
-	char *page;
+	char *page = NULL;
 	ssize_t length;
 	unsigned int new_value;
 
 	length = task_has_security(current, SECURITY__SETCHECKREQPROT);
 	if (length)
-		return length;
+		goto out;
 
+	length = -ENOMEM;
 	if (count >= PAGE_SIZE)
-		return -ENOMEM;
-	if (*ppos != 0) {
-		/* No partial writes. */
-		return -EINVAL;
-	}
+		goto out;
+
+	/* No partial writes. */
+	length = -EINVAL;
+	if (*ppos != 0)
+		goto out;
+
+	length = -ENOMEM;
 	page = (char *)get_zeroed_page(GFP_KERNEL);
 	if (!page)
-		return -ENOMEM;
+		goto out;
+
 	length = -EFAULT;
 	if (copy_from_user(page, buf, count))
 		goto out;
@@ -693,7 +705,7 @@ static const struct file_operations transaction_ops = {
 
 static ssize_t sel_write_access(struct file *file, char *buf, size_t size)
 {
-	char *scon, *tcon;
+	char *scon = NULL, *tcon = NULL;
 	u32 ssid, tsid;
 	u16 tclass;
 	struct av_decision avd;
@@ -701,27 +713,29 @@ static ssize_t sel_write_access(struct file *file, char *buf, size_t size)
 
 	length = task_has_security(current, SECURITY__COMPUTE_AV);
 	if (length)
-		return length;
+		goto out;
 
 	length = -ENOMEM;
 	scon = kzalloc(size + 1, GFP_KERNEL);
 	if (!scon)
-		return length;
+		goto out;
 
+	length = -ENOMEM;
 	tcon = kzalloc(size + 1, GFP_KERNEL);
 	if (!tcon)
 		goto out;
 
 	length = -EINVAL;
 	if (sscanf(buf, "%s %s %hu", scon, tcon, &tclass) != 3)
-		goto out2;
+		goto out;
 
 	length = security_context_to_sid(scon, strlen(scon) + 1, &ssid);
-	if (length < 0)
-		goto out2;
+	if (length)
+		goto out;
+
 	length = security_context_to_sid(tcon, strlen(tcon) + 1, &tsid);
-	if (length < 0)
-		goto out2;
+	if (length)
+		goto out;
 
 	security_compute_av_user(ssid, tsid, tclass, &avd);
 
@@ -730,133 +744,131 @@ static ssize_t sel_write_access(struct file *file, char *buf, size_t size)
 			  avd.allowed, 0xffffffff,
 			  avd.auditallow, avd.auditdeny,
 			  avd.seqno, avd.flags);
-out2:
-	kfree(tcon);
 out:
+	kfree(tcon);
 	kfree(scon);
 	return length;
 }
 
 static ssize_t sel_write_create(struct file *file, char *buf, size_t size)
 {
-	char *scon, *tcon;
+	char *scon = NULL, *tcon = NULL;
 	u32 ssid, tsid, newsid;
 	u16 tclass;
 	ssize_t length;
-	char *newcon;
+	char *newcon = NULL;
 	u32 len;
 
 	length = task_has_security(current, SECURITY__COMPUTE_CREATE);
 	if (length)
-		return length;
+		goto out;
 
 	length = -ENOMEM;
 	scon = kzalloc(size + 1, GFP_KERNEL);
 	if (!scon)
-		return length;
+		goto out;
 
+	length = -ENOMEM;
 	tcon = kzalloc(size + 1, GFP_KERNEL);
 	if (!tcon)
 		goto out;
 
 	length = -EINVAL;
 	if (sscanf(buf, "%s %s %hu", scon, tcon, &tclass) != 3)
-		goto out2;
+		goto out;
 
 	length = security_context_to_sid(scon, strlen(scon) + 1, &ssid);
-	if (length < 0)
-		goto out2;
+	if (length)
+		goto out;
+
 	length = security_context_to_sid(tcon, strlen(tcon) + 1, &tsid);
-	if (length < 0)
-		goto out2;
+	if (length)
+		goto out;
 
 	length = security_transition_sid_user(ssid, tsid, tclass, &newsid);
-	if (length < 0)
-		goto out2;
+	if (length)
+		goto out;
 
 	length = security_sid_to_context(newsid, &newcon, &len);
-	if (length < 0)
-		goto out2;
+	if (length)
+		goto out;
 
+	length = -ERANGE;
 	if (len > SIMPLE_TRANSACTION_LIMIT) {
 		printk(KERN_ERR "SELinux: %s:  context size (%u) exceeds "
 			"payload max\n", __func__, len);
-		length = -ERANGE;
-		goto out3;
+		goto out;
 	}
 
 	memcpy(buf, newcon, len);
 	length = len;
-out3:
+out:
 	kfree(newcon);
-out2:
 	kfree(tcon);
-out:
 	kfree(scon);
 	return length;
 }
 
 static ssize_t sel_write_relabel(struct file *file, char *buf, size_t size)
 {
-	char *scon, *tcon;
+	char *scon = NULL, *tcon = NULL;
 	u32 ssid, tsid, newsid;
 	u16 tclass;
 	ssize_t length;
-	char *newcon;
+	char *newcon = NULL;
 	u32 len;
 
 	length = task_has_security(current, SECURITY__COMPUTE_RELABEL);
 	if (length)
-		return length;
+		goto out;
 
 	length = -ENOMEM;
 	scon = kzalloc(size + 1, GFP_KERNEL);
 	if (!scon)
-		return length;
+		goto out;
 
+	length = -ENOMEM;
 	tcon = kzalloc(size + 1, GFP_KERNEL);
 	if (!tcon)
 		goto out;
 
 	length = -EINVAL;
 	if (sscanf(buf, "%s %s %hu", scon, tcon, &tclass) != 3)
-		goto out2;
+		goto out;
 
 	length = security_context_to_sid(scon, strlen(scon) + 1, &ssid);
-	if (length < 0)
-		goto out2;
+	if (length)
+		goto out;
+
 	length = security_context_to_sid(tcon, strlen(tcon) + 1, &tsid);
-	if (length < 0)
-		goto out2;
+	if (length)
+		goto out;
 
 	length = security_change_sid(ssid, tsid, tclass, &newsid);
-	if (length < 0)
-		goto out2;
+	if (length)
+		goto out;
 
 	length = security_sid_to_context(newsid, &newcon, &len);
-	if (length < 0)
-		goto out2;
+	if (length)
+		goto out;
 
-	if (len > SIMPLE_TRANSACTION_LIMIT) {
-		length = -ERANGE;
-		goto out3;
-	}
+	length = -ERANGE;
+	if (len > SIMPLE_TRANSACTION_LIMIT)
+		goto out;
 
 	memcpy(buf, newcon, len);
 	length = len;
-out3:
+out:
 	kfree(newcon);
-out2:
 	kfree(tcon);
-out:
 	kfree(scon);
 	return length;
 }
 
 static ssize_t sel_write_user(struct file *file, char *buf, size_t size)
 {
-	char *con, *user, *ptr;
-	u32 sid, *sids;
+	char *con = NULL, *user = NULL, *ptr;
+	u32 sid, *sids = NULL;
 	ssize_t length;
 	char *newcon;
 	int i, rc;
@@ -864,28 +876,29 @@ static ssize_t sel_write_user(struct file *file, char *buf, size_t size)
 
 	length = task_has_security(current, SECURITY__COMPUTE_USER);
 	if (length)
-		return length;
+		goto out;;
 
 	length = -ENOMEM;
 	con = kzalloc(size + 1, GFP_KERNEL);
 	if (!con)
-		return length;
+		goto out;;
 
+	length = -ENOMEM;
 	user = kzalloc(size + 1, GFP_KERNEL);
 	if (!user)
 		goto out;
 
 	length = -EINVAL;
 	if (sscanf(buf, "%s %s", con, user) != 2)
-		goto out2;
+		goto out;
 
 	length = security_context_to_sid(con, strlen(con) + 1, &sid);
-	if (length < 0)
-		goto out2;
+	if (length)
+		goto out;
 
 	length = security_get_user_sids(sid, user, &sids, &nsids);
-	if (length < 0)
-		goto out2;
+	if (length)
+		goto out;
 
 	length = sprintf(buf, "%u", nsids) + 1;
 	ptr = buf + length;
@@ -893,82 +906,80 @@ static ssize_t sel_write_user(struct file *file, char *buf, size_t size)
 		rc = security_sid_to_context(sids[i], &newcon, &len);
 		if (rc) {
 			length = rc;
-			goto out3;
+			goto out;
 		}
 		if ((length + len) >= SIMPLE_TRANSACTION_LIMIT) {
 			kfree(newcon);
 			length = -ERANGE;
-			goto out3;
+			goto out;
 		}
 		memcpy(ptr, newcon, len);
 		kfree(newcon);
 		ptr += len;
 		length += len;
 	}
-out3:
+out:
 	kfree(sids);
-out2:
 	kfree(user);
-out:
 	kfree(con);
 	return length;
 }
 
 static ssize_t sel_write_member(struct file *file, char *buf, size_t size)
 {
-	char *scon, *tcon;
+	char *scon = NULL, *tcon = NULL;
 	u32 ssid, tsid, newsid;
 	u16 tclass;
 	ssize_t length;
-	char *newcon;
+	char *newcon = NULL;
 	u32 len;
 
 	length = task_has_security(current, SECURITY__COMPUTE_MEMBER);
 	if (length)
-		return length;
+		goto out;
 
 	length = -ENOMEM;
 	scon = kzalloc(size + 1, GFP_KERNEL);
 	if (!scon)
-		return length;
+		goto out;;
 
+	length = -ENOMEM;
 	tcon = kzalloc(size + 1, GFP_KERNEL);
 	if (!tcon)
 		goto out;
 
 	length = -EINVAL;
 	if (sscanf(buf, "%s %s %hu", scon, tcon, &tclass) != 3)
-		goto out2;
+		goto out;
 
 	length = security_context_to_sid(scon, strlen(scon) + 1, &ssid);
-	if (length < 0)
-		goto out2;
+	if (length)
+		goto out;
+
 	length = security_context_to_sid(tcon, strlen(tcon) + 1, &tsid);
-	if (length < 0)
-		goto out2;
+	if (length)
+		goto out;
 
 	length = security_member_sid(ssid, tsid, tclass, &newsid);
-	if (length < 0)
-		goto out2;
+	if (length)
+		goto out;
 
 	length = security_sid_to_context(newsid, &newcon, &len);
-	if (length < 0)
-		goto out2;
+	if (length)
+		goto out;
 
+	length = -ERANGE;
 	if (len > SIMPLE_TRANSACTION_LIMIT) {
 		printk(KERN_ERR "SELinux: %s:  context size (%u) exceeds "
 			"payload max\n", __func__, len);
-		length = -ERANGE;
-		goto out3;
+		goto out;
 	}
 
 	memcpy(buf, newcon, len);
 	length = len;
-out3:
+out:
 	kfree(newcon);
-out2:
 	kfree(tcon);
-out:
 	kfree(scon);
 	return length;
 }
@@ -997,16 +1008,14 @@ static ssize_t sel_read_bool(struct file *filep, char __user *buf,
 
 	mutex_lock(&sel_mutex);
 
-	if (index >= bool_num || strcmp(name, bool_pending_names[index])) {
-		ret = -EINVAL;
+	ret = -EINVAL;
+	if (index >= bool_num || strcmp(name, bool_pending_names[index]))
 		goto out;
-	}
 
+	ret = -ENOMEM;
 	page = (char *)get_zeroed_page(GFP_KERNEL);
-	if (!page) {
-		ret = -ENOMEM;
+	if (!page)
 		goto out;
-	}
 
 	cur_enforcing = security_get_bool_value(index);
 	if (cur_enforcing < 0) {
@@ -1018,8 +1027,7 @@ static ssize_t sel_read_bool(struct file *filep, char __user *buf,
 	ret = simple_read_from_buffer(buf, count, ppos, page, length);
 out:
 	mutex_unlock(&sel_mutex);
-	if (page)
-		free_page((unsigned long)page);
+	free_page((unsigned long)page);
 	return ret;
 }
 
@@ -1039,26 +1047,23 @@ static ssize_t sel_write_bool(struct file *filep, const char __user *buf,
 	if (length)
 		goto out;
 
-	if (index >= bool_num || strcmp(name, bool_pending_names[index])) {
-		length = -EINVAL;
+	length = -EINVAL;
+	if (index >= bool_num || strcmp(name, bool_pending_names[index]))
 		goto out;
-	}
 
-	if (count >= PAGE_SIZE) {
-		length = -ENOMEM;
+	length = -ENOMEM;
+	if (count >= PAGE_SIZE)
 		goto out;
-	}
 
-	if (*ppos != 0) {
-		/* No partial writes. */
-		length = -EINVAL;
+	/* No partial writes. */
+	length = -EINVAL;
+	if (*ppos != 0)
 		goto out;
-	}
+
+	length = -ENOMEM;
 	page = (char *)get_zeroed_page(GFP_KERNEL);
-	if (!page) {
-		length = -ENOMEM;
+	if (!page)
 		goto out;
-	}
 
 	length = -EFAULT;
 	if (copy_from_user(page, buf, count))
@@ -1076,8 +1081,7 @@ static ssize_t sel_write_bool(struct file *filep, const char __user *buf,
 
 out:
 	mutex_unlock(&sel_mutex);
-	if (page)
-		free_page((unsigned long) page);
+	free_page((unsigned long) page);
 	return length;
 }
 
@@ -1101,19 +1105,19 @@ static ssize_t sel_commit_bools_write(struct file *filep,
 	if (length)
 		goto out;
 
-	if (count >= PAGE_SIZE) {
-		length = -ENOMEM;
+	length = -ENOMEM;
+	if (count >= PAGE_SIZE)
 		goto out;
-	}
-	if (*ppos != 0) {
-		/* No partial writes. */
+
+	/* No partial writes. */
+	length = -EINVAL;
+	if (*ppos != 0)
 		goto out;
-	}
+
+	length = -ENOMEM;
 	page = (char *)get_zeroed_page(GFP_KERNEL);
-	if (!page) {
-		length = -ENOMEM;
+	if (!page)
 		goto out;
-	}
 
 	length = -EFAULT;
 	if (copy_from_user(page, buf, count))
@@ -1123,15 +1127,16 @@ static ssize_t sel_commit_bools_write(struct file *filep,
 	if (sscanf(page, "%d", &new_value) != 1)
 		goto out;
 
+	length = 0;
 	if (new_value && bool_pending_values)
-		security_set_bools(bool_num, bool_pending_values);
+		length = security_set_bools(bool_num, bool_pending_values);
 
-	length = count;
+	if (!length)
+		length = count;
 
 out:
 	mutex_unlock(&sel_mutex);
-	if (page)
-		free_page((unsigned long) page);
+	free_page((unsigned long) page);
 	return length;
 }
 
@@ -1168,7 +1173,7 @@ static void sel_remove_entries(struct dentry *de)
 
 static int sel_make_bools(void)
 {
-	int i, ret = 0;
+	int i, ret;
 	ssize_t len;
 	struct dentry *dentry = NULL;
 	struct dentry *dir = bool_dir;
@@ -1189,38 +1194,40 @@ static int sel_make_bools(void)
 
 	sel_remove_entries(dir);
 
+	ret = -ENOMEM;
 	page = (char *)get_zeroed_page(GFP_KERNEL);
 	if (!page)
-		return -ENOMEM;
+		goto out;
 
 	ret = security_get_bools(&num, &names, &values);
-	if (ret != 0)
+	if (ret)
 		goto out;
 
 	for (i = 0; i < num; i++) {
+		ret = -ENOMEM;
 		dentry = d_alloc_name(dir, names[i]);
-		if (!dentry) {
-			ret = -ENOMEM;
-			goto err;
-		}
+		if (!dentry)
+			goto out;
+
+		ret = -ENOMEM;
 		inode = sel_make_inode(dir->d_sb, S_IFREG | S_IRUGO | S_IWUSR);
-		if (!inode) {
-			ret = -ENOMEM;
-			goto err;
-		}
+		if (!inode)
+			goto out;
 
+		ret = -EINVAL;
 		len = snprintf(page, PAGE_SIZE, "/%s/%s", BOOL_DIR_NAME, names[i]);
-		if (len < 0) {
-			ret = -EINVAL;
-			goto err;
-		} else if (len >= PAGE_SIZE) {
-			ret = -ENAMETOOLONG;
-			goto err;
-		}
+		if (len < 0)
+			goto out;
+
+		ret = -ENAMETOOLONG;
+		if (len >= PAGE_SIZE)
+			goto out;
+
 		isec = (struct inode_security_struct *)inode->i_security;
 		ret = security_genfs_sid("selinuxfs", page, SECCLASS_FILE, &sid);
 		if (ret)
-			goto err;
+			goto out;
+
 		isec->sid = sid;
 		isec->initialized = 1;
 		inode->i_fop = &sel_bool_ops;
@@ -1230,10 +1237,12 @@ static int sel_make_bools(void)
 	bool_num = num;
 	bool_pending_names = names;
 	bool_pending_values = values;
+
+	free_page((unsigned long)page);
+	return 0;
 out:
 	free_page((unsigned long)page);
-	return ret;
-err:
+
 	if (names) {
 		for (i = 0; i < num; i++)
 			kfree(names[i]);
@@ -1241,8 +1250,8 @@ err:
 	}
 	kfree(values);
 	sel_remove_entries(dir);
-	ret = -ENOMEM;
-	goto out;
+
+	return ret;
 }
 
 #define NULL_FILE_NAME "null"
@@ -1264,47 +1273,41 @@ static ssize_t sel_write_avc_cache_threshold(struct file *file,
 					     size_t count, loff_t *ppos)
 
 {
-	char *page;
+	char *page = NULL;
 	ssize_t ret;
 	int new_value;
 
-	if (count >= PAGE_SIZE) {
-		ret = -ENOMEM;
+	ret = task_has_security(current, SECURITY__SETSECPARAM);
+	if (ret)
 		goto out;
-	}
 
-	if (*ppos != 0) {
-		/* No partial writes. */
-		ret = -EINVAL;
+	ret = -ENOMEM;
+	if (count >= PAGE_SIZE)
 		goto out;
-	}
 
+	/* No partial writes. */
+	ret = -EINVAL;
+	if (*ppos != 0)
+		goto out;
+
+	ret = -ENOMEM;
 	page = (char *)get_zeroed_page(GFP_KERNEL);
-	if (!page) {
-		ret = -ENOMEM;
+	if (!page)
 		goto out;
-	}
 
-	if (copy_from_user(page, buf, count)) {
-		ret = -EFAULT;
-		goto out_free;
-	}
+	ret = -EFAULT;
+	if (copy_from_user(page, buf, count))
+		goto out;
 
-	if (sscanf(page, "%u", &new_value) != 1) {
-		ret = -EINVAL;
+	ret = -EINVAL;
+	if (sscanf(page, "%u", &new_value) != 1)
 		goto out;
-	}
 
-	if (new_value != avc_cache_threshold) {
-		ret = task_has_security(current, SECURITY__SETSECPARAM);
-		if (ret)
-			goto out_free;
-		avc_cache_threshold = new_value;
-	}
+	avc_cache_threshold = new_value;
+
 	ret = count;
-out_free:
-	free_page((unsigned long)page);
 out:
+	free_page((unsigned long)page);
 	return ret;
 }
 
@@ -1312,19 +1315,18 @@ static ssize_t sel_read_avc_hash_stats(struct file *filp, char __user *buf,
 				       size_t count, loff_t *ppos)
 {
 	char *page;
-	ssize_t ret = 0;
+	ssize_t length;
 
 	page = (char *)__get_free_page(GFP_KERNEL);
-	if (!page) {
-		ret = -ENOMEM;
-		goto out;
-	}
-	ret = avc_get_hash_stats(page);
-	if (ret >= 0)
-		ret = simple_read_from_buffer(buf, count, ppos, page, ret);
+	if (!page)
+		return -ENOMEM;
+
+	length = avc_get_hash_stats(page);
+	if (length >= 0)
+		length = simple_read_from_buffer(buf, count, ppos, page, length);
 	free_page((unsigned long)page);
-out:
-	return ret;
+
+	return length;
 }
 
 static const struct file_operations sel_avc_cache_threshold_ops = {
@@ -1406,7 +1408,7 @@ static const struct file_operations sel_avc_cache_stats_ops = {
 
 static int sel_make_avc_files(struct dentry *dir)
 {
-	int i, ret = 0;
+	int i;
 	static struct tree_descr files[] = {
 		{ "cache_threshold",
 		  &sel_avc_cache_threshold_ops, S_IRUGO|S_IWUSR },
@@ -1421,22 +1423,19 @@ static int sel_make_avc_files(struct dentry *dir)
 		struct dentry *dentry;
 
 		dentry = d_alloc_name(dir, files[i].name);
-		if (!dentry) {
-			ret = -ENOMEM;
-			goto out;
-		}
+		if (!dentry)
+			return -ENOMEM;
 
 		inode = sel_make_inode(dir->d_sb, S_IFREG|files[i].mode);
-		if (!inode) {
-			ret = -ENOMEM;
-			goto out;
-		}
+		if (!inode)
+			return -ENOMEM;
+
 		inode->i_fop = files[i].ops;
 		inode->i_ino = ++sel_last_ino;
 		d_add(dentry, inode);
 	}
-out:
-	return ret;
+
+	return 0;
 }
 
 static ssize_t sel_read_initcon(struct file *file, char __user *buf,
@@ -1450,7 +1449,7 @@ static ssize_t sel_read_initcon(struct file *file, char __user *buf,
 	inode = file->f_path.dentry->d_inode;
 	sid = inode->i_ino&SEL_INO_MASK;
 	ret = security_sid_to_context(sid, &con, &len);
-	if (ret < 0)
+	if (ret)
 		return ret;
 
 	ret = simple_read_from_buffer(buf, count, ppos, con, len);
@@ -1465,28 +1464,25 @@ static const struct file_operations sel_initcon_ops = {
 
 static int sel_make_initcon_files(struct dentry *dir)
 {
-	int i, ret = 0;
+	int i;
 
 	for (i = 1; i <= SECINITSID_NUM; i++) {
 		struct inode *inode;
 		struct dentry *dentry;
 		dentry = d_alloc_name(dir, security_get_initial_sid_context(i));
-		if (!dentry) {
-			ret = -ENOMEM;
-			goto out;
-		}
+		if (!dentry)
+			return -ENOMEM;
 
 		inode = sel_make_inode(dir->d_sb, S_IFREG|S_IRUGO);
-		if (!inode) {
-			ret = -ENOMEM;
-			goto out;
-		}
+		if (!inode)
+			return -ENOMEM;
+
 		inode->i_fop = &sel_initcon_ops;
 		inode->i_ino = i|SEL_INITCON_INO_OFFSET;
 		d_add(dentry, inode);
 	}
-out:
-	return ret;
+
+	return 0;
 }
 
 static inline unsigned int sel_div(unsigned long a, unsigned long b)
@@ -1522,15 +1518,13 @@ static ssize_t sel_read_class(struct file *file, char __user *buf,
 	unsigned long ino = file->f_path.dentry->d_inode->i_ino;
 
 	page = (char *)__get_free_page(GFP_KERNEL);
-	if (!page) {
-		rc = -ENOMEM;
-		goto out;
-	}
+	if (!page)
+		return -ENOMEM;
 
 	len = snprintf(page, PAGE_SIZE, "%d", sel_ino_to_class(ino));
 	rc = simple_read_from_buffer(buf, count, ppos, page, len);
 	free_page((unsigned long)page);
-out:
+
 	return rc;
 }
 
@@ -1547,15 +1541,13 @@ static ssize_t sel_read_perm(struct file *file, char __user *buf,
 	unsigned long ino = file->f_path.dentry->d_inode->i_ino;
 
 	page = (char *)__get_free_page(GFP_KERNEL);
-	if (!page) {
-		rc = -ENOMEM;
-		goto out;
-	}
+	if (!page)
+		return -ENOMEM;
 
 	len = snprintf(page, PAGE_SIZE, "%d", sel_ino_to_perm(ino));
 	rc = simple_read_from_buffer(buf, count, ppos, page, len);
 	free_page((unsigned long)page);
-out:
+
 	return rc;
 }
 
@@ -1586,39 +1578,37 @@ static const struct file_operations sel_policycap_ops = {
 static int sel_make_perm_files(char *objclass, int classvalue,
 				struct dentry *dir)
 {
-	int i, rc = 0, nperms;
+	int i, rc, nperms;
 	char **perms;
 
 	rc = security_get_permissions(objclass, &perms, &nperms);
 	if (rc)
-		goto out;
+		return rc;
 
 	for (i = 0; i < nperms; i++) {
 		struct inode *inode;
 		struct dentry *dentry;
 
+		rc = -ENOMEM;
 		dentry = d_alloc_name(dir, perms[i]);
-		if (!dentry) {
-			rc = -ENOMEM;
-			goto out1;
-		}
+		if (!dentry)
+			goto out;
 
+		rc = -ENOMEM;
 		inode = sel_make_inode(dir->d_sb, S_IFREG|S_IRUGO);
-		if (!inode) {
-			rc = -ENOMEM;
-			goto out1;
-		}
+		if (!inode)
+			goto out;
+
 		inode->i_fop = &sel_perm_ops;
 		/* i+1 since perm values are 1-indexed */
 		inode->i_ino = sel_perm_to_ino(classvalue, i + 1);
 		d_add(dentry, inode);
 	}
-
-out1:
+	rc = 0;
+out:
 	for (i = 0; i < nperms; i++)
 		kfree(perms[i]);
 	kfree(perms);
-out:
 	return rc;
 }
 
@@ -1630,34 +1620,27 @@ static int sel_make_class_dir_entries(char *classname, int index,
 	int rc;
 
 	dentry = d_alloc_name(dir, "index");
-	if (!dentry) {
-		rc = -ENOMEM;
-		goto out;
-	}
+	if (!dentry)
+		return -ENOMEM;
 
 	inode = sel_make_inode(dir->d_sb, S_IFREG|S_IRUGO);
-	if (!inode) {
-		rc = -ENOMEM;
-		goto out;
-	}
+	if (!inode)
+		return -ENOMEM;
 
 	inode->i_fop = &sel_class_ops;
 	inode->i_ino = sel_class_to_ino(index);
 	d_add(dentry, inode);
 
 	dentry = d_alloc_name(dir, "perms");
-	if (!dentry) {
-		rc = -ENOMEM;
-		goto out;
-	}
+	if (!dentry)
+		return -ENOMEM;
 
 	rc = sel_make_dir(dir->d_inode, dentry, &last_class_ino);
 	if (rc)
-		goto out;
+		return rc;
 
 	rc = sel_make_perm_files(classname, index, dentry);
 
-out:
 	return rc;
 }
 
@@ -1687,15 +1670,15 @@ static void sel_remove_classes(void)
 
 static int sel_make_classes(void)
 {
-	int rc = 0, nclasses, i;
+	int rc, nclasses, i;
 	char **classes;
 
 	/* delete any existing entries */
 	sel_remove_classes();
 
 	rc = security_get_classes(&classes, &nclasses);
-	if (rc < 0)
-		goto out;
+	if (rc)
+		return rc;
 
 	/* +2 since classes are 1-indexed */
 	last_class_ino = sel_class_to_ino(nclasses + 2);
@@ -1703,29 +1686,27 @@ static int sel_make_classes(void)
 	for (i = 0; i < nclasses; i++) {
 		struct dentry *class_name_dir;
 
+		rc = -ENOMEM;
 		class_name_dir = d_alloc_name(class_dir, classes[i]);
-		if (!class_name_dir) {
-			rc = -ENOMEM;
-			goto out1;
-		}
+		if (!class_name_dir)
+			goto out;
 
 		rc = sel_make_dir(class_dir->d_inode, class_name_dir,
 				&last_class_ino);
 		if (rc)
-			goto out1;
+			goto out;
 
 		/* i+1 since class values are 1-indexed */
 		rc = sel_make_class_dir_entries(classes[i], i + 1,
 				class_name_dir);
 		if (rc)
-			goto out1;
+			goto out;
 	}
-
-out1:
+	rc = 0;
+out:
 	for (i = 0; i < nclasses; i++)
 		kfree(classes[i]);
 	kfree(classes);
-out:
 	return rc;
 }
 
@@ -1762,14 +1743,12 @@ static int sel_make_policycap(void)
 static int sel_make_dir(struct inode *dir, struct dentry *dentry,
 			unsigned long *ino)
 {
-	int ret = 0;
 	struct inode *inode;
 
 	inode = sel_make_inode(dir->i_sb, S_IFDIR | S_IRUGO | S_IXUGO);
-	if (!inode) {
-		ret = -ENOMEM;
-		goto out;
-	}
+	if (!inode)
+		return -ENOMEM;
+
 	inode->i_op = &simple_dir_inode_operations;
 	inode->i_fop = &simple_dir_operations;
 	inode->i_ino = ++(*ino);
@@ -1778,8 +1757,8 @@ static int sel_make_dir(struct inode *dir, struct dentry *dentry,
 	d_add(dentry, inode);
 	/* bump link count on parent directory, too */
 	inc_nlink(dir);
-out:
-	return ret;
+
+	return 0;
 }
 
 static int sel_fill_super(struct super_block *sb, void *data, int silent)
@@ -1815,11 +1794,10 @@ static int sel_fill_super(struct super_block *sb, void *data, int silent)
 
 	root_inode = sb->s_root->d_inode;
 
+	ret = -ENOMEM;
 	dentry = d_alloc_name(sb->s_root, BOOL_DIR_NAME);
-	if (!dentry) {
-		ret = -ENOMEM;
+	if (!dentry)
 		goto err;
-	}
 
 	ret = sel_make_dir(root_inode, dentry, &sel_last_ino);
 	if (ret)
@@ -1827,17 +1805,16 @@ static int sel_fill_super(struct super_block *sb, void *data, int silent)
 
 	bool_dir = dentry;
 
+	ret = -ENOMEM;
 	dentry = d_alloc_name(sb->s_root, NULL_FILE_NAME);
-	if (!dentry) {
-		ret = -ENOMEM;
+	if (!dentry)
 		goto err;
-	}
 
+	ret = -ENOMEM;
 	inode = sel_make_inode(sb, S_IFCHR | S_IRUGO | S_IWUGO);
-	if (!inode) {
-		ret = -ENOMEM;
+	if (!inode)
 		goto err;
-	}
+
 	inode->i_ino = ++sel_last_ino;
 	isec = (struct inode_security_struct *)inode->i_security;
 	isec->sid = SECINITSID_DEVNULL;
@@ -1848,11 +1825,10 @@ static int sel_fill_super(struct super_block *sb, void *data, int silent)
 	d_add(dentry, inode);
 	selinux_null = dentry;
 
+	ret = -ENOMEM;
 	dentry = d_alloc_name(sb->s_root, "avc");
-	if (!dentry) {
-		ret = -ENOMEM;
+	if (!dentry)
 		goto err;
-	}
 
 	ret = sel_make_dir(root_inode, dentry, &sel_last_ino);
 	if (ret)
@@ -1862,11 +1838,10 @@ static int sel_fill_super(struct super_block *sb, void *data, int silent)
 	if (ret)
 		goto err;
 
+	ret = -ENOMEM;
 	dentry = d_alloc_name(sb->s_root, "initial_contexts");
-	if (!dentry) {
-		ret = -ENOMEM;
+	if (!dentry)
 		goto err;
-	}
 
 	ret = sel_make_dir(root_inode, dentry, &sel_last_ino);
 	if (ret)
@@ -1876,11 +1851,10 @@ static int sel_fill_super(struct super_block *sb, void *data, int silent)
 	if (ret)
 		goto err;
 
+	ret = -ENOMEM;
 	dentry = d_alloc_name(sb->s_root, "class");
-	if (!dentry) {
-		ret = -ENOMEM;
+	if (!dentry)
 		goto err;
-	}
 
 	ret = sel_make_dir(root_inode, dentry, &sel_last_ino);
 	if (ret)
@@ -1888,11 +1862,10 @@ static int sel_fill_super(struct super_block *sb, void *data, int silent)
 
 	class_dir = dentry;
 
+	ret = -ENOMEM;
 	dentry = d_alloc_name(sb->s_root, "policy_capabilities");
-	if (!dentry) {
-		ret = -ENOMEM;
+	if (!dentry)
 		goto err;
-	}
 
 	ret = sel_make_dir(root_inode, dentry, &sel_last_ino);
 	if (ret)
@@ -1900,12 +1873,11 @@ static int sel_fill_super(struct super_block *sb, void *data, int silent)
 
 	policycap_dir = dentry;
 
-out:
-	return ret;
+	return 0;
 err:
 	printk(KERN_ERR "SELinux: %s:  failed while creating inodes\n",
 		__func__);
-	goto out;
+	return ret;
 }
 
 static int sel_get_sb(struct file_system_type *fs_type,
@@ -1930,14 +1902,16 @@ static int __init init_sel_fs(void)
 	if (!selinux_enabled)
 		return 0;
 	err = register_filesystem(&sel_fs_type);
-	if (!err) {
-		selinuxfs_mount = kern_mount(&sel_fs_type);
-		if (IS_ERR(selinuxfs_mount)) {
-			printk(KERN_ERR "selinuxfs:  could not mount!\n");
-			err = PTR_ERR(selinuxfs_mount);
-			selinuxfs_mount = NULL;
-		}
+	if (err)
+		return err;
+
+	selinuxfs_mount = kern_mount(&sel_fs_type);
+	if (IS_ERR(selinuxfs_mount)) {
+		printk(KERN_ERR "selinuxfs:  could not mount!\n");
+		err = PTR_ERR(selinuxfs_mount);
+		selinuxfs_mount = NULL;
 	}
+
 	return err;
 }
 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
