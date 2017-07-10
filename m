Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v6A7vlbv011240
 for <selinux@tycho.nsa.gov>; Mon, 10 Jul 2017 03:57:47 -0400
Received: by mail-pg0-f45.google.com with SMTP id j186so45440293pge.2
 for <selinux@tycho.nsa.gov>; Mon, 10 Jul 2017 00:57:46 -0700 (PDT)
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
Subject: [PATCH v2 7/8] exec: Consolidate pdeath_signal clearing
Date: Mon, 10 Jul 2017 00:57:30 -0700
Message-Id: <1499673451-66160-8-git-send-email-keescook@chromium.org>
In-Reply-To: <1499673451-66160-1-git-send-email-keescook@chromium.org>
References: <1499673451-66160-1-git-send-email-keescook@chromium.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Instead of an additional secureexec check for pdeath_signal, just move it
up into the initial secureexec test. Neither perf nor arch code touches
pdeath_signal, so the relocation shouldn't change anything.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 fs/exec.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index eeb8323977d1..e0186db02f90 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1340,6 +1340,9 @@ void setup_new_exec(struct linux_binprm * bprm)
 	if (security_bprm_secureexec(bprm)) {
 		/* Record for AT_SECURE. */
 		bprm->secureexec = 1;
+
+		/* Make sure parent cannot signal privileged process. */
+		current->pdeath_signal = 0;
 	}
 
 	arch_pick_mmap_layout(current->mm);
@@ -1363,10 +1366,6 @@ void setup_new_exec(struct linux_binprm * bprm)
 	 */
 	current->mm->task_size = TASK_SIZE;
 
-	if (bprm->secureexec) {
-		current->pdeath_signal = 0;
-	}
-
 	/* An exec changes our domain. We are no longer part of the thread
 	   group */
 	current->self_exec_id++;
-- 
2.7.4
