Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u3JKwdUB004035
 for <selinux@tycho.nsa.gov>; Tue, 19 Apr 2016 16:58:39 -0400
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
 (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id AE2FFC05E154
 for <selinux@tycho.nsa.gov>; Tue, 19 Apr 2016 20:58:37 +0000 (UTC)
Subject: [PATCH] selinux: check ss_initialized before revalidating an inode
 label
From: Paul Moore <pmoore@redhat.com>
To: selinux@tycho.nsa.gov
Date: Tue, 19 Apr 2016 16:58:36 -0400
Message-ID: <146109951681.27582.1227236515167711599.stgit@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: Paul Moore <paul@paul-moore.com>

There is no point in trying to revalidate an inode's security label if
the security server is not yet initialized.

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/selinux/hooks.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index b09aad7..474011c 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -259,7 +259,7 @@ static int __inode_security_revalidate(struct inode *inode,
 
 	might_sleep_if(may_sleep);
 
-	if (isec->initialized != LABEL_INITIALIZED) {
+	if (ss_initialized && isec->initialized != LABEL_INITIALIZED) {
 		if (!may_sleep)
 			return -ECHILD;
 
