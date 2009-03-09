From: Eric Paris <eparis@redhat.com>
Subject: [PATCH] SELinux: inode_doinit_with_dentry drop no dentry printk
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov, jmorris@namei.org
Date: Mon, 09 Mar 2009 14:35:58 -0400
Message-ID: <20090309183558.7254.906.stgit@paris.rdu.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Drop the printk message when an inode is found without an associated
dentry.  This should only happen when userspace can't be accessing those
inodes and those labels will get set correctly on the next d_instantiate.
Thus there is no reason to send this message.

Signed-off-by: Eric Paris <eparis@redhat.com>
---

 security/selinux/hooks.c |   12 +++++++++---
 1 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index c0eb2f4..e927fab 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -1278,9 +1278,15 @@ static int inode_doinit_with_dentry(struct inode *inode, struct dentry *opt_dent
 			dentry = d_find_alias(inode);
 		}
 		if (!dentry) {
-			printk(KERN_WARNING "SELinux: %s:  no dentry for dev=%s "
-			       "ino=%ld\n", __func__, inode->i_sb->s_id,
-			       inode->i_ino);
+			/*
+			 * this is can be hit on boot when a file is accessed
+			 * before the policy is loaded.  When we load policy we
+			 * may find inodes that have no dentry on the
+			 * sbsec->isec_head list.  No reason to complain as these
+			 * will get fixed up the next time we go through
+			 * inode_doinit with a dentry, before these inodes could
+			 * be used again by userspace.
+			 */
 			goto out_unlock;
 		}
 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
