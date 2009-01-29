From: James Morris <jmorris@namei.org>
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov, eparis@redhat.com,
        linux-security-module@vger.kernel.org,
        James Morris <jmorris@namei.org>
Subject: [PATCH 14/18] selinux: remove unused cred_commit hook
Date: Wed, 28 Jan 2009 19:55:43 -0800
Message-Id: <1233201347-17568-16-git-send-email-jmorris@namei.org>
In-Reply-To: <1233201347-17568-15-git-send-email-jmorris@namei.org>
References: <1233201347-17568-1-git-send-email-jmorris@namei.org>
 <1233201347-17568-2-git-send-email-jmorris@namei.org>
 <1233201347-17568-3-git-send-email-jmorris@namei.org>
 <1233201347-17568-4-git-send-email-jmorris@namei.org>
 <1233201347-17568-5-git-send-email-jmorris@namei.org>
 <1233201347-17568-6-git-send-email-jmorris@namei.org>
 <1233201347-17568-7-git-send-email-jmorris@namei.org>
 <1233201347-17568-8-git-send-email-jmorris@namei.org>
 <1233201347-17568-9-git-send-email-jmorris@namei.org>
 <1233201347-17568-10-git-send-email-jmorris@namei.org>
 <1233201347-17568-11-git-send-email-jmorris@namei.org>
 <1233201347-17568-12-git-send-email-jmorris@namei.org>
 <1233201347-17568-13-git-send-email-jmorris@namei.org>
 <1233201347-17568-14-git-send-email-jmorris@namei.org>
 <1233201347-17568-15-git-send-email-jmorris@namei.org>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Remove unused cred_commit hook from SELinux.   This
currently calls into the capabilities hook, which is a noop.

Signed-off-by: James Morris <jmorris@namei.org>
---
 security/selinux/hooks.c |    9 ---------
 1 files changed, 0 insertions(+), 9 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 99758ca..357be4a 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -3245,14 +3245,6 @@ static int selinux_cred_prepare(struct cred *new, const struct cred *old,
 }
 
 /*
- * commit new credentials
- */
-static void selinux_cred_commit(struct cred *new, const struct cred *old)
-{
-	secondary_ops->cred_commit(new, old);
-}
-
-/*
  * set the security data for a kernel service
  * - all the creation contexts are set to unlabelled
  */
@@ -5610,7 +5602,6 @@ static struct security_operations selinux_ops = {
 	.task_create =			selinux_task_create,
 	.cred_free =			selinux_cred_free,
 	.cred_prepare =			selinux_cred_prepare,
-	.cred_commit =			selinux_cred_commit,
 	.kernel_act_as =		selinux_kernel_act_as,
 	.kernel_create_files_as =	selinux_kernel_create_files_as,
 	.task_setuid =			selinux_task_setuid,
-- 
1.6.1


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
