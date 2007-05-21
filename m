From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: sds@tycho.nsa.gov, jmorris@redhat.com, eparis@redhat.com
Cc: selinux@tycho.nsa.gov, "Christopher J. PeBenito" <cpebenito@tresys.com>
Subject: [PATCH 3/4] selinux: change sel_make_dir() to specify inode counter.
Date: Mon, 21 May 2007 11:38:35 -0400
Message-Id: <1179761920707-git-send-email-cpebenito@tresys.com>
In-Reply-To: <1179761918482-git-send-email-cpebenito@tresys.com>
References: <11797619161088-git-send-email-cpebenito@tresys.com>
 <11797619172804-git-send-email-cpebenito@tresys.com>
 <1179761918482-git-send-email-cpebenito@tresys.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

From: Christopher J. PeBenito <cpebenito@tresys.com>

Specify the inode counter explicitly in sel_make_dir(), rather than always
using sel_last_ino.

Signed-off-by: Christopher J. PeBenito <cpebenito@tresys.com>

---
 security/selinux/selinuxfs.c |   11 ++++++-----
 1 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index 9c7b6ef..95051b1 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -1293,7 +1293,8 @@ out:
 	return ret;
 }
 
-static int sel_make_dir(struct inode *dir, struct dentry *dentry)
+static int sel_make_dir(struct inode *dir, struct dentry *dentry,
+			unsigned long *ino)
 {
 	int ret = 0;
 	struct inode *inode;
@@ -1305,7 +1306,7 @@ static int sel_make_dir(struct inode *dir, struct dentry *dentry)
 	}
 	inode->i_op = &simple_dir_inode_operations;
 	inode->i_fop = &simple_dir_operations;
-	inode->i_ino = ++sel_last_ino;
+	inode->i_ino = ++(*ino);
 	/* directory inodes start off with i_nlink == 2 (for "." entry) */
 	inc_nlink(inode);
 	d_add(dentry, inode);
@@ -1351,7 +1352,7 @@ static int sel_fill_super(struct super_block * sb, void * data, int silent)
 		goto err;
 	}
 
-	ret = sel_make_dir(root_inode, dentry);
+	ret = sel_make_dir(root_inode, dentry, &sel_last_ino);
 	if (ret)
 		goto err;
 
@@ -1384,7 +1385,7 @@ static int sel_fill_super(struct super_block * sb, void * data, int silent)
 		goto err;
 	}
 
-	ret = sel_make_dir(root_inode, dentry);
+	ret = sel_make_dir(root_inode, dentry, &sel_last_ino);
 	if (ret)
 		goto err;
 
@@ -1398,7 +1399,7 @@ static int sel_fill_super(struct super_block * sb, void * data, int silent)
 		goto err;
 	}
 
-	ret = sel_make_dir(root_inode, dentry);
+	ret = sel_make_dir(root_inode, dentry, &sel_last_ino);
 	if (ret)
 		goto err;
 
-- 
1.5.1.4


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
