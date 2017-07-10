Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v6A7viq0011214
 for <selinux@tycho.nsa.gov>; Mon, 10 Jul 2017 03:57:45 -0400
Received: by mail-pg0-f51.google.com with SMTP id u62so45411204pgb.3
 for <selinux@tycho.nsa.gov>; Mon, 10 Jul 2017 00:57:43 -0700 (PDT)
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
Subject: [PATCH v2 6/8] exec: Consolidate dumpability logic
Date: Mon, 10 Jul 2017 00:57:29 -0700
Message-Id: <1499673451-66160-7-git-send-email-keescook@chromium.org>
In-Reply-To: <1499673451-66160-1-git-send-email-keescook@chromium.org>
References: <1499673451-66160-1-git-send-email-keescook@chromium.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Since it's already valid to set dumpability in the early part of
setup_new_exec(), we can consolidate the logic into a single place.
The BINPRM_FLAGS_ENFORCE_NONDUMP is set during would_dump() calls
before setup_new_exec(), so its test is safe to move as well.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 fs/exec.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index d7bda5b60e7b..eeb8323977d1 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1346,10 +1346,12 @@ void setup_new_exec(struct linux_binprm * bprm)
 
 	current->sas_ss_sp = current->sas_ss_size = 0;
 
-	if (!bprm->secureexec)
-		set_dumpable(current->mm, SUID_DUMP_USER);
-	else
+	/* Figure out dumpability. */
+	if (bprm->interp_flags & BINPRM_FLAGS_ENFORCE_NONDUMP ||
+	    bprm->secureexec)
 		set_dumpable(current->mm, suid_dumpable);
+	else
+		set_dumpable(current->mm, SUID_DUMP_USER);
 
 	arch_setup_new_exec();
 	perf_event_exec();
@@ -1363,9 +1365,6 @@ void setup_new_exec(struct linux_binprm * bprm)
 
 	if (bprm->secureexec) {
 		current->pdeath_signal = 0;
-	} else {
-		if (bprm->interp_flags & BINPRM_FLAGS_ENFORCE_NONDUMP)
-			set_dumpable(current->mm, suid_dumpable);
 	}
 
 	/* An exec changes our domain. We are no longer part of the thread
-- 
2.7.4
