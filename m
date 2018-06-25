Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w5PGZU5v022511
 for <selinux@tycho.nsa.gov>; Mon, 25 Jun 2018 12:35:30 -0400
Received: by mail-qk0-f202.google.com with SMTP id z68-v6so9757771qka.16
 for <selinux@tycho.nsa.gov>; Mon, 25 Jun 2018 09:34:52 -0700 (PDT)
MIME-Version: 1.0
Date: Mon, 25 Jun 2018 18:34:25 +0200
Message-Id: <20180625163425.216965-1-jannh@google.com>
From: Jann Horn <jannh@google.com>
To: Paul Moore <paul@paul-moore.com>, Stephen Smalley <sds@tycho.nsa.gov>,
 Eric Paris <eparis@parisplace.org>, selinux@tycho.nsa.gov, jannh@google.com
Cc: security@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Subject: [PATCH] selinux: move user accesses in selinuxfs out of locked regions
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

If a user is accessing a file in selinuxfs with a pointer to a userspace
buffer that is backed by e.g. a userfaultfd, the userspace access can
stall indefinitely, which can block fsi->mutex if it is held.

For sel_read_policy(), remove the locking, since this method doesn't seem
to access anything that requires locking.

For sel_read_bool(), move the user access below the locked region.

For sel_write_bool() and sel_commit_bools_write(), move the user access
up above the locked region.

Cc: stable@vger.kernel.org
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Jann Horn <jannh@google.com>
---
 security/selinux/selinuxfs.c | 77 ++++++++++++++++--------------------
 1 file changed, 33 insertions(+), 44 deletions(-)

diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index f3d374d2ca04..065f8cea84e3 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -445,18 +445,13 @@ static ssize_t sel_read_policy(struct file *filp, char __user *buf,
 	struct policy_load_memory *plm = filp->private_data;
 	int ret;
 
-	mutex_lock(&fsi->mutex);
-
 	ret = avc_has_perm(&selinux_state,
 			   current_sid(), SECINITSID_SECURITY,
 			  SECCLASS_SECURITY, SECURITY__READ_POLICY, NULL);
 	if (ret)
-		goto out;
+		return ret;
 
-	ret = simple_read_from_buffer(buf, count, ppos, plm->data, plm->len);
-out:
-	mutex_unlock(&fsi->mutex);
-	return ret;
+	return simple_read_from_buffer(buf, count, ppos, plm->data, plm->len);
 }
 
 static vm_fault_t sel_mmap_policy_fault(struct vm_fault *vmf)
@@ -1188,25 +1183,29 @@ static ssize_t sel_read_bool(struct file *filep, char __user *buf,
 	ret = -EINVAL;
 	if (index >= fsi->bool_num || strcmp(name,
 					     fsi->bool_pending_names[index]))
-		goto out;
+		goto out_unlock;
 
 	ret = -ENOMEM;
 	page = (char *)get_zeroed_page(GFP_KERNEL);
 	if (!page)
-		goto out;
+		goto out_unlock;
 
 	cur_enforcing = security_get_bool_value(fsi->state, index);
 	if (cur_enforcing < 0) {
 		ret = cur_enforcing;
-		goto out;
+		goto out_unlock;
 	}
 	length = scnprintf(page, PAGE_SIZE, "%d %d", cur_enforcing,
 			  fsi->bool_pending_values[index]);
-	ret = simple_read_from_buffer(buf, count, ppos, page, length);
-out:
 	mutex_unlock(&fsi->mutex);
+	ret = simple_read_from_buffer(buf, count, ppos, page, length);
+out_free:
 	free_page((unsigned long)page);
 	return ret;
+
+out_unlock:
+	mutex_unlock(&fsi->mutex);
+	goto out_free;
 }
 
 static ssize_t sel_write_bool(struct file *filep, const char __user *buf,
@@ -1219,6 +1218,17 @@ static ssize_t sel_write_bool(struct file *filep, const char __user *buf,
 	unsigned index = file_inode(filep)->i_ino & SEL_INO_MASK;
 	const char *name = filep->f_path.dentry->d_name.name;
 
+	if (count >= PAGE_SIZE)
+		return -ENOMEM;
+
+	/* No partial writes. */
+	if (*ppos != 0)
+		return -EINVAL;
+
+	page = memdup_user_nul(buf, count);
+	if (IS_ERR(page))
+		return PTR_ERR(page);
+
 	mutex_lock(&fsi->mutex);
 
 	length = avc_has_perm(&selinux_state,
@@ -1233,22 +1243,6 @@ static ssize_t sel_write_bool(struct file *filep, const char __user *buf,
 					     fsi->bool_pending_names[index]))
 		goto out;
 
-	length = -ENOMEM;
-	if (count >= PAGE_SIZE)
-		goto out;
-
-	/* No partial writes. */
-	length = -EINVAL;
-	if (*ppos != 0)
-		goto out;
-
-	page = memdup_user_nul(buf, count);
-	if (IS_ERR(page)) {
-		length = PTR_ERR(page);
-		page = NULL;
-		goto out;
-	}
-
 	length = -EINVAL;
 	if (sscanf(page, "%d", &new_value) != 1)
 		goto out;
@@ -1280,6 +1274,17 @@ static ssize_t sel_commit_bools_write(struct file *filep,
 	ssize_t length;
 	int new_value;
 
+	if (count >= PAGE_SIZE)
+		return -ENOMEM;
+
+	/* No partial writes. */
+	if (*ppos != 0)
+		return -EINVAL;
+
+	page = memdup_user_nul(buf, count);
+	if (IS_ERR(page))
+		return PTR_ERR(page);
+
 	mutex_lock(&fsi->mutex);
 
 	length = avc_has_perm(&selinux_state,
@@ -1289,22 +1294,6 @@ static ssize_t sel_commit_bools_write(struct file *filep,
 	if (length)
 		goto out;
 
-	length = -ENOMEM;
-	if (count >= PAGE_SIZE)
-		goto out;
-
-	/* No partial writes. */
-	length = -EINVAL;
-	if (*ppos != 0)
-		goto out;
-
-	page = memdup_user_nul(buf, count);
-	if (IS_ERR(page)) {
-		length = PTR_ERR(page);
-		page = NULL;
-		goto out;
-	}
-
 	length = -EINVAL;
 	if (sscanf(page, "%d", &new_value) != 1)
 		goto out;
-- 
2.18.0.rc2.346.g013aa6912e-goog
