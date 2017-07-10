Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v6A7vfKK011190
 for <selinux@tycho.nsa.gov>; Mon, 10 Jul 2017 03:57:43 -0400
Received: by mail-pf0-f170.google.com with SMTP id q86so45938358pfl.3
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
Subject: [PATCH v2 3/8] exec: Use secureexec for setting dumpability
Date: Mon, 10 Jul 2017 00:57:26 -0700
Message-Id: <1499673451-66160-4-git-send-email-keescook@chromium.org>
In-Reply-To: <1499673451-66160-1-git-send-email-keescook@chromium.org>
References: <1499673451-66160-1-git-send-email-keescook@chromium.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

The examination of "current" to decide dumpability is wrong. This was a
check of and euid/uid (or egid/gid) mismatch in the existing process,
not the newly created one. This appears to stretch back into even the
"history.git" tree. Luckily, dumpability is later set in commit_creds().
In earlier kernel versions before creds existed, similar checks also
existed late in the exec flow, covering up the mistake as far back as I
could find.

The commit_creds() check examines differences of euid, uid, egid, gid,
and capabilities between the old and new creds. It would look like
the setup_new_exec() dumpability test could be entirely removed, but
strictly speaking, the secureexec test covers a different set of tests
than what commit_creds() checks for. So, fix this test to use secureexec,
which includes the same logical check (euid != uid || egid != gid),
but checks bprm->cred, not current->cred.

One would wonder if we need a security_commit_creds() LSM hook and to
move the existing checks in commit_creds() into commoncaps.c, which
would allow expanding the logic to all LSMs. Currently this doesn't
seem needed, though.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 fs/exec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/exec.c b/fs/exec.c
index b92e37fb53aa..3e519d4f0bd3 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1346,7 +1346,7 @@ void setup_new_exec(struct linux_binprm * bprm)
 
 	current->sas_ss_sp = current->sas_ss_size = 0;
 
-	if (uid_eq(current_euid(), current_uid()) && gid_eq(current_egid(), current_gid()))
+	if (!bprm->secureexec)
 		set_dumpable(current->mm, SUID_DUMP_USER);
 	else
 		set_dumpable(current->mm, suid_dumpable);
-- 
2.7.4
