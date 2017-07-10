Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v6A7vfKL011190
 for <selinux@tycho.nsa.gov>; Mon, 10 Jul 2017 03:57:43 -0400
Received: by mail-pf0-f181.google.com with SMTP id q86so45938477pfl.3
 for <selinux@tycho.nsa.gov>; Mon, 10 Jul 2017 00:57:40 -0700 (PDT)
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
Subject: [PATCH v2 1/8] exec: Correct comments about "point of no return"
Date: Mon, 10 Jul 2017 00:57:24 -0700
Message-Id: <1499673451-66160-2-git-send-email-keescook@chromium.org>
In-Reply-To: <1499673451-66160-1-git-send-email-keescook@chromium.org>
References: <1499673451-66160-1-git-send-email-keescook@chromium.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

In commit 221af7f87b97 ("Split 'flush_old_exec' into two functions"),
the comment about the point of no return should have stayed in
flush_old_exec() since it refers to "bprm->mm = NULL;" line, but prior
changes in commits c89681ed7d0e ("remove steal_locks()"), and
fd8328be874f ("sanitize handling of shared descriptor tables in failing
execve()") made it look like it meant the current->sas_ss_sp line instead.

The comment is referring to the fact that once bprm->mm is NULL, all
failures from a binfmt load_binary hook (e.g. load_elf_binary), will
get SEGV raised against current. Move this comment and expand the
explanation a bit, putting it above the assignment this time.

This also removes an erroneous commet about when credentials are being
installed. That has its own dedicated function, install_exec_creds(),
which carries a similar (and correct) comment, so remove the bogus comment
where installation is not actually happening.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 fs/exec.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 904199086490..7842ae661e34 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1285,7 +1285,14 @@ int flush_old_exec(struct linux_binprm * bprm)
 	if (retval)
 		goto out;
 
-	bprm->mm = NULL;		/* We're using it now */
+	/*
+	 * After clearing bprm->mm (to mark that current is using the
+	 * prepared mm now), we are at the point of no return. If
+	 * anything from here on returns an error, the check in
+	 * search_binary_handler() will kill current (since the mm has
+	 * been replaced).
+	 */
+	bprm->mm = NULL;
 
 	set_fs(USER_DS);
 	current->flags &= ~(PF_RANDOMIZE | PF_FORKNOEXEC | PF_KTHREAD |
@@ -1332,7 +1339,6 @@ void setup_new_exec(struct linux_binprm * bprm)
 {
 	arch_pick_mmap_layout(current->mm);
 
-	/* This is the point of no return */
 	current->sas_ss_sp = current->sas_ss_size = 0;
 
 	if (uid_eq(current_euid(), current_uid()) && gid_eq(current_egid(), current_gid()))
@@ -1350,7 +1356,6 @@ void setup_new_exec(struct linux_binprm * bprm)
 	 */
 	current->mm->task_size = TASK_SIZE;
 
-	/* install the new credentials */
 	if (!uid_eq(bprm->cred->uid, current_euid()) ||
 	    !gid_eq(bprm->cred->gid, current_egid())) {
 		current->pdeath_signal = 0;
-- 
2.7.4
