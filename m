Subject: [patch 1/3] selinux: explicitly number all selinuxfs inodes
From: James Carter <jwcart2@tycho.nsa.gov>
Reply-To: jwcart2@tycho.nsa.gov
To: SELinux <selinux@tycho.nsa.gov>
Cc: Steve Smalley <sds@epoch.ncsc.mil>, James Morris <jmorris@namei.org>,
        Eric Paris <eparis@parisplace.org>
Content-Type: text/plain
Date: Wed, 04 Apr 2007 16:18:39 -0400
Message-Id: <1175717919.14463.70.camel@moss-lions.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Explicitly number all selinuxfs inodes to prevent a conflict between
inodes numbered using last_ino when created with new_inode() and those
labeled explicitly.

Signed-off-by: James Carter <jwcart2@tycho.nsa.gov>

---

 security/selinux/selinuxfs.c |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index 60d18a7..e0b6cfe 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -100,8 +100,11 @@ enum sel_inos {
 	SEL_MEMBER,	/* compute polyinstantiation membership decision */
 	SEL_CHECKREQPROT, /* check requested protection, not kernel-applied one */
 	SEL_COMPAT_NET,	/* whether to use old compat network packet controls */
+	SEL_INO_NEXT,	/* The next inode number to use */
 };
 
+static unsigned long sel_last_ino = SEL_INO_NEXT - 1;
+
 #define SEL_INITCON_INO_OFFSET 	0x01000000
 #define SEL_INO_MASK		0x00ffffff
 
@@ -1237,6 +1240,7 @@ static int sel_make_avc_files(struct dentry *dir)
 			goto out;
 		}
 		inode->i_fop = files[i].ops;
+		inode->i_ino = ++sel_last_ino;
 		d_add(dentry, inode);
 	}
 out:
@@ -1304,6 +1308,7 @@ static int sel_make_dir(struct inode *dir, struct dentry *dentry)
 	}
 	inode->i_op = &simple_dir_inode_operations;
 	inode->i_fop = &simple_dir_operations;
+	inode->i_ino = ++sel_last_ino;
 	/* directory inodes start off with i_nlink == 2 (for "." entry) */
 	inc_nlink(inode);
 	d_add(dentry, inode);
@@ -1366,6 +1371,7 @@ static int sel_fill_super(struct super_block * sb, void * data, int silent)
 		ret = -ENOMEM;
 		goto err;
 	}
+	inode->i_ino = ++sel_last_ino;
 	isec = (struct inode_security_struct*)inode->i_security;
 	isec->sid = SECINITSID_DEVNULL;
 	isec->sclass = SECCLASS_CHR_FILE;

-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
