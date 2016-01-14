Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u0E0jNuZ023633
 for <selinux@tycho.nsa.gov>; Wed, 13 Jan 2016 19:45:23 -0500
Date: Thu, 14 Jan 2016 11:45:11 +1100 (AEDT)
From: James Morris <jmorris@namei.org>
To: Paul Moore <pmoore@redhat.com>
cc: selinux@tycho.nsa.gov, linux-security-module@vger.kernel.org
Subject: Re: [GIT PULL] SELinux fixes for 4.5 (#1)
In-Reply-To: <3191799.mSsedcI0tg@sifl>
Message-ID: <alpine.LRH.2.20.1601141145001.10293@namei.org>
References: <3191799.mSsedcI0tg@sifl>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Mon, 11 Jan 2016, Paul Moore wrote:

> Hi James,
> 
> A single small patch to address a performance regression in the SELinux pull 
> request from late December.  Please apply.
> 
> -Paul
> 
> ---
> The following changes since commit 76319946f321e30872dd72af7de867cb26e7a373:
> 
>   selinux: rate-limit netlink message warnings in selinux_nlmsg_perm() 
>            (2015-12-24 11:09:41 -0500)
> 
> are available in the git repository at:
> 
>   git://git.infradead.org/users/pcmoore/selinux upstream
> 
> for you to fetch changes up to b197367ed1ba81b0d26f7e7f76f61731ac6e5842:
> 
>   selinux: Inode label revalidation performance fix
>            (2016-01-08 16:24:27 -0500)
> 
> ----------------------------------------------------------------
> Andreas Gruenbacher (1):
>       selinux: Inode label revalidation performance fix
> 
>  security/selinux/hooks.c | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)
> 


Pulled, thanks.

-- 
James Morris
<jmorris@namei.org>
