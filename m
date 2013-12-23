Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id rBNLJjCe022579
 for <selinux@tycho.nsa.gov>; Mon, 23 Dec 2013 16:19:45 -0500
From: Paul Moore <pmoore@redhat.com>
To: James Morris <jmorris@namei.org>
Subject: Re: [GIT PULL] SELinux fixes for 3.13 (part three)
Date: Mon, 23 Dec 2013 16:19:39 -0500
Message-ID: <1678336.HYoZuQ9LME@sifl>
In-Reply-To: <3917996.DVt9Qik8HG@sifl>
References: <3917996.DVt9Qik8HG@sifl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wednesday, December 18, 2013 05:04:26 PM Paul Moore wrote:
> Hi James,
> 
> Two more small patches for 3.13-rcX.  Both fix long standing issues, and
> both should be very uncontroversial.  FYI, I've left my previous sent
> 3.13-rcX fixes in the tree below, including the revert patch that Linus did
> himself before it could flow from the SELinux tree.
> 
> Enjoy,
> -Paul

These two patches really should go into the 3.13 release, the patch from Chad 
is particularly important.  Any hope of pushing this to Linus soon?

> ---
> The following changes are available in the git repository at:
> 
>   git://git.infradead.org/users/pcmoore/selinux_fixes master
> 
> for you to fetch changes up to 67439a11ae99e19cfdc3a8f6d7fde24e07e34acb:
> 
>   selinux: selinux_setprocattr()->ptrace_parent() needs rcu_read_lock()
> (2013-12-16 16:16:08 -0500)
> 
> ----------------------------------------------------------------
> Chad Hanson (1):
>       selinux: fix broken peer recv check
> 
> Oleg Nesterov (1):
>       selinux: selinux_setprocattr()->ptrace_parent() needs rcu_read_lock()
> 
>  security/selinux/hooks.c |    8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)

-- 
paul moore
security and virtualization @ redhat
