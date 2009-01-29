From: James Morris <jmorris@namei.org>
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov, eparis@redhat.com,
        linux-security-module@vger.kernel.org,
        James Morris <jmorris@namei.org>
Subject: [PATCH 08/18] selinux: remove secondary ops call to inode_mknod
Date: Wed, 28 Jan 2009 19:55:36 -0800
Message-Id: <1233201347-17568-9-git-send-email-jmorris@namei.org>
In-Reply-To: <1233201347-17568-8-git-send-email-jmorris@namei.org>
References: <1233201347-17568-1-git-send-email-jmorris@namei.org>
 <1233201347-17568-2-git-send-email-jmorris@namei.org>
 <1233201347-17568-3-git-send-email-jmorris@namei.org>
 <1233201347-17568-4-git-send-email-jmorris@namei.org>
 <1233201347-17568-5-git-send-email-jmorris@namei.org>
 <1233201347-17568-6-git-send-email-jmorris@namei.org>
 <1233201347-17568-7-git-send-email-jmorris@namei.org>
 <1233201347-17568-8-git-send-email-jmorris@namei.org>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Remove secondary ops call to inode_mknod, which is
a noop in capabilities.

Signed-off-by: James Morris <jmorris@namei.org>
---
 security/selinux/hooks.c |    6 ------
 1 files changed, 0 insertions(+), 6 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index ec834dc..0362192 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -2655,12 +2655,6 @@ static int selinux_inode_rmdir(struct inode *dir, struct dentry *dentry)
 
 static int selinux_inode_mknod(struct inode *dir, struct dentry *dentry, int mode, dev_t dev)
 {
-	int rc;
-
-	rc = secondary_ops->inode_mknod(dir, dentry, mode, dev);
-	if (rc)
-		return rc;
-
 	return may_create(dir, dentry, inode_mode_to_security_class(mode));
 }
 
-- 
1.6.1


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
