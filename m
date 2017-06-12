Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v5CFeW7g013852
 for <selinux@tycho.nsa.gov>; Mon, 12 Jun 2017 11:40:33 -0400
Received: by mail-lf0-f65.google.com with SMTP id x81so9747096lfb.3
 for <selinux@tycho.nsa.gov>; Mon, 12 Jun 2017 08:40:24 -0700 (PDT)
MIME-Version: 1.0
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 12 Jun 2017 11:40:22 -0400
Message-ID: <CAHC9VhSzDC8ezTGHzOdM_L=nGRqNaUzNjtV--sYAajJ5dr3MQw@mail.gmail.com>
Subject: [GIT PULL] SELinux fixes for v4.12 (#1)
To: James Morris <jmorris@namei.org>
Cc: linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov
Content-Type: text/plain; charset="UTF-8"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Hi James,

One small double-free fix for SELinux that I think should go upstream
for v4.12.  The patch passes the selinux-testsuite and applies cleanly
to your linux-security/next branch; please merge and pass this along
to Linus.

Thanks,
-Paul

---
The following changes since commit cae303df3f379f04ce7efadb2e30de460918b302:

 selinux: Fix an uninitialized variable bug (2017-03-31 15:16:18 -0400)

are available in the git repository at:

 git://git.infradead.org/users/pcmoore/selinux stable-4.12

for you to fetch changes up to 2118b6a4b68b30f6e2bba5ac586e80ed2cc5e462:

 selinux: fix double free in selinux_parse_opts_str() (2017-06-07 16:48:19 -040
0)

----------------------------------------------------------------
Paul Moore (1):
     selinux: fix double free in selinux_parse_opts_str()

security/selinux/hooks.c | 5 ++---
1 file changed, 2 insertions(+), 3 deletions(-)

-- 
paul moore
www.paul-moore.com
