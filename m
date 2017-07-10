Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v6A7viq3011214
 for <selinux@tycho.nsa.gov>; Mon, 10 Jul 2017 03:57:46 -0400
Received: by mail-pg0-f46.google.com with SMTP id k14so45639702pgr.0
 for <selinux@tycho.nsa.gov>; Mon, 10 Jul 2017 00:57:45 -0700 (PDT)
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
Subject: [PATCH v2 8/8] exec: Use sane stack rlimit under secureexec
Date: Mon, 10 Jul 2017 00:57:31 -0700
Message-Id: <1499673451-66160-9-git-send-email-keescook@chromium.org>
In-Reply-To: <1499673451-66160-1-git-send-email-keescook@chromium.org>
References: <1499673451-66160-1-git-send-email-keescook@chromium.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

For a secureexec, before memory layout selection has happened, reset the
stack rlimit to something sane to avoid the caller having control over
the resulting layouts.

$ ulimit -s
8192
$ ulimit -s unlimited
$ /bin/sh -c 'ulimit -s'
unlimited
$ sudo /bin/sh -c 'ulimit -s'
8192

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 fs/exec.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/fs/exec.c b/fs/exec.c
index e0186db02f90..1e3463854a16 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1343,6 +1343,16 @@ void setup_new_exec(struct linux_binprm * bprm)
 
 		/* Make sure parent cannot signal privileged process. */
 		current->pdeath_signal = 0;
+
+		/*
+		 * For secureexec, reset the stack limit to sane default to
+		 * avoid bad behavior from the prior rlimits. This has to
+		 * happen before arch_pick_mmap_layout(), which examines
+		 * RLIMIT_STACK, but after the point of no return to avoid
+		 * needing to clean up the change on failure.
+		 */
+		if (current->signal->rlim[RLIMIT_STACK].rlim_cur > _STK_LIM)
+			current->signal->rlim[RLIMIT_STACK].rlim_cur = _STK_LIM;
 	}
 
 	arch_pick_mmap_layout(current->mm);
-- 
2.7.4
