Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id sB4LYUKx021442
 for <selinux@tycho.nsa.gov>; Thu, 4 Dec 2014 16:34:31 -0500
Date: Fri, 5 Dec 2014 08:34:24 +1100 (AEDT)
From: James Morris <jmorris@namei.org>
To: Paul Moore <pmoore@redhat.com>
Subject: Re: [GIT PULL] SELinux patches for 3.19
In-Reply-To: <1900089.YGF1Ms0ZgW@sifl>
Message-ID: <alpine.LRH.2.11.1412050834110.3179@namei.org>
References: <1900089.YGF1Ms0ZgW@sifl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wed, 3 Dec 2014, Paul Moore wrote:

> Hi James,
> 
> This pull request is later than usual because quite frankly I was waiting to 
> see if we would get anything substantial in the SELinux next branch.  While we 
> didn't end up with anything big, there is one small fix which removes an old, 
> unused extern declaration.
> 
> It's been a quiet few months in SELinux kernel land.
> 
> Enjoy,
> -Paul
> 
> ---
> The following changes since commit d950f84c1c6658faec2ecbf5b09f7e7191953394:
> 
>   selinux: convert WARN_ONCE() to printk() in selinux_nlmsg_perm()
>            (2014-11-12 16:14:02 -0500)
> 
> are available in the git repository at:
> 
>   git://git.infradead.org/users/pcmoore/selinux next
> 
> for you to fetch changes up to 00fec2a10b51a071ec92da256ccd30f6b13fc55b:
> 
>   selinux: Remove security_ops extern (2014-12-01 16:42:50 -0500)
> 

Pulled, thanks.

-- 
James Morris
<jmorris@namei.org>
