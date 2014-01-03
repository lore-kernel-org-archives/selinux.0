Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s037KNnm016353
 for <selinux@tycho.nsa.gov>; Fri, 3 Jan 2014 02:20:23 -0500
Date: Fri, 3 Jan 2014 18:20:18 +1100 (EST)
From: James Morris <jmorris@namei.org>
To: Paul Moore <pmoore@redhat.com>
Subject: Re: [GIT PULL] SELinux patches for 3.14
In-Reply-To: <231455217.pFFWomdpV7@sifl>
Message-ID: <alpine.LRH.2.02.1401031817290.15881@tundra.namei.org>
References: <231455217.pFFWomdpV7@sifl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, 2 Jan 2014, Paul Moore wrote:

> Hi James,
> 
> With 3.13-rc6 out, it looks like it is time to pass along the SELinux pull 
> request for 3.14.  The tree below includes the patches listed here as well as 
> the 3.13-rcX fixes I've sent you previously (I've omitted the 3.13-rcX fixes 
> in the list below for the sake of clarity).  Of the five new patches here, all 
> but Richard's patch are fixes, and minor ones at that.
> 
> On a sorta related note, over the past month or two, I've learned that my 
> simplistic approach to managing the SELinux tree is just a wee bit too 
> simplistic.  After the 3.14 merge window closes I'm going to move to a branch 
> based approach which should make things a bit easier for everyone (okay, 
> mostly me) when it comes to -next and -stable.
> 
> Enjoy,
> -Paul
> 
> ---
> 
> The following changes since commit 5e01dc7b26d9f24f39abace5da98ccbd6a5ceb52:
> 
>   Linux 3.12 (2013-11-03 15:41:51 -0800)
> 
> are available in the git repository at:
> 
>   git://git.infradead.org/users/pcmoore/selinux master

Against my current next:
18952 files changed, 1930106 insertions(+), 883402 deletions(-)

Looks like you rebased your main branch for the mainline fixes -- usually 
these are done out of band.


-- 
James Morris
<jmorris@namei.org>
