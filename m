From: James Morris <jmorris@namei.org>
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov, eparis@redhat.com,
        linux-security-module@vger.kernel.org,
        James Morris <jmorris@namei.org>
Subject: [PATCH 01/18] selinux: remove unused bprm_check_security hook
Date: Wed, 28 Jan 2009 19:55:29 -0800
Message-Id: <1233201347-17568-2-git-send-email-jmorris@namei.org>
In-Reply-To: <1233201347-17568-1-git-send-email-jmorris@namei.org>
References: <1233201347-17568-1-git-send-email-jmorris@namei.org>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Remove unused bprm_check_security hook from SELinux.   This
currently calls into the capabilities hook, which is a noop.

(The capabilities hook should also be removed at some point).

Signed-off-by: James Morris <jmorris@namei.org>
---
 security/selinux/hooks.c |    6 ------
 1 files changed, 0 insertions(+), 6 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 3bb4942..8251c6b 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -2182,11 +2182,6 @@ static int selinux_bprm_set_creds(struct linux_binprm *bprm)
 	return 0;
 }
 
-static int selinux_bprm_check_security(struct linux_binprm *bprm)
-{
-	return secondary_ops->bprm_check_security(bprm);
-}
-
 static int selinux_bprm_secureexec(struct linux_binprm *bprm)
 {
 	const struct cred *cred = current_cred();
@@ -5608,7 +5603,6 @@ static struct security_operations selinux_ops = {
 	.netlink_recv =			selinux_netlink_recv,
 
 	.bprm_set_creds =		selinux_bprm_set_creds,
-	.bprm_check_security =		selinux_bprm_check_security,
 	.bprm_committing_creds =	selinux_bprm_committing_creds,
 	.bprm_committed_creds =		selinux_bprm_committed_creds,
 	.bprm_secureexec =		selinux_bprm_secureexec,
-- 
1.6.1


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
