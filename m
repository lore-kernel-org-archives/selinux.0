Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t5921rFM000664
 for <selinux@tycho.nsa.gov>; Mon, 8 Jun 2015 22:01:54 -0400
Date: Tue, 9 Jun 2015 12:01:47 +1000 (AEST)
From: James Morris <jmorris@namei.org>
To: Paul Moore <pmoore@redhat.com>
Subject: Re: [GIT PULL] SELinux patches for 4.2
In-Reply-To: <1470471.fn8YxcfUZR@sifl>
Message-ID: <alpine.LRH.2.11.1506091201400.19198@namei.org>
References: <2158515.KYehkOGLZJ@sifl>
 <alpine.LRH.2.11.1506051520430.15998@namei.org> <1470471.fn8YxcfUZR@sifl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Fri, 5 Jun 2015, Paul Moore wrote:

> On Friday, June 05, 2015 03:20:57 PM James Morris wrote:
> > On Thu, 4 Jun 2015, Paul Moore wrote:
> > > Hi James,
> > > 
> > > Six SELinux patches for 4.2: two to add better labeling support for three
> > > pseudo filesystems, one netlink update, a __flush_signals() removal/fix,
> > > and a couple of minor cleanup patches.  Nothing too scary or large this
> > > time.
> > > 
> > > All patches pass the SELinux testsuite and the selinux#upstream branch is
> > > based on your linux-security#next branch as of about an hour ago.
> > 
> > Thanks, pulled.
> 
> Hi James,
> 
> My apologies, but one more last minute patch that really should go in for v4.2 
> as it fixes a labeled NFS regression.
> 

Applied.


> -Paul
> 
> ---
> The following changes since commit 42a9699a9fa179c0054ea3cf5ad3cc67104a6162:
> 
>   selinux: Remove unused permission definitions (2015-06-04 16:22:17 -0400)
> 
> are available in the git repository at:
> 
>   git://git.infradead.org/users/pcmoore/selinux upstream
> 
> for you to fetch changes up to 9fc2b4b436cff7d8403034676014f1be9d534942:
> 
>   selinux: fix setting of security labels on NFS (2015-06-05 14:21:48 -0400)
> 
> ----------------------------------------------------------------
> J. Bruce Fields (1):
>       selinux: fix setting of security labels on NFS
> 
>  security/selinux/hooks.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index daf59b4..312537d 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -403,6 +403,7 @@ static int selinux_is_sblabel_mnt(struct super_block *sb)
>         return sbsec->behavior == SECURITY_FS_USE_XATTR ||
>                 sbsec->behavior == SECURITY_FS_USE_TRANS ||
>                 sbsec->behavior == SECURITY_FS_USE_TASK ||
> +               sbsec->behavior == SECURITY_FS_USE_NATIVE ||
>                 /* Special handling. Genfs but also in-core setxattr handler 
> */
>                 !strcmp(sb->s_type->name, "sysfs") ||
>                 !strcmp(sb->s_type->name, "pstore") ||
> 
> 

-- 
James Morris
<jmorris@namei.org>
