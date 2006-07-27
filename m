Subject: [PATCH] SELinux: 2/3 change isec->sem to a mutex
From: Eric Paris <eparis@redhat.com>
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov, James Morris <jmorris@redhat.com>
Content-Type: text/plain
Date: Thu, 27 Jul 2006 13:29:27 -0400
Message-Id: <1154021367.5028.48.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This patch converts the remaining isec->sem into a mutex.  The same
locking is provided as before only in the faster smaller mutex rather
than slower sem.

Signed-off-by: Eric Paris <eparis@redhat.com>

 security/selinux/hooks.c          |   13 +++++++------
 security/selinux/include/objsec.h |    2 +-
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index a91c961..e03bada 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -69,6 +69,7 @@ #include <linux/sysctl.h>
 #include <linux/audit.h>
 #include <linux/string.h>
 #include <linux/selinux.h>
+#include <linux/mutex.h>
 
 #include "avc.h"
 #include "objsec.h"
@@ -182,7 +183,7 @@ static int inode_alloc_security(struct i
 		return -ENOMEM;
 
 	memset(isec, 0, sizeof(*isec));
-	init_MUTEX(&isec->sem);
+	mutex_init(&isec->lock);
 	INIT_LIST_HEAD(&isec->list);
 	isec->inode = inode;
 	isec->sid = SECINITSID_UNLABELED;
@@ -843,13 +844,13 @@ #define INITCONTEXTLEN 255
 	char *context = NULL;
 	unsigned len = 0;
 	int rc = 0;
-	int hold_sem = 0;
+	int hold_lock = 0;
 
 	if (isec->initialized)
 		goto out;
 
-	down(&isec->sem);
-	hold_sem = 1;
+	mutex_lock(&isec->lock);
+	hold_lock = 1;
 	if (isec->initialized)
 		goto out;
 
@@ -991,8 +992,8 @@ out:
 	if (isec->sclass == SECCLASS_FILE)
 		isec->sclass = inode_mode_to_security_class(inode->i_mode);
 
-	if (hold_sem)
-		up(&isec->sem);
+	if (hold_lock)
+		mutex_unlock(&isec->lock);
 	return rc;
 }
 
diff --git a/security/selinux/include/objsec.h b/security/selinux/include/objsec.h
index 9401788..7841ff2 100644
--- a/security/selinux/include/objsec.h
+++ b/security/selinux/include/objsec.h
@@ -44,7 +44,7 @@ struct inode_security_struct {
 	u32 sid;             /* SID of this object */
 	u16 sclass;       /* security class of this object */
 	unsigned char initialized;     /* initialization flag */
-	struct semaphore sem;
+	struct mutex lock;
 	unsigned char inherit;         /* inherit SID from parent entry */
 };
 



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
