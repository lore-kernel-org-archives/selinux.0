Subject: [PATCH] SELinux: 1/3 eliminate inode_security_set_security
From: Eric Paris <eparis@redhat.com>
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov, James Morris <jmorris@redhat.com>
Content-Type: text/plain
Date: Thu, 27 Jul 2006 13:29:25 -0400
Message-Id: <1154021365.5028.46.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This patch completely eliminates the inode_security_set_security. It was
only being called from superblock_doinit.  Since there was only 1 caller
I rolled it back into superblock_doinit.  Also since superblock_doinit
is called while mounting, and before the root inode is available to
anything else we don't need to worry about locking the isec->sem.  So
the locking was completely dropped.

Signed-off-by: Eric Paris <eparis@redhat.com>

 security/selinux/hooks.c |   28 ++++++++--------------------
 1 files changed, 8 insertions(+), 20 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index a91c961..a8ff26c 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -1364,25 +1364,6 @@ static inline u32 file_to_av(struct file
 	return av;
 }
 
-/* Set an inode's SID to a specified value. */
-static int inode_security_set_sid(struct inode *inode, u32 sid)
-{
-	struct inode_security_struct *isec = inode->i_security;
-	struct superblock_security_struct *sbsec = inode->i_sb->s_security;
-
-	if (!sbsec->initialized) {
-		/* Defer initialization to selinux_complete_init. */
-		return 0;
-	}
-
-	down(&isec->sem);
-	isec->sclass = inode_mode_to_security_class(inode->i_mode);
-	isec->sid = sid;
-	isec->initialized = 1;
-	up(&isec->sem);
-	return 0;
-}
-
 /* Hook functions begin here. */
 
 static int selinux_ptrace(struct task_struct *parent, struct task_struct *child)
@@ -2091,7 +2073,13 @@ static int selinux_inode_init_security(s
 		}
 	}
 
-	inode_security_set_sid(inode, newsid);
+	/* Possibly defer initialization to selinux_complete_init. */
+	if (sbsec->initialized) {
+		struct inode_security_struct *isec = inode->i_security;
+		isec->sclass = inode_mode_to_security_class(inode->i_mode);
+		isec->sid = newsid;
+		isec->initialized = 1;
+	}
 
 	if (!ss_initialized || sbsec->behavior == SECURITY_FS_USE_MNTPOINT)
 		return -EOPNOTSUPP;



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
