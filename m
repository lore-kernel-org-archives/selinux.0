From: Eric Paris <eparis@redhat.com>
Subject: [PATCH 1/2] SELinux: NULL terminate al contexts from disk
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov, jmorris@namei.org, paul.moore@hp.com
Date: Thu, 12 Feb 2009 14:50:05 -0500
Message-ID: <20090212195005.25556.94754.stgit@paris.rdu.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

When a context is pulled in from disk we don't know that it is null
terminated.  This patch forecebly null terminates contexts when we pull
them from disk.

Signed-off-by: Eric Paris <eparis@redhat.com>
---

 security/selinux/hooks.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 45e286c..4afaeac 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -1290,12 +1290,13 @@ static int inode_doinit_with_dentry(struct inode *inode, struct dentry *opt_dent
 		}
 
 		len = INITCONTEXTLEN;
-		context = kmalloc(len, GFP_NOFS);
+		context = kmalloc(len+1, GFP_NOFS);
 		if (!context) {
 			rc = -ENOMEM;
 			dput(dentry);
 			goto out_unlock;
 		}
+		context[len] = '\0';
 		rc = inode->i_op->getxattr(dentry, XATTR_NAME_SELINUX,
 					   context, len);
 		if (rc == -ERANGE) {
@@ -1308,12 +1309,13 @@ static int inode_doinit_with_dentry(struct inode *inode, struct dentry *opt_dent
 			}
 			kfree(context);
 			len = rc;
-			context = kmalloc(len, GFP_NOFS);
+			context = kmalloc(len+1, GFP_NOFS);
 			if (!context) {
 				rc = -ENOMEM;
 				dput(dentry);
 				goto out_unlock;
 			}
+			context[len] = '\0';
 			rc = inode->i_op->getxattr(dentry,
 						   XATTR_NAME_SELINUX,
 						   context, len);


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
