From: James Morris <jmorris@namei.org>
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov, eparis@redhat.com,
        linux-security-module@vger.kernel.org,
        James Morris <jmorris@namei.org>
Subject: [PATCH 13/13] selinux: remove secondary ops call to file_mprotect
Date: Wed, 28 Jan 2009 19:55:41 -0800
Message-Id: <1233201347-17568-14-git-send-email-jmorris@namei.org>
In-Reply-To: <1233201347-17568-13-git-send-email-jmorris@namei.org>
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
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Remove secondary ops call to file_mprotect, which is
a noop in capabilities.

Signed-off-by: James Morris <jmorris@namei.org>
---
 security/selinux/hooks.c |    6 ------
 1 files changed, 0 insertions(+), 6 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 7056570..99758ca 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -3212,12 +3212,6 @@ static int selinux_dentry_open(struct file *file, const struct cred *cred)
 
 static int selinux_task_create(unsigned long clone_flags)
 {
-	int rc;
-
-	rc = secondary_ops->task_create(clone_flags);
-	if (rc)
-		return rc;
-
 	return current_has_perm(current, PROCESS__FORK);
 }
 
-- 
1.6.1


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
