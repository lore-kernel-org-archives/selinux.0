Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t8PMYjVn002140
 for <selinux@tycho.nsa.gov>; Fri, 25 Sep 2015 18:34:45 -0400
Received: by lahh2 with SMTP id h2so111422399lah.0
 for <selinux@tycho.nsa.gov>; Fri, 25 Sep 2015 15:34:42 -0700 (PDT)
From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
To: Paul Moore <paul@paul-moore.com>, Stephen Smalley <sds@tycho.nsa.gov>,
 Eric Paris <eparis@parisplace.org>,
 James Morris <james.l.morris@oracle.com>,
 "Serge E. Hallyn" <serge@hallyn.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>, selinux@tycho.nsa.gov,
 linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] selinux: minor cleanup suggestions
Date: Sat, 26 Sep 2015 00:34:14 +0200
Message-Id: <1443220459-11042-1-git-send-email-linux@rasmusvillemoes.dk>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

A few random things I stumbled on.

While I'm pretty sure of the change in 1/5, I'm also confused, because
the doc for the reverse security_sid_to_context state that
@scontext_len is set to "the length of the string", which one would
normally interpret as being what strlen() would give (i.e., without
the \0). However, security_sid_to_context_core clearly includes the \0
in the return value, and I think callers rely on that.

Rasmus Villemoes (5):
  selinux: introduce security_context_str_to_sid
  selinux: remove pointless cast in selinux_inode_setsecurity()
  selinux: use kmemdup in security_sid_to_context_core()
  selinux: use kstrdup() in security_get_bools()
  selinux: use sprintf return value

 security/selinux/hooks.c            | 14 +++++---------
 security/selinux/include/security.h |  2 ++
 security/selinux/selinuxfs.c        | 26 +++++++++-----------------
 security/selinux/ss/services.c      | 22 +++++++++-------------
 4 files changed, 25 insertions(+), 39 deletions(-)

-- 
2.1.3
