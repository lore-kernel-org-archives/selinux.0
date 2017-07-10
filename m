Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v6A7vlEa011247
 for <selinux@tycho.nsa.gov>; Mon, 10 Jul 2017 03:57:47 -0400
Received: by mail-pg0-f45.google.com with SMTP id j186so45439969pge.2
 for <selinux@tycho.nsa.gov>; Mon, 10 Jul 2017 00:57:44 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Kees Cook <keescook@chromium.org>, Andy Lutomirski <luto@kernel.org>,
 David Howells <dhowells@redhat.com>, Serge Hallyn <serge@hallyn.com>,
 John Johansen <john.johansen@canonical.com>,
 Casey Schaufler <casey@schaufler-ca.com>,
 "Eric W. Biederman" <ebiederm@xmission.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Michal Hocko <mhocko@kernel.org>, Ben Hutchings <ben@decadent.org.uk>,
 Hugh Dickins <hughd@google.com>, Oleg Nesterov <oleg@redhat.com>,
 "Jason A. Donenfeld" <Jason@zx2c4.com>, Rik van Riel <riel@redhat.com>,
 James Morris <james.l.morris@oracle.com>,
 Greg Ungerer <gerg@linux-m68k.org>, Ingo Molnar <mingo@kernel.org>,
 Nicolas Pitre <nicolas.pitre@linaro.org>,
 Stephen Smalley <sds@tycho.nsa.gov>, Paul Moore <paul@paul-moore.com>,
 Vivek Goyal <vgoyal@redhat.com>,
 =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
 Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov
Subject: [PATCH v2 5/8] smack: Remove redundant pdeath_signal clearing
Date: Mon, 10 Jul 2017 00:57:28 -0700
Message-Id: <1499673451-66160-6-git-send-email-keescook@chromium.org>
In-Reply-To: <1499673451-66160-1-git-send-email-keescook@chromium.org>
References: <1499673451-66160-1-git-send-email-keescook@chromium.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This removes the redundant pdeath_signal clearing in Smack: the check in
smack_bprm_committing_creds() matches the check in smack_bprm_secureexec(),
and since secureexec is now being checked for clearing pdeath_signal, this
is redundant to the common exec code.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 security/smack/smack_lsm.c | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 13cf9e66d5fe..4b10b782aecc 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -954,20 +954,6 @@ static int smack_bprm_set_creds(struct linux_binprm *bprm)
 }
 
 /**
- * smack_bprm_committing_creds - Prepare to install the new credentials
- * from bprm.
- *
- * @bprm: binprm for exec
- */
-static void smack_bprm_committing_creds(struct linux_binprm *bprm)
-{
-	struct task_smack *bsp = bprm->cred->security;
-
-	if (bsp->smk_task != bsp->smk_forked)
-		current->pdeath_signal = 0;
-}
-
-/**
  * smack_bprm_secureexec - Return the decision to use secureexec.
  * @bprm: binprm for exec
  *
@@ -4645,7 +4631,6 @@ static struct security_hook_list smack_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(sb_parse_opts_str, smack_parse_opts_str),
 
 	LSM_HOOK_INIT(bprm_set_creds, smack_bprm_set_creds),
-	LSM_HOOK_INIT(bprm_committing_creds, smack_bprm_committing_creds),
 	LSM_HOOK_INIT(bprm_secureexec, smack_bprm_secureexec),
 
 	LSM_HOOK_INIT(inode_alloc_security, smack_inode_alloc_security),
-- 
2.7.4
