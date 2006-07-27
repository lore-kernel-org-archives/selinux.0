Subject: [PATCH] SELinux: 3/3 eliminate sbsec->sem altogether
From: Eric Paris <eparis@redhat.com>
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov, James Morris <jmorris@redhat.com>
Content-Type: text/plain
Date: Thu, 27 Jul 2006 13:29:29 -0400
Message-Id: <1154021369.5028.50.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This patch completely eliminates the sbsec->sem.  This was held around
the updating of the superblock security struct inside superblock_doinit.
superblock_doinit is only called from vfs_kern_mount and from
selinux_complete_init.  The operation with vfs_kern_mount is protected
from races because the &mnt->mnt_sb->s_umount write lock will always be
held in the call to security_sb_kern_mount (which works down to
superblock_doinit) so the only thing I was really concerned about was
selinux_complete_init.  It seems to me though that the ss_initialized
variable will stop infinite recursion between the two even without
locking and that we need not worry about races between vfs_kern_mount
and selinux_complete_init since nothing should be able to mount while we
are still processing the initial policy load in init.  Please though,
let me know if I am misunderstanding the race potentials of
selinux_complete_init.

Likely if we ever in the future had a way to update the superblock
security information after mounting this lock would need to be
reintroduced, but as of today I don't see it's need.

Signed-off-by: Eric Paris <eparis@redhat.com>

 security/selinux/hooks.c          |    4 ----
 security/selinux/include/objsec.h |    1 -
 2 files changed, 5 deletions(-)

--- linux-2.6-sem-changes/security/selinux/include/objsec.h.drop.sbsec.sem	2006-07-24 17:09:34.000000000 -0400
+++ linux-2.6-sem-changes/security/selinux/include/objsec.h	2006-07-24 17:09:54.000000000 -0400
@@ -63,7 +63,6 @@ struct superblock_security_struct {
 	unsigned int behavior;          /* labeling behavior */
 	unsigned char initialized;      /* initialization flag */
 	unsigned char proc;             /* proc fs */
-	struct semaphore sem;
 	struct list_head isec_head;
 	spinlock_t isec_lock;
 };
--- linux-2.6-sem-changes/security/selinux/hooks.c.drop.sbsec.sem	2006-07-24 17:09:34.000000000 -0400
+++ linux-2.6-sem-changes/security/selinux/hooks.c	2006-07-24 17:09:54.000000000 -0400
@@ -49,7 +49,6 @@
 #include <net/ip.h>		/* for sysctl_local_port_range[] */
 #include <net/tcp.h>		/* struct or_callable used in sock_rcv_skb */
 #include <asm/uaccess.h>
-#include <asm/semaphore.h>
 #include <asm/ioctls.h>
 #include <linux/bitops.h>
 #include <linux/interrupt.h>
@@ -240,7 +239,6 @@ static int superblock_alloc_security(str
 	if (!sbsec)
 		return -ENOMEM;
 
-	init_MUTEX(&sbsec->sem);
 	INIT_LIST_HEAD(&sbsec->list);
 	INIT_LIST_HEAD(&sbsec->isec_head);
 	spin_lock_init(&sbsec->isec_lock);
@@ -595,7 +593,6 @@ static int superblock_doinit(struct supe
 	struct inode *inode = root->d_inode;
 	int rc = 0;
 
-	down(&sbsec->sem);
 	if (sbsec->initialized)
 		goto out;
 
@@ -690,7 +687,6 @@ next_inode:
 	}
 	spin_unlock(&sbsec->isec_lock);
 out:
-	up(&sbsec->sem);
 	return rc;
 }
 



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
