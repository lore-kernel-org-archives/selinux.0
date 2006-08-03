Subject: [PATCH] SELinux: 3/3-v3 convert sbsec->sem to a mutex
From: Eric Paris <eparis@redhat.com>
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov, James Morris <jmorris@redhat.com>
Content-Type: text/plain
Date: Thu, 03 Aug 2006 17:07:54 -0400
Message-Id: <1154639274.8428.39.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This patch converts the semaphore in the superblock security struct to a
mutex.  No locking changes or other code changes are done.

Signed-off-by: Eric Paris <eparis@redhat.com>

 security/selinux/hooks.c          |    7 +++----
 security/selinux/include/objsec.h |    2 +-
 2 files changed, 4 insertions(+), 5 deletions(-)

--- linux-2.6-sem-changes/security/selinux/include/objsec.h.patch3	2006-08-03 14:04:07.000000000 -0400
+++ linux-2.6-sem-changes/security/selinux/include/objsec.h	2006-08-03 14:18:44.000000000 -0400
@@ -63,7 +63,7 @@ struct superblock_security_struct {
 	unsigned int behavior;          /* labeling behavior */
 	unsigned char initialized;      /* initialization flag */
 	unsigned char proc;             /* proc fs */
-	struct semaphore sem;
+	struct mutex lock;
 	struct list_head isec_head;
 	spinlock_t isec_lock;
 };
--- linux-2.6-sem-changes/security/selinux/hooks.c.patch3	2006-08-02 14:29:28.000000000 -0400
+++ linux-2.6-sem-changes/security/selinux/hooks.c	2006-08-03 14:21:48.000000000 -0400
@@ -49,7 +49,6 @@
 #include <net/ip.h>		/* for sysctl_local_port_range[] */
 #include <net/tcp.h>		/* struct or_callable used in sock_rcv_skb */
 #include <asm/uaccess.h>
-#include <asm/semaphore.h>
 #include <asm/ioctls.h>
 #include <linux/bitops.h>
 #include <linux/interrupt.h>
@@ -240,7 +239,7 @@ static int superblock_alloc_security(str
 	if (!sbsec)
 		return -ENOMEM;
 
-	init_MUTEX(&sbsec->sem);
+	mutex_init(&sbsec->lock);
 	INIT_LIST_HEAD(&sbsec->list);
 	INIT_LIST_HEAD(&sbsec->isec_head);
 	spin_lock_init(&sbsec->isec_lock);
@@ -595,7 +594,7 @@ static int superblock_doinit(struct supe
 	struct inode *inode = root->d_inode;
 	int rc = 0;
 
-	down(&sbsec->sem);
+	mutex_lock(&sbsec->lock);
 	if (sbsec->initialized)
 		goto out;
 
@@ -690,7 +689,7 @@ next_inode:
 	}
 	spin_unlock(&sbsec->isec_lock);
 out:
-	up(&sbsec->sem);
+	mutex_unlock(&sbsec->lock);
 	return rc;
 }
 



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
