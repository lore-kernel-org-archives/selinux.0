Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u2SJgCgf001026
 for <selinux@tycho.nsa.gov>; Mon, 28 Mar 2016 15:42:16 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
 (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
 by mx1.redhat.com (Postfix) with ESMTPS id DEB7364385
 for <selinux@tycho.nsa.gov>; Mon, 28 Mar 2016 19:42:14 +0000 (UTC)
Subject: [PATCH] selinux: simply inode label states to INVALID and INITIALIZED
From: Paul Moore <pmoore@redhat.com>
To: selinux@tycho.nsa.gov
Date: Mon, 28 Mar 2016 15:42:13 -0400
Message-ID: <145919413391.2232.14686465186592932882.stgit@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: Paul Moore <paul@paul-moore.com>

There really is no need for LABEL_MISSING as we really only care if
the inode's label is INVALID or INITIALIZED.  Also adjust the
revalidate code to reload the label whenever the label is not
INITIALIZED so we are less sensitive to label state in the future.

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/selinux/hooks.c          |    2 +-
 security/selinux/include/objsec.h |    5 ++---
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index ec1a1a8..837c566 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -259,7 +259,7 @@ static int __inode_security_revalidate(struct inode *inode,
 
 	might_sleep_if(may_sleep);
 
-	if (isec->initialized == LABEL_INVALID) {
+	if (isec->initialized != LABEL_INITIALIZED) {
 		if (!may_sleep)
 			return -ECHILD;
 
diff --git a/security/selinux/include/objsec.h b/security/selinux/include/objsec.h
index a2ae054..c21e135 100644
--- a/security/selinux/include/objsec.h
+++ b/security/selinux/include/objsec.h
@@ -38,9 +38,8 @@ struct task_security_struct {
 };
 
 enum label_initialized {
-	LABEL_MISSING,		/* not initialized */
-	LABEL_INITIALIZED,	/* inizialized */
-	LABEL_INVALID		/* invalid */
+	LABEL_INVALID,		/* invalid or not initialized */
+	LABEL_INITIALIZED	/* initialized */
 };
 
 struct inode_security_struct {
