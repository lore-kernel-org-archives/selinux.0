Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v183Ftta025882
 for <selinux@tycho.nsa.gov>; Tue, 7 Feb 2017 22:15:55 -0500
Received: by mail-ot0-f174.google.com with SMTP id 73so7295447otj.0
 for <selinux@tycho.nsa.gov>; Tue, 07 Feb 2017 19:15:52 -0800 (PST)
MIME-Version: 1.0
From: Paul Moore <pmoore@redhat.com>
Date: Tue, 7 Feb 2017 22:15:52 -0500
Message-ID: <CAGH-KgvgcVQpuCES4-52Yj5qTjShwDUs5fzCi+gggzRvyMCW1A@mail.gmail.com>
Subject: [GIT PULL] SELinux fixes for 4.10 (#2)
To: James Morris <jmorris@namei.org>
Cc: selinux@tycho.nsa.gov, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Hi James,

One small but significant SELinux patch to fix a bug in
/proc/self/attr/fscreate.  I'll be sending the SELinux pull-request
for v4.11 soon, but I wanted to get this out now in hopes we could
still get it into v4.10; please merge this and try to get it to Linus
before this weekend.

Thanks,
-Paul

---
The following changes since commit bfc5e3a6af397dcf9c99a6c1872458e7867c4680:

  selinux: use the kernel headers when building scripts/selinux
(2016-12-21 10:39:25 -0500)

are available in the git repository at:

  git://git.infradead.org/users/pcmoore/selinux stable-4.10

for you to fetch changes up to a050a570db0190164e7250013214e29a5a9803ee:

  selinux: fix off-by-one in setprocattr (2017-02-07 17:31:38 -0500)

----------------------------------------------------------------
Stephen Smalley (1):
      selinux: fix off-by-one in setprocattr

 security/selinux/hooks.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
paul moore
security @ redhat
