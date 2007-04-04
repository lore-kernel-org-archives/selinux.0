Subject: [patch 3/3] selinux: change numbering of boolean directory inodes
	in selinuxfs
From: James Carter <jwcart2@tycho.nsa.gov>
Reply-To: jwcart2@tycho.nsa.gov
To: SELinux <selinux@tycho.nsa.gov>
Cc: Steve Smalley <sds@epoch.ncsc.mil>, James Morris <jmorris@namei.org>,
        Eric Paris <eparis@parisplace.org>
Content-Type: text/plain
Date: Wed, 04 Apr 2007 16:18:50 -0400
Message-Id: <1175717930.14463.72.camel@moss-lions.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Change the numbering of the booleans directory inodes in selinuxfs to
provide more room for new inodes without a conflict in inode numbers and
to be consistent with how inode numbering is done in the
initial_contexts directory.

Signed-off-by: James Carter <jwcart2@tycho.nsa.gov>

---

 selinuxfs.c |   11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index 62cd248..0efb9e1 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -105,6 +105,7 @@ enum sel_inos {
 static unsigned long sel_last_ino = SEL_INO_NEXT - 1;
 
 #define SEL_INITCON_INO_OFFSET 	0x01000000
+#define SEL_BOOL_INO_OFFSET	0x02000000
 #define SEL_INO_MASK		0x00ffffff
 
 #define TMPBUFLEN	12
@@ -782,8 +783,6 @@ static struct inode *sel_make_inode(struct super_block *sb, int mode)
 	return ret;
 }
 
-#define BOOL_INO_OFFSET 30
-
 static ssize_t sel_read_bool(struct file *filep, char __user *buf,
 			     size_t count, loff_t *ppos)
 {
@@ -811,14 +810,14 @@ static ssize_t sel_read_bool(struct file *filep, char __user *buf,
 	}
 
 	inode = filep->f_path.dentry->d_inode;
-	cur_enforcing = security_get_bool_value(inode->i_ino - BOOL_INO_OFFSET);
+	cur_enforcing = security_get_bool_value(inode->i_ino&SEL_INO_MASK);
 	if (cur_enforcing < 0) {
 		ret = cur_enforcing;
 		goto out;
 	}
 
 	length = scnprintf(page, PAGE_SIZE, "%d %d", cur_enforcing,
-			  bool_pending_values[inode->i_ino - BOOL_INO_OFFSET]);
+			  bool_pending_values[inode->i_ino&SEL_INO_MASK]);
 	ret = simple_read_from_buffer(buf, count, ppos, page, length);
 out:
 	mutex_unlock(&sel_mutex);
@@ -870,7 +869,7 @@ static ssize_t sel_write_bool(struct file *filep, const char __user *buf,
 		new_value = 1;
 
 	inode = filep->f_path.dentry->d_inode;
-	bool_pending_values[inode->i_ino - BOOL_INO_OFFSET] = new_value;
+	bool_pending_values[inode->i_ino&SEL_INO_MASK] = new_value;
 	length = count;
 
 out:
@@ -1034,7 +1033,7 @@ static int sel_make_bools(void)
 		isec->sid = sid;
 		isec->initialized = 1;
 		inode->i_fop = &sel_bool_ops;
-		inode->i_ino = i + BOOL_INO_OFFSET;
+		inode->i_ino = i|SEL_BOOL_INO_OFFSET;
 		d_add(dentry, inode);
 	}
 	bool_num = num;


-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
