From: Stephen Smalley <sds@tycho.nsa.gov>
To: paul@paul-moore.com
Cc: selinux@tycho.nsa.gov, peter.enderborg@sony.com, jmorris@namei.org,
 Stephen Smalley <sds@tycho.nsa.gov>
Date: Mon,  5 Mar 2018 11:47:55 -0500
Message-Id: <20180305164756.7878-1-sds@tycho.nsa.gov>
Subject: [PATCH 1/2] selinux: wrap selinuxfs state
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Move global selinuxfs state to a per-instance structure (selinux_fs_info),
and include a pointer to the selinux_state in this structure.
Pass this selinux_state to all security server operations, thereby
ensuring that each selinuxfs instance presents a view of and acts
as an interface to a particular selinux_state instance.

This change should have no effect on SELinux behavior or APIs
(userspace or LSM).  It merely wraps the selinuxfs global state,
links it to a particular selinux_state (currently always the single
global selinux_state) and uses that state for all operations.

Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 security/selinux/selinuxfs.c   | 472 +++++++++++++++++++++++++----------------
 security/selinux/ss/services.c |  13 ++
 2 files changed, 307 insertions(+), 178 deletions(-)

diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index 0dbd5fd6a396..1a32e93ba7b9 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -19,6 +19,7 @@
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
 #include <linux/fs.h>
+#include <linux/mount.h>
 #include <linux/mutex.h>
 #include <linux/init.h>
 #include <linux/string.h>
@@ -41,23 +42,6 @@
 #include "objsec.h"
 #include "conditional.h"
 
-static DEFINE_MUTEX(sel_mutex);
-
-/* global data for booleans */
-static struct dentry *bool_dir;
-static int bool_num;
-static char **bool_pending_names;
-static int *bool_pending_values;
-
-/* global data for classes */
-static struct dentry *class_dir;
-static unsigned long last_class_ino;
-
-static char policy_opened;
-
-/* global data for policy capabilities */
-static struct dentry *policycap_dir;
-
 enum sel_inos {
 	SEL_ROOT_INO = 2,
 	SEL_LOAD,	/* load policy */
@@ -82,7 +66,51 @@ enum sel_inos {
 	SEL_INO_NEXT,	/* The next inode number to use */
 };
 
-static unsigned long sel_last_ino = SEL_INO_NEXT - 1;
+struct selinux_fs_info {
+	struct dentry *bool_dir;
+	unsigned int bool_num;
+	char **bool_pending_names;
+	unsigned int *bool_pending_values;
+	struct dentry *class_dir;
+	unsigned long last_class_ino;
+	bool policy_opened;
+	struct dentry *policycap_dir;
+	struct mutex mutex;
+	unsigned long last_ino;
+	struct selinux_state *state;
+	struct super_block *sb;
+};
+
+static int selinux_fs_info_create(struct super_block *sb)
+{
+	struct selinux_fs_info *fsi;
+
+	fsi = kzalloc(sizeof(*fsi), GFP_KERNEL);
+	if (!fsi)
+		return -ENOMEM;
+
+	mutex_init(&fsi->mutex);
+	fsi->last_ino = SEL_INO_NEXT - 1;
+	fsi->state = &selinux_state;
+	fsi->sb = sb;
+	sb->s_fs_info = fsi;
+	return 0;
+}
+
+static void selinux_fs_info_free(struct super_block *sb)
+{
+	struct selinux_fs_info *fsi = sb->s_fs_info;
+	int i;
+
+	if (fsi) {
+		for (i = 0; i < fsi->bool_num; i++)
+			kfree(fsi->bool_pending_names[i]);
+		kfree(fsi->bool_pending_names);
+		kfree(fsi->bool_pending_values);
+	}
+	kfree(sb->s_fs_info);
+	sb->s_fs_info = NULL;
+}
 
 #define SEL_INITCON_INO_OFFSET		0x01000000
 #define SEL_BOOL_INO_OFFSET		0x02000000
@@ -94,11 +122,13 @@ static unsigned long sel_last_ino = SEL_INO_NEXT - 1;
 static ssize_t sel_read_enforce(struct file *filp, char __user *buf,
 				size_t count, loff_t *ppos)
 {
+	struct selinux_fs_info *fsi = file_inode(filp)->i_sb->s_fs_info;
+	struct selinux_state *state = fsi->state;
 	char tmpbuf[TMPBUFLEN];
 	ssize_t length;
 
 	length = scnprintf(tmpbuf, TMPBUFLEN, "%d",
-			   enforcing_enabled(&selinux_state));
+			   enforcing_enabled(state));
 	return simple_read_from_buffer(buf, count, ppos, tmpbuf, length);
 }
 
@@ -107,6 +137,8 @@ static ssize_t sel_write_enforce(struct file *file, const char __user *buf,
 				 size_t count, loff_t *ppos)
 
 {
+	struct selinux_fs_info *fsi = file_inode(file)->i_sb->s_fs_info;
+	struct selinux_state *state = fsi->state;
 	char *page = NULL;
 	ssize_t length;
 	int old_value, new_value;
@@ -128,8 +160,7 @@ static ssize_t sel_write_enforce(struct file *file, const char __user *buf,
 
 	new_value = !!new_value;
 
-	old_value = enforcing_enabled(&selinux_state);
-
+	old_value = enforcing_enabled(state);
 	if (new_value != old_value) {
 		length = avc_has_perm(current_sid(), SECINITSID_SECURITY,
 				      SECCLASS_SECURITY, SECURITY__SETENFORCE,
@@ -141,12 +172,11 @@ static ssize_t sel_write_enforce(struct file *file, const char __user *buf,
 			new_value, old_value,
 			from_kuid(&init_user_ns, audit_get_loginuid(current)),
 			audit_get_sessionid(current));
-		enforcing_set(&selinux_state, new_value);
+		enforcing_set(state, new_value);
 		if (new_value)
 			avc_ss_reset(0);
 		selnl_notify_setenforce(new_value);
-		selinux_status_update_setenforce(&selinux_state,
-						 new_value);
+		selinux_status_update_setenforce(state, new_value);
 		if (!new_value)
 			call_lsm_notifier(LSM_POLICY_CHANGE, NULL);
 	}
@@ -168,12 +198,14 @@ static const struct file_operations sel_enforce_ops = {
 static ssize_t sel_read_handle_unknown(struct file *filp, char __user *buf,
 					size_t count, loff_t *ppos)
 {
+	struct selinux_fs_info *fsi = file_inode(filp)->i_sb->s_fs_info;
+	struct selinux_state *state = fsi->state;
 	char tmpbuf[TMPBUFLEN];
 	ssize_t length;
 	ino_t ino = file_inode(filp)->i_ino;
 	int handle_unknown = (ino == SEL_REJECT_UNKNOWN) ?
-		security_get_reject_unknown(&selinux_state) :
-		!security_get_allow_unknown(&selinux_state);
+		security_get_reject_unknown(state) :
+		!security_get_allow_unknown(state);
 
 	length = scnprintf(tmpbuf, TMPBUFLEN, "%d", handle_unknown);
 	return simple_read_from_buffer(buf, count, ppos, tmpbuf, length);
@@ -186,7 +218,9 @@ static const struct file_operations sel_handle_unknown_ops = {
 
 static int sel_open_handle_status(struct inode *inode, struct file *filp)
 {
-	struct page    *status = selinux_kernel_status_page(&selinux_state);
+	struct selinux_fs_info *fsi = file_inode(filp)->i_sb->s_fs_info;
+	struct selinux_state *state = fsi->state;
+	struct page    *status = selinux_kernel_status_page(state);
 
 	if (!status)
 		return -ENOMEM;
@@ -242,6 +276,8 @@ static ssize_t sel_write_disable(struct file *file, const char __user *buf,
 				 size_t count, loff_t *ppos)
 
 {
+	struct selinux_fs_info *fsi = file_inode(file)->i_sb->s_fs_info;
+	struct selinux_state *state = fsi->state;
 	char *page;
 	ssize_t length;
 	int new_value;
@@ -262,7 +298,7 @@ static ssize_t sel_write_disable(struct file *file, const char __user *buf,
 		goto out;
 
 	if (new_value) {
-		length = selinux_disable(&selinux_state);
+		length = selinux_disable(state);
 		if (length)
 			goto out;
 		audit_log(current->audit_context, GFP_KERNEL, AUDIT_MAC_STATUS,
@@ -301,9 +337,9 @@ static const struct file_operations sel_policyvers_ops = {
 };
 
 /* declaration for sel_write_load */
-static int sel_make_bools(void);
-static int sel_make_classes(void);
-static int sel_make_policycap(void);
+static int sel_make_bools(struct selinux_fs_info *fsi);
+static int sel_make_classes(struct selinux_fs_info *fsi);
+static int sel_make_policycap(struct selinux_fs_info *fsi);
 
 /* declaration for sel_make_class_dirs */
 static struct dentry *sel_make_dir(struct dentry *dir, const char *name,
@@ -312,11 +348,13 @@ static struct dentry *sel_make_dir(struct dentry *dir, const char *name,
 static ssize_t sel_read_mls(struct file *filp, char __user *buf,
 				size_t count, loff_t *ppos)
 {
+	struct selinux_fs_info *fsi = file_inode(filp)->i_sb->s_fs_info;
+	struct selinux_state *state = fsi->state;
 	char tmpbuf[TMPBUFLEN];
 	ssize_t length;
 
 	length = scnprintf(tmpbuf, TMPBUFLEN, "%d",
-			   security_mls_enabled(&selinux_state));
+			   security_mls_enabled(state));
 	return simple_read_from_buffer(buf, count, ppos, tmpbuf, length);
 }
 
@@ -332,12 +370,14 @@ struct policy_load_memory {
 
 static int sel_open_policy(struct inode *inode, struct file *filp)
 {
+	struct selinux_fs_info *fsi = inode->i_sb->s_fs_info;
+	struct selinux_state *state = fsi->state;
 	struct policy_load_memory *plm = NULL;
 	int rc;
 
 	BUG_ON(filp->private_data);
 
-	mutex_lock(&sel_mutex);
+	mutex_lock(&fsi->mutex);
 
 	rc = avc_has_perm(current_sid(), SECINITSID_SECURITY,
 			  SECCLASS_SECURITY, SECURITY__READ_POLICY, NULL);
@@ -345,7 +385,7 @@ static int sel_open_policy(struct inode *inode, struct file *filp)
 		goto err;
 
 	rc = -EBUSY;
-	if (policy_opened)
+	if (fsi->policy_opened)
 		goto err;
 
 	rc = -ENOMEM;
@@ -353,25 +393,25 @@ static int sel_open_policy(struct inode *inode, struct file *filp)
 	if (!plm)
 		goto err;
 
-	if (i_size_read(inode) != security_policydb_len(&selinux_state)) {
+	if (i_size_read(inode) != security_policydb_len(state)) {
 		inode_lock(inode);
-		i_size_write(inode, security_policydb_len(&selinux_state));
+		i_size_write(inode, security_policydb_len(state));
 		inode_unlock(inode);
 	}
 
-	rc = security_read_policy(&selinux_state, &plm->data, &plm->len);
+	rc = security_read_policy(state, &plm->data, &plm->len);
 	if (rc)
 		goto err;
 
-	policy_opened = 1;
+	fsi->policy_opened = 1;
 
 	filp->private_data = plm;
 
-	mutex_unlock(&sel_mutex);
+	mutex_unlock(&fsi->mutex);
 
 	return 0;
 err:
-	mutex_unlock(&sel_mutex);
+	mutex_unlock(&fsi->mutex);
 
 	if (plm)
 		vfree(plm->data);
@@ -381,11 +421,12 @@ static int sel_open_policy(struct inode *inode, struct file *filp)
 
 static int sel_release_policy(struct inode *inode, struct file *filp)
 {
+	struct selinux_fs_info *fsi = inode->i_sb->s_fs_info;
 	struct policy_load_memory *plm = filp->private_data;
 
 	BUG_ON(!plm);
 
-	policy_opened = 0;
+	fsi->policy_opened = 0;
 
 	vfree(plm->data);
 	kfree(plm);
@@ -396,10 +437,11 @@ static int sel_release_policy(struct inode *inode, struct file *filp)
 static ssize_t sel_read_policy(struct file *filp, char __user *buf,
 			       size_t count, loff_t *ppos)
 {
+	struct selinux_fs_info *fsi = file_inode(filp)->i_sb->s_fs_info;
 	struct policy_load_memory *plm = filp->private_data;
 	int ret;
 
-	mutex_lock(&sel_mutex);
+	mutex_lock(&fsi->mutex);
 
 	ret = avc_has_perm(current_sid(), SECINITSID_SECURITY,
 			  SECCLASS_SECURITY, SECURITY__READ_POLICY, NULL);
@@ -408,7 +450,7 @@ static ssize_t sel_read_policy(struct file *filp, char __user *buf,
 
 	ret = simple_read_from_buffer(buf, count, ppos, plm->data, plm->len);
 out:
-	mutex_unlock(&sel_mutex);
+	mutex_unlock(&fsi->mutex);
 	return ret;
 }
 
@@ -462,14 +504,41 @@ static const struct file_operations sel_policy_ops = {
 	.llseek		= generic_file_llseek,
 };
 
+static int sel_make_policy_nodes(struct selinux_fs_info *fsi)
+{
+	int ret;
+
+	ret = sel_make_bools(fsi);
+	if (ret) {
+		pr_err("SELinux: failed to load policy booleans\n");
+		return ret;
+	}
+
+	ret = sel_make_classes(fsi);
+	if (ret) {
+		pr_err("SELinux: failed to load policy classes\n");
+		return ret;
+	}
+
+	ret = sel_make_policycap(fsi);
+	if (ret) {
+		pr_err("SELinux: failed to load policy capabilities\n");
+		return ret;
+	}
+
+	return 0;
+}
+
 static ssize_t sel_write_load(struct file *file, const char __user *buf,
 			      size_t count, loff_t *ppos)
 
 {
+	struct selinux_fs_info *fsi = file_inode(file)->i_sb->s_fs_info;
+	struct selinux_state *state = fsi->state;
 	ssize_t length;
 	void *data = NULL;
 
-	mutex_lock(&sel_mutex);
+	mutex_lock(&fsi->mutex);
 
 	length = avc_has_perm(current_sid(), SECINITSID_SECURITY,
 			      SECCLASS_SECURITY, SECURITY__LOAD_POLICY, NULL);
@@ -494,29 +563,15 @@ static ssize_t sel_write_load(struct file *file, const char __user *buf,
 	if (copy_from_user(data, buf, count) != 0)
 		goto out;
 
-	length = security_load_policy(&selinux_state, data, count);
+	length = security_load_policy(state, data, count);
 	if (length) {
 		pr_warn_ratelimited("SELinux: failed to load policy\n");
 		goto out;
 	}
 
-	length = sel_make_bools();
-	if (length) {
-		pr_err("SELinux: failed to load policy booleans\n");
-		goto out1;
-	}
-
-	length = sel_make_classes();
-	if (length) {
-		pr_err("SELinux: failed to load policy classes\n");
-		goto out1;
-	}
-
-	length = sel_make_policycap();
-	if (length) {
-		pr_err("SELinux: failed to load policy capabilities\n");
+	length = sel_make_policy_nodes(fsi);
+	if (length)
 		goto out1;
-	}
 
 	length = count;
 
@@ -526,7 +581,7 @@ static ssize_t sel_write_load(struct file *file, const char __user *buf,
 		from_kuid(&init_user_ns, audit_get_loginuid(current)),
 		audit_get_sessionid(current));
 out:
-	mutex_unlock(&sel_mutex);
+	mutex_unlock(&fsi->mutex);
 	vfree(data);
 	return length;
 }
@@ -538,6 +593,8 @@ static const struct file_operations sel_load_ops = {
 
 static ssize_t sel_write_context(struct file *file, char *buf, size_t size)
 {
+	struct selinux_fs_info *fsi = file_inode(file)->i_sb->s_fs_info;
+	struct selinux_state *state = fsi->state;
 	char *canon = NULL;
 	u32 sid, len;
 	ssize_t length;
@@ -547,12 +604,11 @@ static ssize_t sel_write_context(struct file *file, char *buf, size_t size)
 	if (length)
 		goto out;
 
-	length = security_context_to_sid(&selinux_state, buf, size,
-					 &sid, GFP_KERNEL);
+	length = security_context_to_sid(state, buf, size, &sid, GFP_KERNEL);
 	if (length)
 		goto out;
 
-	length = security_sid_to_context(&selinux_state, sid, &canon, &len);
+	length = security_sid_to_context(state, sid, &canon, &len);
 	if (length)
 		goto out;
 
@@ -573,16 +629,20 @@ static ssize_t sel_write_context(struct file *file, char *buf, size_t size)
 static ssize_t sel_read_checkreqprot(struct file *filp, char __user *buf,
 				     size_t count, loff_t *ppos)
 {
+	struct selinux_fs_info *fsi = file_inode(filp)->i_sb->s_fs_info;
+	struct selinux_state *state = fsi->state;
 	char tmpbuf[TMPBUFLEN];
 	ssize_t length;
 
-	length = scnprintf(tmpbuf, TMPBUFLEN, "%u", selinux_state.checkreqprot);
+	length = scnprintf(tmpbuf, TMPBUFLEN, "%u", state->checkreqprot);
 	return simple_read_from_buffer(buf, count, ppos, tmpbuf, length);
 }
 
 static ssize_t sel_write_checkreqprot(struct file *file, const char __user *buf,
 				      size_t count, loff_t *ppos)
 {
+	struct selinux_fs_info *fsi = file_inode(file)->i_sb->s_fs_info;
+	struct selinux_state *state = fsi->state;
 	char *page;
 	ssize_t length;
 	unsigned int new_value;
@@ -608,7 +668,7 @@ static ssize_t sel_write_checkreqprot(struct file *file, const char __user *buf,
 	if (sscanf(page, "%u", &new_value) != 1)
 		goto out;
 
-	selinux_state.checkreqprot = new_value ? 1 : 0;
+	state->checkreqprot = new_value ? 1 : 0;
 	length = count;
 out:
 	kfree(page);
@@ -624,6 +684,8 @@ static ssize_t sel_write_validatetrans(struct file *file,
 					const char __user *buf,
 					size_t count, loff_t *ppos)
 {
+	struct selinux_fs_info *fsi = file_inode(file)->i_sb->s_fs_info;
+	struct selinux_state *state = fsi->state;
 	char *oldcon = NULL, *newcon = NULL, *taskcon = NULL;
 	char *req = NULL;
 	u32 osid, nsid, tsid;
@@ -668,23 +730,19 @@ static ssize_t sel_write_validatetrans(struct file *file,
 	if (sscanf(req, "%s %s %hu %s", oldcon, newcon, &tclass, taskcon) != 4)
 		goto out;
 
-	rc = security_context_str_to_sid(&selinux_state, oldcon, &osid,
-					 GFP_KERNEL);
+	rc = security_context_str_to_sid(state, oldcon, &osid, GFP_KERNEL);
 	if (rc)
 		goto out;
 
-	rc = security_context_str_to_sid(&selinux_state, newcon, &nsid,
-					 GFP_KERNEL);
+	rc = security_context_str_to_sid(state, newcon, &nsid, GFP_KERNEL);
 	if (rc)
 		goto out;
 
-	rc = security_context_str_to_sid(&selinux_state, taskcon, &tsid,
-					 GFP_KERNEL);
+	rc = security_context_str_to_sid(state, taskcon, &tsid, GFP_KERNEL);
 	if (rc)
 		goto out;
 
-	rc = security_validate_transition_user(&selinux_state, osid, nsid,
-					       tsid, tclass);
+	rc = security_validate_transition_user(state, osid, nsid, tsid, tclass);
 	if (!rc)
 		rc = count;
 out:
@@ -754,6 +812,8 @@ static const struct file_operations transaction_ops = {
 
 static ssize_t sel_write_access(struct file *file, char *buf, size_t size)
 {
+	struct selinux_fs_info *fsi = file_inode(file)->i_sb->s_fs_info;
+	struct selinux_state *state = fsi->state;
 	char *scon = NULL, *tcon = NULL;
 	u32 ssid, tsid;
 	u16 tclass;
@@ -779,17 +839,15 @@ static ssize_t sel_write_access(struct file *file, char *buf, size_t size)
 	if (sscanf(buf, "%s %s %hu", scon, tcon, &tclass) != 3)
 		goto out;
 
-	length = security_context_str_to_sid(&selinux_state, scon, &ssid,
-					     GFP_KERNEL);
+	length = security_context_str_to_sid(state, scon, &ssid, GFP_KERNEL);
 	if (length)
 		goto out;
 
-	length = security_context_str_to_sid(&selinux_state, tcon, &tsid,
-					     GFP_KERNEL);
+	length = security_context_str_to_sid(state, tcon, &tsid, GFP_KERNEL);
 	if (length)
 		goto out;
 
-	security_compute_av_user(&selinux_state, ssid, tsid, tclass, &avd);
+	security_compute_av_user(state, ssid, tsid, tclass, &avd);
 
 	length = scnprintf(buf, SIMPLE_TRANSACTION_LIMIT,
 			  "%x %x %x %x %u %x",
@@ -804,6 +862,8 @@ static ssize_t sel_write_access(struct file *file, char *buf, size_t size)
 
 static ssize_t sel_write_create(struct file *file, char *buf, size_t size)
 {
+	struct selinux_fs_info *fsi = file_inode(file)->i_sb->s_fs_info;
+	struct selinux_state *state = fsi->state;
 	char *scon = NULL, *tcon = NULL;
 	char *namebuf = NULL, *objname = NULL;
 	u32 ssid, tsid, newsid;
@@ -869,23 +929,20 @@ static ssize_t sel_write_create(struct file *file, char *buf, size_t size)
 		objname = namebuf;
 	}
 
-	length = security_context_str_to_sid(&selinux_state, scon, &ssid,
-					     GFP_KERNEL);
+	length = security_context_str_to_sid(state, scon, &ssid, GFP_KERNEL);
 	if (length)
 		goto out;
 
-	length = security_context_str_to_sid(&selinux_state, tcon, &tsid,
-					     GFP_KERNEL);
+	length = security_context_str_to_sid(state, tcon, &tsid, GFP_KERNEL);
 	if (length)
 		goto out;
 
-	length = security_transition_sid_user(&selinux_state, ssid, tsid,
-					      tclass, objname, &newsid);
+	length = security_transition_sid_user(state, ssid, tsid, tclass,
+					      objname, &newsid);
 	if (length)
 		goto out;
 
-	length = security_sid_to_context(&selinux_state, newsid, &newcon,
-					 &len);
+	length = security_sid_to_context(state, newsid, &newcon, &len);
 	if (length)
 		goto out;
 
@@ -908,6 +965,8 @@ static ssize_t sel_write_create(struct file *file, char *buf, size_t size)
 
 static ssize_t sel_write_relabel(struct file *file, char *buf, size_t size)
 {
+	struct selinux_fs_info *fsi = file_inode(file)->i_sb->s_fs_info;
+	struct selinux_state *state = fsi->state;
 	char *scon = NULL, *tcon = NULL;
 	u32 ssid, tsid, newsid;
 	u16 tclass;
@@ -935,23 +994,19 @@ static ssize_t sel_write_relabel(struct file *file, char *buf, size_t size)
 	if (sscanf(buf, "%s %s %hu", scon, tcon, &tclass) != 3)
 		goto out;
 
-	length = security_context_str_to_sid(&selinux_state, scon, &ssid,
-					     GFP_KERNEL);
+	length = security_context_str_to_sid(state, scon, &ssid, GFP_KERNEL);
 	if (length)
 		goto out;
 
-	length = security_context_str_to_sid(&selinux_state, tcon, &tsid,
-					     GFP_KERNEL);
+	length = security_context_str_to_sid(state, tcon, &tsid, GFP_KERNEL);
 	if (length)
 		goto out;
 
-	length = security_change_sid(&selinux_state, ssid, tsid, tclass,
-				     &newsid);
+	length = security_change_sid(state, ssid, tsid, tclass, &newsid);
 	if (length)
 		goto out;
 
-	length = security_sid_to_context(&selinux_state, newsid, &newcon,
-					 &len);
+	length = security_sid_to_context(state, newsid, &newcon, &len);
 	if (length)
 		goto out;
 
@@ -970,6 +1025,8 @@ static ssize_t sel_write_relabel(struct file *file, char *buf, size_t size)
 
 static ssize_t sel_write_user(struct file *file, char *buf, size_t size)
 {
+	struct selinux_fs_info *fsi = file_inode(file)->i_sb->s_fs_info;
+	struct selinux_state *state = fsi->state;
 	char *con = NULL, *user = NULL, *ptr;
 	u32 sid, *sids = NULL;
 	ssize_t length;
@@ -997,21 +1054,18 @@ static ssize_t sel_write_user(struct file *file, char *buf, size_t size)
 	if (sscanf(buf, "%s %s", con, user) != 2)
 		goto out;
 
-	length = security_context_str_to_sid(&selinux_state, con, &sid,
-					     GFP_KERNEL);
+	length = security_context_str_to_sid(state, con, &sid, GFP_KERNEL);
 	if (length)
 		goto out;
 
-	length = security_get_user_sids(&selinux_state, sid, user, &sids,
-					&nsids);
+	length = security_get_user_sids(state, sid, user, &sids, &nsids);
 	if (length)
 		goto out;
 
 	length = sprintf(buf, "%u", nsids) + 1;
 	ptr = buf + length;
 	for (i = 0; i < nsids; i++) {
-		rc = security_sid_to_context(&selinux_state, sids[i],
-					     &newcon, &len);
+		rc = security_sid_to_context(state, sids[i], &newcon, &len);
 		if (rc) {
 			length = rc;
 			goto out;
@@ -1035,6 +1089,8 @@ static ssize_t sel_write_user(struct file *file, char *buf, size_t size)
 
 static ssize_t sel_write_member(struct file *file, char *buf, size_t size)
 {
+	struct selinux_fs_info *fsi = file_inode(file)->i_sb->s_fs_info;
+	struct selinux_state *state = fsi->state;
 	char *scon = NULL, *tcon = NULL;
 	u32 ssid, tsid, newsid;
 	u16 tclass;
@@ -1062,23 +1118,19 @@ static ssize_t sel_write_member(struct file *file, char *buf, size_t size)
 	if (sscanf(buf, "%s %s %hu", scon, tcon, &tclass) != 3)
 		goto out;
 
-	length = security_context_str_to_sid(&selinux_state, scon, &ssid,
-					     GFP_KERNEL);
+	length = security_context_str_to_sid(state, scon, &ssid, GFP_KERNEL);
 	if (length)
 		goto out;
 
-	length = security_context_str_to_sid(&selinux_state, tcon, &tsid,
-					     GFP_KERNEL);
+	length = security_context_str_to_sid(state, tcon, &tsid, GFP_KERNEL);
 	if (length)
 		goto out;
 
-	length = security_member_sid(&selinux_state, ssid, tsid, tclass,
-				     &newsid);
+	length = security_member_sid(state, ssid, tsid, tclass, &newsid);
 	if (length)
 		goto out;
 
-	length = security_sid_to_context(&selinux_state, newsid, &newcon,
-					 &len);
+	length = security_sid_to_context(state, newsid, &newcon, &len);
 	if (length)
 		goto out;
 
@@ -1112,6 +1164,8 @@ static struct inode *sel_make_inode(struct super_block *sb, int mode)
 static ssize_t sel_read_bool(struct file *filep, char __user *buf,
 			     size_t count, loff_t *ppos)
 {
+	struct selinux_fs_info *fsi = file_inode(filep)->i_sb->s_fs_info;
+	struct selinux_state *state = fsi->state;
 	char *page = NULL;
 	ssize_t length;
 	ssize_t ret;
@@ -1119,10 +1173,11 @@ static ssize_t sel_read_bool(struct file *filep, char __user *buf,
 	unsigned index = file_inode(filep)->i_ino & SEL_INO_MASK;
 	const char *name = filep->f_path.dentry->d_name.name;
 
-	mutex_lock(&sel_mutex);
+	mutex_lock(&fsi->mutex);
 
 	ret = -EINVAL;
-	if (index >= bool_num || strcmp(name, bool_pending_names[index]))
+	if (index >= fsi->bool_num || strcmp(name,
+					     fsi->bool_pending_names[index]))
 		goto out;
 
 	ret = -ENOMEM;
@@ -1130,16 +1185,16 @@ static ssize_t sel_read_bool(struct file *filep, char __user *buf,
 	if (!page)
 		goto out;
 
-	cur_enforcing = security_get_bool_value(&selinux_state, index);
+	cur_enforcing = security_get_bool_value(state, index);
 	if (cur_enforcing < 0) {
 		ret = cur_enforcing;
 		goto out;
 	}
 	length = scnprintf(page, PAGE_SIZE, "%d %d", cur_enforcing,
-			  bool_pending_values[index]);
+			  fsi->bool_pending_values[index]);
 	ret = simple_read_from_buffer(buf, count, ppos, page, length);
 out:
-	mutex_unlock(&sel_mutex);
+	mutex_unlock(&fsi->mutex);
 	free_page((unsigned long)page);
 	return ret;
 }
@@ -1147,13 +1202,14 @@ static ssize_t sel_read_bool(struct file *filep, char __user *buf,
 static ssize_t sel_write_bool(struct file *filep, const char __user *buf,
 			      size_t count, loff_t *ppos)
 {
+	struct selinux_fs_info *fsi = file_inode(filep)->i_sb->s_fs_info;
 	char *page = NULL;
 	ssize_t length;
 	int new_value;
 	unsigned index = file_inode(filep)->i_ino & SEL_INO_MASK;
 	const char *name = filep->f_path.dentry->d_name.name;
 
-	mutex_lock(&sel_mutex);
+	mutex_lock(&fsi->mutex);
 
 	length = avc_has_perm(current_sid(), SECINITSID_SECURITY,
 			      SECCLASS_SECURITY, SECURITY__SETBOOL,
@@ -1162,7 +1218,8 @@ static ssize_t sel_write_bool(struct file *filep, const char __user *buf,
 		goto out;
 
 	length = -EINVAL;
-	if (index >= bool_num || strcmp(name, bool_pending_names[index]))
+	if (index >= fsi->bool_num || strcmp(name,
+					     fsi->bool_pending_names[index]))
 		goto out;
 
 	length = -ENOMEM;
@@ -1188,11 +1245,11 @@ static ssize_t sel_write_bool(struct file *filep, const char __user *buf,
 	if (new_value)
 		new_value = 1;
 
-	bool_pending_values[index] = new_value;
+	fsi->bool_pending_values[index] = new_value;
 	length = count;
 
 out:
-	mutex_unlock(&sel_mutex);
+	mutex_unlock(&fsi->mutex);
 	kfree(page);
 	return length;
 }
@@ -1207,11 +1264,13 @@ static ssize_t sel_commit_bools_write(struct file *filep,
 				      const char __user *buf,
 				      size_t count, loff_t *ppos)
 {
+	struct selinux_fs_info *fsi = file_inode(filep)->i_sb->s_fs_info;
+	struct selinux_state *state = fsi->state;
 	char *page = NULL;
 	ssize_t length;
 	int new_value;
 
-	mutex_lock(&sel_mutex);
+	mutex_lock(&fsi->mutex);
 
 	length = avc_has_perm(current_sid(), SECINITSID_SECURITY,
 			      SECCLASS_SECURITY, SECURITY__SETBOOL,
@@ -1240,15 +1299,15 @@ static ssize_t sel_commit_bools_write(struct file *filep,
 		goto out;
 
 	length = 0;
-	if (new_value && bool_pending_values)
-		length = security_set_bools(&selinux_state, bool_num,
-					    bool_pending_values);
+	if (new_value && fsi->bool_pending_values)
+		length = security_set_bools(state, fsi->bool_num,
+					    fsi->bool_pending_values);
 
 	if (!length)
 		length = count;
 
 out:
-	mutex_unlock(&sel_mutex);
+	mutex_unlock(&fsi->mutex);
 	kfree(page);
 	return length;
 }
@@ -1266,12 +1325,12 @@ static void sel_remove_entries(struct dentry *de)
 
 #define BOOL_DIR_NAME "booleans"
 
-static int sel_make_bools(void)
+static int sel_make_bools(struct selinux_fs_info *fsi)
 {
 	int i, ret;
 	ssize_t len;
 	struct dentry *dentry = NULL;
-	struct dentry *dir = bool_dir;
+	struct dentry *dir = fsi->bool_dir;
 	struct inode *inode = NULL;
 	struct inode_security_struct *isec;
 	char **names = NULL, *page;
@@ -1280,13 +1339,13 @@ static int sel_make_bools(void)
 	u32 sid;
 
 	/* remove any existing files */
-	for (i = 0; i < bool_num; i++)
-		kfree(bool_pending_names[i]);
-	kfree(bool_pending_names);
-	kfree(bool_pending_values);
-	bool_num = 0;
-	bool_pending_names = NULL;
-	bool_pending_values = NULL;
+	for (i = 0; i < fsi->bool_num; i++)
+		kfree(fsi->bool_pending_names[i]);
+	kfree(fsi->bool_pending_names);
+	kfree(fsi->bool_pending_values);
+	fsi->bool_num = 0;
+	fsi->bool_pending_names = NULL;
+	fsi->bool_pending_values = NULL;
 
 	sel_remove_entries(dir);
 
@@ -1295,7 +1354,7 @@ static int sel_make_bools(void)
 	if (!page)
 		goto out;
 
-	ret = security_get_bools(&selinux_state, &num, &names, &values);
+	ret = security_get_bools(fsi->state, &num, &names, &values);
 	if (ret)
 		goto out;
 
@@ -1316,7 +1375,7 @@ static int sel_make_bools(void)
 			goto out;
 
 		isec = (struct inode_security_struct *)inode->i_security;
-		ret = security_genfs_sid(&selinux_state, "selinuxfs", page,
+		ret = security_genfs_sid(fsi->state, "selinuxfs", page,
 					 SECCLASS_FILE, &sid);
 		if (ret) {
 			pr_warn_ratelimited("SELinux: no sid found, defaulting to security isid for %s\n",
@@ -1330,9 +1389,9 @@ static int sel_make_bools(void)
 		inode->i_ino = i|SEL_BOOL_INO_OFFSET;
 		d_add(dentry, inode);
 	}
-	bool_num = num;
-	bool_pending_names = names;
-	bool_pending_values = values;
+	fsi->bool_num = num;
+	fsi->bool_pending_names = names;
+	fsi->bool_pending_values = values;
 
 	free_page((unsigned long)page);
 	return 0;
@@ -1350,10 +1409,6 @@ static int sel_make_bools(void)
 	return ret;
 }
 
-#define NULL_FILE_NAME "null"
-
-struct path selinux_null;
-
 static ssize_t sel_read_avc_cache_threshold(struct file *filp, char __user *buf,
 					    size_t count, loff_t *ppos)
 {
@@ -1503,6 +1558,8 @@ static const struct file_operations sel_avc_cache_stats_ops = {
 
 static int sel_make_avc_files(struct dentry *dir)
 {
+	struct super_block *sb = dir->d_sb;
+	struct selinux_fs_info *fsi = sb->s_fs_info;
 	int i;
 	static const struct tree_descr files[] = {
 		{ "cache_threshold",
@@ -1526,7 +1583,7 @@ static int sel_make_avc_files(struct dentry *dir)
 			return -ENOMEM;
 
 		inode->i_fop = files[i].ops;
-		inode->i_ino = ++sel_last_ino;
+		inode->i_ino = ++fsi->last_ino;
 		d_add(dentry, inode);
 	}
 
@@ -1536,12 +1593,14 @@ static int sel_make_avc_files(struct dentry *dir)
 static ssize_t sel_read_initcon(struct file *file, char __user *buf,
 				size_t count, loff_t *ppos)
 {
+	struct selinux_fs_info *fsi = file_inode(file)->i_sb->s_fs_info;
+	struct selinux_state *state = fsi->state;
 	char *con;
 	u32 sid, len;
 	ssize_t ret;
 
 	sid = file_inode(file)->i_ino&SEL_INO_MASK;
-	ret = security_sid_to_context(&selinux_state, sid, &con, &len);
+	ret = security_sid_to_context(state, sid, &con, &len);
 	if (ret)
 		return ret;
 
@@ -1629,13 +1688,14 @@ static const struct file_operations sel_perm_ops = {
 static ssize_t sel_read_policycap(struct file *file, char __user *buf,
 				  size_t count, loff_t *ppos)
 {
+	struct selinux_fs_info *fsi = file_inode(file)->i_sb->s_fs_info;
+	struct selinux_state *state = fsi->state;
 	int value;
 	char tmpbuf[TMPBUFLEN];
 	ssize_t length;
 	unsigned long i_ino = file_inode(file)->i_ino;
 
-	value = security_policycap_supported(&selinux_state,
-					     i_ino & SEL_INO_MASK);
+	value = security_policycap_supported(state, i_ino & SEL_INO_MASK);
 	length = scnprintf(tmpbuf, TMPBUFLEN, "%d", value);
 
 	return simple_read_from_buffer(buf, count, ppos, tmpbuf, length);
@@ -1649,11 +1709,12 @@ static const struct file_operations sel_policycap_ops = {
 static int sel_make_perm_files(char *objclass, int classvalue,
 				struct dentry *dir)
 {
+	struct selinux_fs_info *fsi = dir->d_sb->s_fs_info;
+	struct selinux_state *state = fsi->state;
 	int i, rc, nperms;
 	char **perms;
 
-	rc = security_get_permissions(&selinux_state, objclass, &perms,
-				      &nperms);
+	rc = security_get_permissions(state, objclass, &perms, &nperms);
 	if (rc)
 		return rc;
 
@@ -1687,6 +1748,8 @@ static int sel_make_perm_files(char *objclass, int classvalue,
 static int sel_make_class_dir_entries(char *classname, int index,
 					struct dentry *dir)
 {
+	struct super_block *sb = dir->d_sb;
+	struct selinux_fs_info *fsi = sb->s_fs_info;
 	struct dentry *dentry = NULL;
 	struct inode *inode = NULL;
 	int rc;
@@ -1703,7 +1766,7 @@ static int sel_make_class_dir_entries(char *classname, int index,
 	inode->i_ino = sel_class_to_ino(index);
 	d_add(dentry, inode);
 
-	dentry = sel_make_dir(dir, "perms", &last_class_ino);
+	dentry = sel_make_dir(dir, "perms", &fsi->last_class_ino);
 	if (IS_ERR(dentry))
 		return PTR_ERR(dentry);
 
@@ -1712,26 +1775,27 @@ static int sel_make_class_dir_entries(char *classname, int index,
 	return rc;
 }
 
-static int sel_make_classes(void)
+static int sel_make_classes(struct selinux_fs_info *fsi)
 {
+
 	int rc, nclasses, i;
 	char **classes;
 
 	/* delete any existing entries */
-	sel_remove_entries(class_dir);
+	sel_remove_entries(fsi->class_dir);
 
-	rc = security_get_classes(&selinux_state, &classes, &nclasses);
+	rc = security_get_classes(fsi->state, &classes, &nclasses);
 	if (rc)
 		return rc;
 
 	/* +2 since classes are 1-indexed */
-	last_class_ino = sel_class_to_ino(nclasses + 2);
+	fsi->last_class_ino = sel_class_to_ino(nclasses + 2);
 
 	for (i = 0; i < nclasses; i++) {
 		struct dentry *class_name_dir;
 
-		class_name_dir = sel_make_dir(class_dir, classes[i],
-				&last_class_ino);
+		class_name_dir = sel_make_dir(fsi->class_dir, classes[i],
+					      &fsi->last_class_ino);
 		if (IS_ERR(class_name_dir)) {
 			rc = PTR_ERR(class_name_dir);
 			goto out;
@@ -1751,25 +1815,25 @@ static int sel_make_classes(void)
 	return rc;
 }
 
-static int sel_make_policycap(void)
+static int sel_make_policycap(struct selinux_fs_info *fsi)
 {
 	unsigned int iter;
 	struct dentry *dentry = NULL;
 	struct inode *inode = NULL;
 
-	sel_remove_entries(policycap_dir);
+	sel_remove_entries(fsi->policycap_dir);
 
 	for (iter = 0; iter <= POLICYDB_CAPABILITY_MAX; iter++) {
 		if (iter < ARRAY_SIZE(selinux_policycap_names))
-			dentry = d_alloc_name(policycap_dir,
+			dentry = d_alloc_name(fsi->policycap_dir,
 					      selinux_policycap_names[iter]);
 		else
-			dentry = d_alloc_name(policycap_dir, "unknown");
+			dentry = d_alloc_name(fsi->policycap_dir, "unknown");
 
 		if (dentry == NULL)
 			return -ENOMEM;
 
-		inode = sel_make_inode(policycap_dir->d_sb, S_IFREG | S_IRUGO);
+		inode = sel_make_inode(fsi->sb, S_IFREG | 0444);
 		if (inode == NULL)
 			return -ENOMEM;
 
@@ -1808,8 +1872,11 @@ static struct dentry *sel_make_dir(struct dentry *dir, const char *name,
 	return dentry;
 }
 
+#define NULL_FILE_NAME "null"
+
 static int sel_fill_super(struct super_block *sb, void *data, int silent)
 {
+	struct selinux_fs_info *fsi;
 	int ret;
 	struct dentry *dentry;
 	struct inode *inode;
@@ -1837,14 +1904,20 @@ static int sel_fill_super(struct super_block *sb, void *data, int silent)
 					S_IWUGO},
 		/* last one */ {""}
 	};
+
+	ret = selinux_fs_info_create(sb);
+	if (ret)
+		goto err;
+
 	ret = simple_fill_super(sb, SELINUX_MAGIC, selinux_files);
 	if (ret)
 		goto err;
 
-	bool_dir = sel_make_dir(sb->s_root, BOOL_DIR_NAME, &sel_last_ino);
-	if (IS_ERR(bool_dir)) {
-		ret = PTR_ERR(bool_dir);
-		bool_dir = NULL;
+	fsi = sb->s_fs_info;
+	fsi->bool_dir = sel_make_dir(sb->s_root, BOOL_DIR_NAME, &fsi->last_ino);
+	if (IS_ERR(fsi->bool_dir)) {
+		ret = PTR_ERR(fsi->bool_dir);
+		fsi->bool_dir = NULL;
 		goto err;
 	}
 
@@ -1858,7 +1931,7 @@ static int sel_fill_super(struct super_block *sb, void *data, int silent)
 	if (!inode)
 		goto err;
 
-	inode->i_ino = ++sel_last_ino;
+	inode->i_ino = ++fsi->last_ino;
 	isec = (struct inode_security_struct *)inode->i_security;
 	isec->sid = SECINITSID_DEVNULL;
 	isec->sclass = SECCLASS_CHR_FILE;
@@ -1866,9 +1939,8 @@ static int sel_fill_super(struct super_block *sb, void *data, int silent)
 
 	init_special_inode(inode, S_IFCHR | S_IRUGO | S_IWUGO, MKDEV(MEM_MAJOR, 3));
 	d_add(dentry, inode);
-	selinux_null.dentry = dentry;
 
-	dentry = sel_make_dir(sb->s_root, "avc", &sel_last_ino);
+	dentry = sel_make_dir(sb->s_root, "avc", &fsi->last_ino);
 	if (IS_ERR(dentry)) {
 		ret = PTR_ERR(dentry);
 		goto err;
@@ -1878,7 +1950,7 @@ static int sel_fill_super(struct super_block *sb, void *data, int silent)
 	if (ret)
 		goto err;
 
-	dentry = sel_make_dir(sb->s_root, "initial_contexts", &sel_last_ino);
+	dentry = sel_make_dir(sb->s_root, "initial_contexts", &fsi->last_ino);
 	if (IS_ERR(dentry)) {
 		ret = PTR_ERR(dentry);
 		goto err;
@@ -1888,42 +1960,79 @@ static int sel_fill_super(struct super_block *sb, void *data, int silent)
 	if (ret)
 		goto err;
 
-	class_dir = sel_make_dir(sb->s_root, "class", &sel_last_ino);
-	if (IS_ERR(class_dir)) {
-		ret = PTR_ERR(class_dir);
-		class_dir = NULL;
+	fsi->class_dir = sel_make_dir(sb->s_root, "class", &fsi->last_ino);
+	if (IS_ERR(fsi->class_dir)) {
+		ret = PTR_ERR(fsi->class_dir);
+		fsi->class_dir = NULL;
 		goto err;
 	}
 
-	policycap_dir = sel_make_dir(sb->s_root, "policy_capabilities", &sel_last_ino);
-	if (IS_ERR(policycap_dir)) {
-		ret = PTR_ERR(policycap_dir);
-		policycap_dir = NULL;
+	fsi->policycap_dir = sel_make_dir(sb->s_root, "policy_capabilities",
+					  &fsi->last_ino);
+	if (IS_ERR(fsi->policycap_dir)) {
+		ret = PTR_ERR(fsi->policycap_dir);
+		fsi->policycap_dir = NULL;
 		goto err;
 	}
+
+	ret = sel_make_policy_nodes(fsi);
+	if (ret)
+		goto err;
 	return 0;
 err:
 	printk(KERN_ERR "SELinux: %s:  failed while creating inodes\n",
 		__func__);
+
 	return ret;
 }
 
+static int selinuxfs_compare(struct super_block *sb, void *p)
+{
+	struct selinux_fs_info *fsi = sb->s_fs_info;
+
+	return (&selinux_state == fsi->state);
+}
+
 static struct dentry *sel_mount(struct file_system_type *fs_type,
 		      int flags, const char *dev_name, void *data)
 {
-	return mount_single(fs_type, flags, data, sel_fill_super);
+	int (*fill_super)(struct super_block *, void *, int) = sel_fill_super;
+	struct super_block *s;
+	int error;
+
+	s = sget(fs_type, selinuxfs_compare, set_anon_super, flags, NULL);
+	if (IS_ERR(s))
+		return ERR_CAST(s);
+	if (!s->s_root) {
+		error = fill_super(s, data, flags & MS_SILENT ? 1 : 0);
+		if (error) {
+			deactivate_locked_super(s);
+			return ERR_PTR(error);
+		}
+		s->s_flags |= MS_ACTIVE;
+	}
+	return dget(s->s_root);
+}
+
+static void sel_kill_sb(struct super_block *sb)
+{
+	selinux_fs_info_free(sb);
+	kill_litter_super(sb);
 }
 
 static struct file_system_type sel_fs_type = {
 	.name		= "selinuxfs",
 	.mount		= sel_mount,
-	.kill_sb	= kill_litter_super,
+	.kill_sb	= sel_kill_sb,
 };
 
 struct vfsmount *selinuxfs_mount;
+struct path selinux_null;
 
 static int __init init_sel_fs(void)
 {
+	struct qstr null_name = QSTR_INIT(NULL_FILE_NAME,
+					  sizeof(NULL_FILE_NAME)-1);
 	int err;
 
 	if (!selinux_enabled)
@@ -1945,6 +2054,13 @@ static int __init init_sel_fs(void)
 		err = PTR_ERR(selinuxfs_mount);
 		selinuxfs_mount = NULL;
 	}
+	selinux_null.dentry = d_hash_and_lookup(selinux_null.mnt->mnt_root,
+						&null_name);
+	if (IS_ERR(selinux_null.dentry)) {
+		pr_err("selinuxfs:  could not lookup null!\n");
+		err = PTR_ERR(selinux_null.dentry);
+		selinux_null.dentry = NULL;
+	}
 
 	return err;
 }
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index 4785ca552d51..ccfa65f6bc17 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -2811,6 +2811,13 @@ int security_get_bools(struct selinux_state *state,
 	struct policydb *policydb;
 	int i, rc;
 
+	if (!state->initialized) {
+		*len = 0;
+		*names = NULL;
+		*values = NULL;
+		return 0;
+	}
+
 	read_lock(&state->ss->policy_rwlock);
 
 	policydb = &state->ss->policydb;
@@ -3141,6 +3148,12 @@ int security_get_classes(struct selinux_state *state,
 	struct policydb *policydb = &state->ss->policydb;
 	int rc;
 
+	if (!state->initialized) {
+		*nclasses = 0;
+		*classes = NULL;
+		return 0;
+	}
+
 	read_lock(&state->ss->policy_rwlock);
 
 	rc = -ENOMEM;
-- 
2.14.3
