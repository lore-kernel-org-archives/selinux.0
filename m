Subject: [patch 1/1] selinux:  detect dead booleans
From: Stephen Smalley <sds@tycho.nsa.gov>
To: James Morris <jmorris@namei.org>
Cc: Eric Paris <eparis@parisplace.org>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>, selinux@tycho.nsa.gov
Content-Type: text/plain
Date: Mon, 26 Nov 2007 11:12:53 -0500
Message-Id: <1196093573.26679.4.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Instead of using f_op to detect dead booleans, check the inode index
against the number of booleans and check the dentry name against the
boolean name for that index on reads and writes.  This prevents
incorrect use of a boolean file opened prior to a policy reload while
allowing valid use of it as long as it still corresponds to the same
boolean in the policy.

Signed-off-by:  Stephen Smalley <sds@tycho.nsa.gov>

---

 security/selinux/selinuxfs.c |   43 ++++++++++++++++++++++++++++++-------------
 1 file changed, 30 insertions(+), 13 deletions(-)

diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index ac6fe99..2fa483f 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -65,6 +65,7 @@ static DEFINE_MUTEX(sel_mutex);
 /* global data for booleans */
 static struct dentry *bool_dir = NULL;
 static int bool_num = 0;
+static char **bool_pending_names;
 static int *bool_pending_values = NULL;
 
 /* global data for classes */
@@ -832,11 +833,16 @@ static ssize_t sel_read_bool(struct file *filep, char __user *buf,
 	ssize_t length;
 	ssize_t ret;
 	int cur_enforcing;
-	struct inode *inode;
+	struct inode *inode = filep->f_path.dentry->d_inode;
+	unsigned index = inode->i_ino & SEL_INO_MASK;
+	const char *name = filep->f_path.dentry->d_name.name;
 
 	mutex_lock(&sel_mutex);
 
-	ret = -EFAULT;
+	if (index >= bool_num || strcmp(name, bool_pending_names[index])) {
+		ret = -EINVAL;
+		goto out;
+	}
 
 	if (count > PAGE_SIZE) {
 		ret = -EINVAL;
@@ -847,15 +853,13 @@ static ssize_t sel_read_bool(struct file *filep, char __user *buf,
 		goto out;
 	}
 
-	inode = filep->f_path.dentry->d_inode;
-	cur_enforcing = security_get_bool_value(inode->i_ino&SEL_INO_MASK);
+	cur_enforcing = security_get_bool_value(index);
 	if (cur_enforcing < 0) {
 		ret = cur_enforcing;
 		goto out;
 	}
-
 	length = scnprintf(page, PAGE_SIZE, "%d %d", cur_enforcing,
-			  bool_pending_values[inode->i_ino&SEL_INO_MASK]);
+			  bool_pending_values[index]);
 	ret = simple_read_from_buffer(buf, count, ppos, page, length);
 out:
 	mutex_unlock(&sel_mutex);
@@ -868,9 +872,11 @@ static ssize_t sel_write_bool(struct file *filep, const char __user *buf,
 			      size_t count, loff_t *ppos)
 {
 	char *page = NULL;
-	ssize_t length = -EFAULT;
+	ssize_t length;
 	int new_value;
-	struct inode *inode;
+	struct inode *inode = filep->f_path.dentry->d_inode;
+	unsigned index = inode->i_ino & SEL_INO_MASK;
+	const char *name = filep->f_path.dentry->d_name.name;
 
 	mutex_lock(&sel_mutex);
 
@@ -878,12 +884,19 @@ static ssize_t sel_write_bool(struct file *filep, const char __user *buf,
 	if (length)
 		goto out;
 
+	if (index >= bool_num || strcmp(name, bool_pending_names[index])) {
+		length = -EINVAL;
+		goto out;
+	}
+
 	if (count >= PAGE_SIZE) {
 		length = -ENOMEM;
 		goto out;
 	}
+
 	if (*ppos != 0) {
 		/* No partial writes. */
+		length = -EINVAL;
 		goto out;
 	}
 	page = (char*)get_zeroed_page(GFP_KERNEL);
@@ -892,6 +905,7 @@ static ssize_t sel_write_bool(struct file *filep, const char __user *buf,
 		goto out;
 	}
 
+	length = -EFAULT;
 	if (copy_from_user(page, buf, count))
 		goto out;
 
@@ -902,8 +916,7 @@ static ssize_t sel_write_bool(struct file *filep, const char __user *buf,
 	if (new_value)
 		new_value = 1;
 
-	inode = filep->f_path.dentry->d_inode;
-	bool_pending_values[inode->i_ino&SEL_INO_MASK] = new_value;
+	bool_pending_values[index] = new_value;
 	length = count;
 
 out:
@@ -923,7 +936,7 @@ static ssize_t sel_commit_bools_write(struct file *filep,
 				      size_t count, loff_t *ppos)
 {
 	char *page = NULL;
-	ssize_t length = -EFAULT;
+	ssize_t length;
 	int new_value;
 
 	mutex_lock(&sel_mutex);
@@ -946,6 +959,7 @@ static ssize_t sel_commit_bools_write(struct file *filep,
 		goto out;
 	}
 
+	length = -EFAULT;
 	if (copy_from_user(page, buf, count))
 		goto out;
 
@@ -1010,7 +1024,9 @@ static int sel_make_bools(void)
 	u32 sid;
 
 	/* remove any existing files */
+	kfree(bool_pending_names);
 	kfree(bool_pending_values);
+	bool_pending_names = NULL;
 	bool_pending_values = NULL;
 
 	sel_remove_entries(dir);
@@ -1052,16 +1068,17 @@ static int sel_make_bools(void)
 		d_add(dentry, inode);
 	}
 	bool_num = num;
+	bool_pending_names = names;
 	bool_pending_values = values;
 out:
 	free_page((unsigned long)page);
+	return ret;
+err:
 	if (names) {
 		for (i = 0; i < num; i++)
 			kfree(names[i]);
 		kfree(names);
 	}
-	return ret;
-err:
 	kfree(values);
 	sel_remove_entries(dir);
 	ret = -ENOMEM;

-- 
Stephen Smalley
National Security Agency




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
