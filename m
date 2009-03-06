Subject: [PATCH] SELinux: make inode_doinit_with_dentry printk debug
From: Eric Paris <eparis@redhat.com>
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov, jmorris@namei.org
Content-Type: text/plain
Date: Fri, 06 Mar 2009 14:23:12 -0500
Message-Id: <1236367392.3541.10.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Drop the printk level to debug when an inode is found without an associated
dentry.  This should only happen when userspace can't be accessing the
inode and the label will get set correctly on the next inode_doinit before it
can be used, so there is little reason to send this message.

Signed-off-by: Eric Paris <eparis@redhat.com>
---

 security/selinux/hooks.c |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)


diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index c0eb2f4..ce6543a 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -1278,7 +1278,14 @@ static int inode_doinit_with_dentry(struct inode *inode, struct dentry *opt_dent
 			dentry = d_find_alias(inode);
 		}
 		if (!dentry) {
-			printk(KERN_WARNING "SELinux: %s:  no dentry for dev=%s "
+			/* this is easy to hit on boot when a file is accessed
+			 * before the policy is loaded.  When we load policy we
+			 * may find inodes that have no dentry as we walk the
+			 * sbsec->isec_head list.  No reason to complain as these
+			 * as they will get fixed up the next time we go through
+			 * inode_doinit with a dentry.
+			 */
+			printk(KERN_DEBUG "SELinux: %s:  no dentry for dev=%s "
 			       "ino=%ld\n", __func__, inode->i_sb->s_id,
 			       inode->i_ino);
 			goto out_unlock;



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
