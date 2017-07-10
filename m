Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v6A7vfKI011190
 for <selinux@tycho.nsa.gov>; Mon, 10 Jul 2017 03:57:42 -0400
Received: by mail-pf0-f174.google.com with SMTP id c73so45965672pfk.2
 for <selinux@tycho.nsa.gov>; Mon, 10 Jul 2017 00:57:41 -0700 (PDT)
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
Subject: [PATCH v2 0/8] exec: Use sane stack rlimit under secureexec
Date: Mon, 10 Jul 2017 00:57:23 -0700
Message-Id: <1499673451-66160-1-git-send-email-keescook@chromium.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

As discussed with Linus and Andy, we need to reset the stack rlimit
before we do memory layouts when execing a privilege-gaining (e.g.
setuid) program. This moves security_bprm_secureexec() earlier (with
required changes), and then lowers the stack limit when appropriate.

As a side-effect, dumpability and pdeath_signal clearing is expanded
to cover LSM definitions of secureexec (and Smack can drop its special
handler for pdeath_signal clearing).

I'd appreciate some extra eyes on this to make sure this isn't
broken in some special way. I couldn't find anything that _depended_
on security_bprm_secureexec() being called late.

Thanks!

-Kees

v2:
- fix missed current_security() uses in LSMs.
- research/consolidate dumpability setting logic
- research/consolidate pdeath_signal clearing logic
- split up logical steps a little more for easier review (and bisection)
- fix some old broken comments
