From: James Morris <jmorris@namei.org>
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov, eparis@redhat.com,
        linux-security-module@vger.kernel.org,
        James Morris <jmorris@namei.org>
Subject: [PATCH 15/18] selinux: remove secondary ops call to task_setrlimit
Date: Wed, 28 Jan 2009 19:55:44 -0800
Message-Id: <1233201347-17568-17-git-send-email-jmorris@namei.org>
In-Reply-To: <1233201347-17568-16-git-send-email-jmorris@namei.org>
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
 <1233201347-17568-16-git-send-email-jmorris@namei.org>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Remove secondary ops call to task_setrlimit, which is
a noop in capabilities.

Signed-off-by: James Morris <jmorris@namei.org>
---
 security/selinux/hooks.c |    5 -----
 1 files changed, 0 insertions(+), 5 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 357be4a..6633196 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -3367,11 +3367,6 @@ static int selinux_task_getioprio(struct task_struct *p)
 static int selinux_task_setrlimit(unsigned int resource, struct rlimit *new_rlim)
 {
 	struct rlimit *old_rlim = current->signal->rlim + resource;
-	int rc;
-
-	rc = secondary_ops->task_setrlimit(resource, new_rlim);
-	if (rc)
-		return rc;
 
 	/* Control the ability to change the hard limit (whether
 	   lowering or raising it), so that the hard limit can
-- 
1.6.1


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
