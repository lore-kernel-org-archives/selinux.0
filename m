Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i3KFBeRb015284
	for <selinux@tycho.nsa.gov>; Tue, 20 Apr 2004 11:11:41 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i3KF9YKr000568
	for <selinux@tycho.nsa.gov>; Tue, 20 Apr 2004 15:09:34 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id i3KF9XvW000562
	for <selinux@tycho.nsa.gov>; Tue, 20 Apr 2004 15:09:33 GMT
Subject: [PATCH][SELINUX] Change context_to_sid handling for no-policy case
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Andrew Morton <akpm@osdl.org>, James Morris <jmorris@redhat.com>,
   lkml <linux-kernel@vger.kernel.org>, selinux@tycho.nsa.gov
Content-Type: text/plain
Message-Id: <1082473877.7481.37.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Tue, 20 Apr 2004 11:11:17 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This patch against 2.6.6-rc1-mm1 changes the behavior of
security_context_to_sid in the no-policy case so that it simply accepts
all contexts and maps them to the kernel SID rather than rejecting
anything other than an initial SID.  The change avoids error conditions
when using SELinux in permissive/no-policy mode, so that any file
contexts left on disk from prior use of SELinux with a policy will not
cause an error when they are looked up and userspace attempts to set
contexts can succeed.  Please apply.

 security/selinux/ss/services.c |    4 +---
 1 files changed, 1 insertion(+), 3 deletions(-)

diff -X /home/sds/dontdiff -ru linux-2.6.old/security/selinux/ss/services.c linux-2.6/security/selinux/ss/services.c
--- linux-2.6.old/security/selinux/ss/services.c	2004-04-20 09:37:45.000000000 -0400
+++ linux-2.6/security/selinux/ss/services.c	2004-04-20 09:53:02.834624857 -0400
@@ -456,9 +456,7 @@
 				goto out;
 			}
 		}
-		printk(KERN_ERR "security_context_to_sid: called before "
-		       "initial load_policy on unknown context %s\n", scontext);
-		rc = -EINVAL;
+		*sid = SECINITSID_KERNEL;
 		goto out;
 	}
 	*sid = SECSID_NULL;


-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
