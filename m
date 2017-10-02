From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Cc: paul@paul-moore.com, jmorris@namei.org, Stephen Smalley <sds@tycho.nsa.gov>
Date: Mon,  2 Oct 2017 11:58:25 -0400
Message-Id: <20171002155825.28620-11-sds@tycho.nsa.gov>
In-Reply-To: <20171002155825.28620-1-sds@tycho.nsa.gov>
References: <20171002155825.28620-1-sds@tycho.nsa.gov>
Subject: [RFC 10/10] selinuxfs: restrict write operations to the same selinux
 namespace
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This ensures that once a process unshares its selinux namespace,
it can no longer act on the parent namespace's selinuxfs instance,
irrespective of policy.  This is a safety measure so that even if
an otherwise unconfined process unshares its selinux namespace, it
won't be able to subsequently affect the enforcing mode or policy of the
parent.  This also helps avoid common mistakes like failing to create
a mount namespace and mount a new selinuxfs instance in order to act
on one's own selinux namespace after unsharing.

Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 security/selinux/selinuxfs.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index dedb3cc9..6c52d24 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -144,6 +144,9 @@ static ssize_t sel_write_enforce(struct file *file, const char __user *buf,
 	ssize_t length;
 	int new_value;
 
+	if (ns != current_selinux_ns)
+		return -EPERM;
+
 	if (count >= PAGE_SIZE)
 		return -ENOMEM;
 
@@ -283,6 +286,9 @@ static ssize_t sel_write_disable(struct file *file, const char __user *buf,
 	ssize_t length;
 	int new_value;
 
+	if (ns != current_selinux_ns)
+		return -EPERM;
+
 	if (count >= PAGE_SIZE)
 		return -ENOMEM;
 
@@ -333,6 +339,9 @@ static ssize_t sel_write_unshare(struct file *file, const char __user *buf,
 	bool set;
 	int rc;
 
+	if (ns != current_selinux_ns)
+		return -EPERM;
+
 	if (count >= PAGE_SIZE)
 		return -ENOMEM;
 
@@ -605,6 +614,9 @@ static ssize_t sel_write_load(struct file *file, const char __user *buf,
 	ssize_t length;
 	void *data = NULL;
 
+	if (ns != current_selinux_ns)
+		return -EPERM;
+
 	mutex_lock(&fsi->mutex);
 
 	length = avc_has_perm(current_selinux_ns,
@@ -716,6 +728,9 @@ static ssize_t sel_write_checkreqprot(struct file *file, const char __user *buf,
 	ssize_t length;
 	unsigned int new_value;
 
+	if (ns != current_selinux_ns)
+		return -EPERM;
+
 	length = avc_has_perm(current_selinux_ns,
 			      current_sid(), SECINITSID_SECURITY,
 			      SECCLASS_SECURITY, SECURITY__SETCHECKREQPROT,
@@ -762,6 +777,9 @@ static ssize_t sel_write_validatetrans(struct file *file,
 	u16 tclass;
 	int rc;
 
+	if (ns != current_selinux_ns)
+		return -EPERM;
+
 	rc = avc_has_perm(current_selinux_ns,
 			  current_sid(), SECINITSID_SECURITY,
 			  SECCLASS_SECURITY, SECURITY__VALIDATE_TRANS, NULL);
@@ -849,6 +867,8 @@ static ssize_t (*write_op[])(struct file *, char *, size_t) = {
 
 static ssize_t selinux_transaction_write(struct file *file, const char __user *buf, size_t size, loff_t *pos)
 {
+	struct selinux_fs_info *fsi = file_inode(file)->i_sb->s_fs_info;
+	struct selinux_ns *ns = fsi->ns;
 	ino_t ino = file_inode(file)->i_ino;
 	char *data;
 	ssize_t rv;
@@ -856,6 +876,9 @@ static ssize_t selinux_transaction_write(struct file *file, const char __user *b
 	if (ino >= ARRAY_SIZE(write_op) || !write_op[ino])
 		return -EINVAL;
 
+	if (ns != current_selinux_ns)
+		return -EPERM;
+
 	data = simple_transaction_get(file, buf, size);
 	if (IS_ERR(data))
 		return PTR_ERR(data);
@@ -1279,12 +1302,16 @@ static ssize_t sel_write_bool(struct file *filep, const char __user *buf,
 			      size_t count, loff_t *ppos)
 {
 	struct selinux_fs_info *fsi = file_inode(filep)->i_sb->s_fs_info;
+	struct selinux_ns *ns = fsi->ns;
 	char *page = NULL;
 	ssize_t length;
 	int new_value;
 	unsigned index = file_inode(filep)->i_ino & SEL_INO_MASK;
 	const char *name = filep->f_path.dentry->d_name.name;
 
+	if (ns != current_selinux_ns)
+		return -EPERM;
+
 	mutex_lock(&fsi->mutex);
 
 	length = avc_has_perm(current_selinux_ns,
@@ -1347,6 +1374,9 @@ static ssize_t sel_commit_bools_write(struct file *filep,
 	ssize_t length;
 	int new_value;
 
+	if (ns != current_selinux_ns)
+		return -EPERM;
+
 	mutex_lock(&fsi->mutex);
 
 	length = avc_has_perm(current_selinux_ns,
@@ -1511,6 +1541,9 @@ static ssize_t sel_write_avc_cache_threshold(struct file *file,
 	ssize_t ret;
 	unsigned int new_value;
 
+	if (ns != current_selinux_ns)
+		return -EPERM;
+
 	ret = avc_has_perm(current_selinux_ns,
 			   current_sid(), SECINITSID_SECURITY,
 			   SECCLASS_SECURITY, SECURITY__SETSECPARAM,
-- 
2.9.5
