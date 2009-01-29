From: James Morris <jmorris@namei.org>
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov, eparis@redhat.com,
        linux-security-module@vger.kernel.org,
        James Morris <jmorris@namei.org>
Subject: [PATCH 03/18] selinux: remove secondary ops call to bprm_committed_creds
Date: Wed, 28 Jan 2009 19:55:31 -0800
Message-Id: <1233201347-17568-4-git-send-email-jmorris@namei.org>
In-Reply-To: <1233201347-17568-3-git-send-email-jmorris@namei.org>
References: <1233201347-17568-1-git-send-email-jmorris@namei.org>
 <1233201347-17568-2-git-send-email-jmorris@namei.org>
 <1233201347-17568-3-git-send-email-jmorris@namei.org>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Remove secondary ops call to bprm_committed_creds, which is
a noop in capabilities.

Signed-off-by: James Morris <jmorris@namei.org>
---
 security/selinux/hooks.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index fc01ffa..516058f 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -2356,8 +2356,6 @@ static void selinux_bprm_committed_creds(struct linux_binprm *bprm)
 	int rc, i;
 	unsigned long flags;
 
-	secondary_ops->bprm_committed_creds(bprm);
-
 	osid = tsec->osid;
 	sid = tsec->sid;
 
-- 
1.6.1


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
