Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id sB3NYPU3021622
 for <selinux@tycho.nsa.gov>; Wed, 3 Dec 2014 18:34:25 -0500
From: Paul Moore <pmoore@redhat.com>
To: James Morris <jmorris@namei.org>
Subject: [GIT PULL] SELinux patches for 3.19
Date: Wed, 03 Dec 2014 18:34:19 -0500
Message-ID: <1900089.YGF1Ms0ZgW@sifl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Hi James,

This pull request is later than usual because quite frankly I was waiting to 
see if we would get anything substantial in the SELinux next branch.  While we 
didn't end up with anything big, there is one small fix which removes an old, 
unused extern declaration.

It's been a quiet few months in SELinux kernel land.

Enjoy,
-Paul

---
The following changes since commit d950f84c1c6658faec2ecbf5b09f7e7191953394:

  selinux: convert WARN_ONCE() to printk() in selinux_nlmsg_perm()
           (2014-11-12 16:14:02 -0500)

are available in the git repository at:

  git://git.infradead.org/users/pcmoore/selinux next

for you to fetch changes up to 00fec2a10b51a071ec92da256ccd30f6b13fc55b:

  selinux: Remove security_ops extern (2014-12-01 16:42:50 -0500)

----------------------------------------------------------------
Yao Dongdong (1):
      selinux: Remove security_ops extern

 security/selinux/hooks.c | 2 --
 1 file changed, 2 deletions(-)

-- 
paul moore
security and virtualization @ redhat
