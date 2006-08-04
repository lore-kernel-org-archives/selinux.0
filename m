Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k74FNEOA012104
	for <selinux@tycho.nsa.gov>; Fri, 4 Aug 2006 11:23:14 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k74FN7CY024443
	for <selinux@tycho.nsa.gov>; Fri, 4 Aug 2006 15:23:07 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.12.11.20060308/8.12.11) with ESMTP id k74FND3u031008
	for <selinux@tycho.nsa.gov>; Fri, 4 Aug 2006 11:23:13 -0400
Subject: Re: [PATCH] SELinux: 2/3-v3.1 change isec->sem to a mutex
From: Eric Paris <eparis@parisplace.org>
To: selinux@tycho.nsa.gov
Cc: James Morris <jmorris@redhat.com>
In-Reply-To: <1154639264.8428.38.camel@localhost.localdomain>
References: <1154639264.8428.38.camel@localhost.localdomain>
Content-Type: text/plain
Date: Fri, 04 Aug 2006 11:25:55 -0400
Message-Id: <1154705155.8428.57.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2006-08-03 at 17:07 -0400, Eric Paris wrote:
> This patch converts the remaining isec->sem into a mutex.  Very similar
> locking is provided as before only in the faster smaller mutex rather
> than a semaphore.  An out_unlock path is introduced rather than the
> conditional unlocking found in the original code.
> 
> Signed-off-by: Eric Paris <eparis@redhat.com>

So as usual I'm a moron and forgot something.  Part of this part wasn't
attached (the change to the struct in objsec.h)  Below is the complete
patch.  uggh (maybe try 5 or 6 I'll finally get things right)

 security/selinux/hooks.c          |   30 ++++++++++++++----------------
 security/selinux/include/objsec.h |    2 +-
 2 files changed, 15 insertions(+), 17 deletions(-)

--- linux-2.6-sem-changes/security/selinux/include/objsec.h.patch2	2006-07-28 12:59:55.000000000 -0400
+++ linux-2.6-sem-changes/security/selinux/include/objsec.h	2006-08-03 16:52:56.000000000 -0400
@@ -44,7 +44,7 @@ struct inode_security_struct {
 	u32 sid;             /* SID of this object */
 	u16 sclass;       /* security class of this object */
 	unsigned char initialized;     /* initialization flag */
-	struct semaphore sem;
+	struct mutex lock;
 	unsigned char inherit;         /* inherit SID from parent entry */
 };
 
--- linux-2.6-sem-changes/security/selinux/hooks.c.patch2	2006-07-28 12:59:55.000000000 -0400
+++ linux-2.6-sem-changes/security/selinux/hooks.c	2006-08-04 10:59:22.000000000 -0400
@@ -69,6 +69,7 @@
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
@@ -843,15 +844,13 @@ static int inode_doinit_with_dentry(stru
 	char *context = NULL;
 	unsigned len = 0;
 	int rc = 0;
-	int hold_sem = 0;
 
 	if (isec->initialized)
 		goto out;
 
-	down(&isec->sem);
-	hold_sem = 1;
+	mutex_lock(&isec->lock);
 	if (isec->initialized)
-		goto out;
+		goto out_unlock;
 
 	sbsec = inode->i_sb->s_security;
 	if (!sbsec->initialized) {
@@ -862,7 +861,7 @@ static int inode_doinit_with_dentry(stru
 		if (list_empty(&isec->list))
 			list_add(&isec->list, &sbsec->isec_head);
 		spin_unlock(&sbsec->isec_lock);
-		goto out;
+		goto out_unlock;
 	}
 
 	switch (sbsec->behavior) {
@@ -885,7 +884,7 @@ static int inode_doinit_with_dentry(stru
 			printk(KERN_WARNING "%s:  no dentry for dev=%s "
 			       "ino=%ld\n", __FUNCTION__, inode->i_sb->s_id,
 			       inode->i_ino);
-			goto out;
+			goto out_unlock;
 		}
 
 		len = INITCONTEXTLEN;
@@ -893,7 +892,7 @@ static int inode_doinit_with_dentry(stru
 		if (!context) {
 			rc = -ENOMEM;
 			dput(dentry);
-			goto out;
+			goto out_unlock;
 		}
 		rc = inode->i_op->getxattr(dentry, XATTR_NAME_SELINUX,
 					   context, len);
@@ -903,7 +902,7 @@ static int inode_doinit_with_dentry(stru
 						   NULL, 0);
 			if (rc < 0) {
 				dput(dentry);
-				goto out;
+				goto out_unlock;
 			}
 			kfree(context);
 			len = rc;
@@ -911,7 +910,7 @@ static int inode_doinit_with_dentry(stru
 			if (!context) {
 				rc = -ENOMEM;
 				dput(dentry);
-				goto out;
+				goto out_unlock;
 			}
 			rc = inode->i_op->getxattr(dentry,
 						   XATTR_NAME_SELINUX,
@@ -924,7 +923,7 @@ static int inode_doinit_with_dentry(stru
 				       "%d for dev=%s ino=%ld\n", __FUNCTION__,
 				       -rc, inode->i_sb->s_id, inode->i_ino);
 				kfree(context);
-				goto out;
+				goto out_unlock;
 			}
 			/* Map ENODATA to the default file SID */
 			sid = sbsec->def_sid;
@@ -960,7 +959,7 @@ static int inode_doinit_with_dentry(stru
 					     isec->sclass,
 					     &sid);
 		if (rc)
-			goto out;
+			goto out_unlock;
 		isec->sid = sid;
 		break;
 	case SECURITY_FS_USE_MNTPOINT:
@@ -978,7 +977,7 @@ static int inode_doinit_with_dentry(stru
 							  isec->sclass,
 							  &sid);
 				if (rc)
-					goto out;
+					goto out_unlock;
 				isec->sid = sid;
 			}
 		}
@@ -987,12 +986,11 @@ static int inode_doinit_with_dentry(stru
 
 	isec->initialized = 1;
 
+out_unlock:
+	mutex_unlock(&isec->lock);
 out:
 	if (isec->sclass == SECCLASS_FILE)
 		isec->sclass = inode_mode_to_security_class(inode->i_mode);
-
-	if (hold_sem)
-		up(&isec->sem);
 	return rc;
 }
 



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
