Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v6A7vipx011214
 for <selinux@tycho.nsa.gov>; Mon, 10 Jul 2017 03:57:45 -0400
Received: by mail-pf0-f169.google.com with SMTP id q86so45938774pfl.3
 for <selinux@tycho.nsa.gov>; Mon, 10 Jul 2017 00:57:42 -0700 (PDT)
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
Subject: [PATCH v2 4/8] exec: Use secureexec for clearing pdeath_signal
Date: Mon, 10 Jul 2017 00:57:27 -0700
Message-Id: <1499673451-66160-5-git-send-email-keescook@chromium.org>
In-Reply-To: <1499673451-66160-1-git-send-email-keescook@chromium.org>
References: <1499673451-66160-1-git-send-email-keescook@chromium.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Like dumpability, clearing pdeath_signal happens both in setup_new_exec()
and later in commit_creds(). The test in setup_new_exec() is different
from all other privilege comparisons, though: it is checking the new cred
(bprm) uid vs the old cred (current) euid. This appears to be a bug,
introduced by commit a6f76f23d297 ("CRED: Make execve() take advantage of
copy-on-write credentials"):

-       if (bprm->e_uid != current_euid() ||
-           bprm->e_gid != current_egid()) {
-               set_dumpable(current->mm, suid_dumpable);
+       /* install the new credentials */
+       if (bprm->cred->uid != current_euid() ||
+           bprm->cred->gid != current_egid()) {

It was bprm euid vs current euid (and egids), but the effective got
dropped. Nothing in the exec flow changes bprm->cred->uid (nor gid).
The call traces are:

	prepare_bprm_creds()
	    prepare_exec_creds()
	        prepare_creds()
	            memcpy(new_creds, old_creds, ...)
	            security_prepare_creds() (unimplemented by commoncap)
	...
	prepare_binprm()
	    bprm_fill_uid()
	        resets euid/egid to current euid/egid
	        sets euid/egid on bprm based on set*id file bits
	    security_bprm_set_creds()
		cap_bprm_set_creds()
		        handle all caps-based manipulations

so this test is effectively a test of current_uid() vs current_euid(),
which is wrong, just like the prior dumpability tests were wrong.

The commit log says "Clear pdeath_signal and set dumpable on
certain circumstances that may not be covered by commit_creds()." This
may be meaning the earlier old euid vs new euid (and egid) test that
got changed.

Luckily, as with dumpability, this is all masked by commit_creds()
which performs old/new euid and egid tests and clears pdeath_signal.

And again, like dumpability, we should include LSM secureexec logic for
pdeath_signal clearing. For example, Smack goes out of its way to clear
pdeath_signal when it finds a secureexec condition.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 fs/exec.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 3e519d4f0bd3..d7bda5b60e7b 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1361,8 +1361,7 @@ void setup_new_exec(struct linux_binprm * bprm)
 	 */
 	current->mm->task_size = TASK_SIZE;
 
-	if (!uid_eq(bprm->cred->uid, current_euid()) ||
-	    !gid_eq(bprm->cred->gid, current_egid())) {
+	if (bprm->secureexec) {
 		current->pdeath_signal = 0;
 	} else {
 		if (bprm->interp_flags & BINPRM_FLAGS_ENFORCE_NONDUMP)
-- 
2.7.4
