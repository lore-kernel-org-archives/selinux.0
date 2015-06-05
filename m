Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t55Idcp2005936
 for <selinux@tycho.nsa.gov>; Fri, 5 Jun 2015 14:39:38 -0400
From: Paul Moore <pmoore@redhat.com>
To: James Morris <jmorris@namei.org>
Subject: Re: [GIT PULL] SELinux patches for 4.2
Date: Fri, 05 Jun 2015 14:34:02 -0400
Message-ID: <1470471.fn8YxcfUZR@sifl>
In-Reply-To: <alpine.LRH.2.11.1506051520430.15998@namei.org>
References: <2158515.KYehkOGLZJ@sifl>
 <alpine.LRH.2.11.1506051520430.15998@namei.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Friday, June 05, 2015 03:20:57 PM James Morris wrote:
> On Thu, 4 Jun 2015, Paul Moore wrote:
> > Hi James,
> > 
> > Six SELinux patches for 4.2: two to add better labeling support for three
> > pseudo filesystems, one netlink update, a __flush_signals() removal/fix,
> > and a couple of minor cleanup patches.  Nothing too scary or large this
> > time.
> > 
> > All patches pass the SELinux testsuite and the selinux#upstream branch is
> > based on your linux-security#next branch as of about an hour ago.
> 
> Thanks, pulled.

Hi James,

My apologies, but one more last minute patch that really should go in for v4.2 
as it fixes a labeled NFS regression.

-Paul

---
The following changes since commit 42a9699a9fa179c0054ea3cf5ad3cc67104a6162:

  selinux: Remove unused permission definitions (2015-06-04 16:22:17 -0400)

are available in the git repository at:

  git://git.infradead.org/users/pcmoore/selinux upstream

for you to fetch changes up to 9fc2b4b436cff7d8403034676014f1be9d534942:

  selinux: fix setting of security labels on NFS (2015-06-05 14:21:48 -0400)

----------------------------------------------------------------
J. Bruce Fields (1):
      selinux: fix setting of security labels on NFS

 security/selinux/hooks.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index daf59b4..312537d 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -403,6 +403,7 @@ static int selinux_is_sblabel_mnt(struct super_block *sb)
        return sbsec->behavior == SECURITY_FS_USE_XATTR ||
                sbsec->behavior == SECURITY_FS_USE_TRANS ||
                sbsec->behavior == SECURITY_FS_USE_TASK ||
+               sbsec->behavior == SECURITY_FS_USE_NATIVE ||
                /* Special handling. Genfs but also in-core setxattr handler 
*/
                !strcmp(sb->s_type->name, "sysfs") ||
                !strcmp(sb->s_type->name, "pstore") ||

-- 
paul moore
security @ redhat
