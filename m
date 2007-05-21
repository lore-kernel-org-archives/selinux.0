From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: sds@tycho.nsa.gov, jmorris@redhat.com, eparis@redhat.com
Cc: selinux@tycho.nsa.gov, "Christopher J. PeBenito" <cpebenito@tresys.com>
Subject: [PATCH 4/4] selinux: add selinuxfs structure for object class discovery
Date: Mon, 21 May 2007 11:38:36 -0400
Message-Id: <11797619233926-git-send-email-cpebenito@tresys.com>
In-Reply-To: <1179761920707-git-send-email-cpebenito@tresys.com>
References: <11797619161088-git-send-email-cpebenito@tresys.com>
 <11797619172804-git-send-email-cpebenito@tresys.com>
 <1179761918482-git-send-email-cpebenito@tresys.com>
 <1179761920707-git-send-email-cpebenito@tresys.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

From: Christopher J. PeBenito <cpebenito@tresys.com>

The structure is as follows (relative to selinuxfs root):

/class/file/index
/class/file/perms/read
/class/file/perms/write
...

Each class is allocated 33 inodes, 1 for the class index and 32 for
permissions.  Relative to SEL_CLASS_INO_OFFSET, the inode of the index file
DIV 33 is the class number.  The inode of the permission file % 33 is the
index of the permission for that class.

Signed-off-by: Christopher J. PeBenito <cpebenito@tresys.com>

---
 security/selinux/selinuxfs.c |  218 ++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 218 insertions(+), 0 deletions(-)

diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index 95051b1..e6b5bdc 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -67,6 +67,10 @@ static struct dentry *bool_dir = NULL;
 static int bool_num = 0;
 static int *bool_pending_values = NULL;
 
+/* global data for classes */
+static struct dentry *class_dir = NULL;
+static unsigned long last_class_ino;
+
 extern void selnl_notify_setenforce(int val);
 
 /* Check whether a task is allowed to use a security operation. */
@@ -106,6 +110,7 @@ static unsigned long sel_last_ino = SEL_INO_NEXT - 1;
 
 #define SEL_INITCON_INO_OFFSET 	0x01000000
 #define SEL_BOOL_INO_OFFSET	0x02000000
+#define SEL_CLASS_INO_OFFSET	0x04000000
 #define SEL_INO_MASK		0x00ffffff
 
 #define TMPBUFLEN	12
@@ -237,6 +242,11 @@ static const struct file_operations sel_policyvers_ops = {
 
 /* declaration for sel_write_load */
 static int sel_make_bools(void);
+static int sel_make_classes(void);
+
+/* declaration for sel_make_class_dirs */
+static int sel_make_dir(struct inode *dir, struct dentry *dentry,
+			unsigned long *ino);
 
 static ssize_t sel_read_mls(struct file *filp, char __user *buf,
 				size_t count, loff_t *ppos)
@@ -287,10 +297,18 @@ static ssize_t sel_write_load(struct file * file, const char __user * buf,
 		goto out;
 
 	ret = sel_make_bools();
+	if (ret) {
+		length = ret;
+		goto out1;
+	}
+
+	ret = sel_make_classes();
 	if (ret)
 		length = ret;
 	else
 		length = count;
+
+out1:
 	audit_log(current->audit_context, GFP_KERNEL, AUDIT_MAC_POLICY_LOAD,
 		"policy loaded auid=%u",
 		audit_get_loginuid(current->audit_context));
@@ -1293,6 +1311,194 @@ out:
 	return ret;
 }
 
+#define NVECTORS 32
+#define DIV(a, b) ((a) / (b) - ((a) % (b) < 0))
+static ssize_t sel_read_class(struct file * file, char __user *buf, 
+				size_t count, loff_t *ppos)
+{
+	ssize_t rc, len;
+	char *page;
+	unsigned long ino = file->f_path.dentry->d_inode->i_ino;
+
+	page = (char *)__get_free_page(GFP_KERNEL);
+	if (!page) {
+		rc = -ENOMEM;
+		goto out;
+	}
+
+	len = snprintf(page,PAGE_SIZE,"%d",(int)DIV(ino&SEL_INO_MASK,NVECTORS+1));
+	rc = simple_read_from_buffer(buf,count,ppos,page,len);
+	free_page((unsigned long)page);
+out:
+	return rc;
+}
+
+static const struct file_operations sel_class_ops = {
+	.read		= sel_read_class,
+};
+
+static ssize_t sel_read_perm(struct file * file, char __user *buf, 
+				size_t count, loff_t *ppos)
+{
+	ssize_t rc, len;
+	char *page;
+	unsigned long ino = file->f_path.dentry->d_inode->i_ino;
+
+	page = (char *)__get_free_page(GFP_KERNEL);
+	if (!page) {
+		rc = -ENOMEM;
+		goto out;
+	}
+
+	len = snprintf(page,PAGE_SIZE,"%d",(int)(ino&SEL_INO_MASK) % (NVECTORS+1));
+	rc = simple_read_from_buffer(buf,count,ppos,page,len);
+	free_page((unsigned long)page);
+out:
+	return rc;
+}
+
+static const struct file_operations sel_perm_ops = {
+	.read		= sel_read_perm,
+};
+
+static int sel_make_perm_files(char *objclass, int classindex, struct dentry *dir)
+{
+	int i, rc = 0, nperms;
+	char **perms;
+
+	rc = security_get_permissions(objclass,&perms,&nperms);
+	if (rc)
+		goto out;
+
+	for (i = 0; i < nperms; i++) {
+		struct inode *inode;
+		struct dentry *dentry;
+
+		dentry = d_alloc_name(dir, perms[i]);
+		if (!dentry) {
+			rc = -ENOMEM;
+			goto out1;
+		}
+
+		inode = sel_make_inode(dir->d_sb, S_IFREG|S_IRUGO);
+		if (!inode) {
+			rc = -ENOMEM;
+			goto out1;
+		}
+		inode->i_fop = &sel_perm_ops;
+		inode->i_ino = (classindex * (NVECTORS+1) + i + 1) | SEL_CLASS_INO_OFFSET;
+		d_add(dentry, inode);
+	}
+
+out1:
+	for (i = 0; i < nperms; i++)
+		kfree(perms[i]);
+	kfree(perms);
+out:
+	return rc;
+}
+
+static int sel_make_class_dir_entries(char *classname, int index, struct dentry *dir)
+{
+	struct dentry *dentry = NULL;
+	struct inode *inode = NULL;
+	int rc;
+
+	dentry = d_alloc_name(dir,"index");
+	if (!dentry) {
+		rc = -ENOMEM;
+		goto out;
+	}
+
+	inode = sel_make_inode(dir->d_sb, S_IFREG|S_IRUGO);
+	if (!inode) {
+		rc = -ENOMEM;
+		goto out;
+	}
+
+	inode->i_fop = &sel_class_ops;
+	inode->i_ino = (index * (NVECTORS+1)) | SEL_CLASS_INO_OFFSET;
+	d_add(dentry, inode);
+
+	dentry = d_alloc_name(dir, "perms");
+	if (!dentry) {
+		rc = -ENOMEM;
+		goto out;
+	}
+
+	rc = sel_make_dir(dir->d_inode,dentry, &last_class_ino);
+	if (rc)
+		goto out;
+
+	rc = sel_make_perm_files(classname,index,dentry);
+
+out:
+	return rc;
+}
+
+static void sel_remove_classes(void)
+{
+	struct list_head *class_node;
+
+	list_for_each(class_node, &class_dir->d_subdirs) {
+		struct dentry *class_subdir = list_entry(class_node, struct dentry, d_u.d_child);
+		struct list_head *class_subdir_node;
+
+		list_for_each(class_subdir_node, &class_subdir->d_subdirs) {
+			struct dentry *d = list_entry(class_subdir_node, struct dentry, d_u.d_child);
+
+			if (d->d_inode)
+				if (d->d_inode->i_mode & S_IFDIR)
+					sel_remove_entries(d);
+		}
+
+		sel_remove_entries(class_subdir);
+	}
+
+	sel_remove_entries(class_dir);
+}
+
+static int sel_make_classes(void)
+{
+	int rc = 0, nclasses, i;
+	char **classes;
+
+	/* delete any existing entries */
+	sel_remove_classes();
+
+	rc = security_get_classes(&classes,&nclasses);
+	if (rc < 0)
+		goto out;
+
+	last_class_ino = ((nclasses+1) * (NVECTORS+1) + 1) | SEL_CLASS_INO_OFFSET;
+
+	for (i = 0; i < nclasses; i++) {
+		struct dentry *class_name_dir;
+
+		class_name_dir = d_alloc_name(class_dir, classes[i]);
+		if (!class_name_dir) {
+			rc = -ENOMEM;
+			goto out1;
+		}
+
+		rc = sel_make_dir(class_dir->d_inode, class_name_dir, &last_class_ino);
+		if (rc)
+			goto out1;
+
+		/* i+1 since class values are 1-indexed */
+		rc = sel_make_class_dir_entries(classes[i],i+1,class_name_dir);
+		if (rc)
+			goto out1;
+	}
+
+out1:
+	for (i = 0; i < nclasses; i++)
+		kfree(classes[i]);
+	kfree(classes);
+out:
+	return rc;
+}
+
 static int sel_make_dir(struct inode *dir, struct dentry *dentry,
 			unsigned long *ino)
 {
@@ -1407,6 +1613,18 @@ static int sel_fill_super(struct super_block * sb, void * data, int silent)
 	if (ret)
 		goto err;
 
+	dentry = d_alloc_name(sb->s_root, "class");
+	if (!dentry) {
+		ret = -ENOMEM;
+		goto err;
+	}
+
+	ret = sel_make_dir(root_inode, dentry, &sel_last_ino);
+	if (ret)
+		goto err;
+
+	class_dir = dentry;
+
 out:
 	return ret;
 err:
-- 
1.5.1.4


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
