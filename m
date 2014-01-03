Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s03Dkagt029998
 for <selinux@tycho.nsa.gov>; Fri, 3 Jan 2014 08:46:37 -0500
From: Paul Moore <pmoore@redhat.com>
To: James Morris <jmorris@namei.org>
Subject: Re: [GIT PULL] SELinux patches for 3.14
Date: Fri, 03 Jan 2014 08:46:29 -0500
Message-ID: <1779478.s7lCfjzb0Q@sifl>
In-Reply-To: <alpine.LRH.2.02.1401031817290.15881@tundra.namei.org>
References: <231455217.pFFWomdpV7@sifl>
 <alpine.LRH.2.02.1401031817290.15881@tundra.namei.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Friday, January 03, 2014 06:20:18 PM James Morris wrote:
> On Thu, 2 Jan 2014, Paul Moore wrote:
> > Hi James,
> > 
> > With 3.13-rc6 out, it looks like it is time to pass along the SELinux pull
> > request for 3.14.  The tree below includes the patches listed here as well
> > as the 3.13-rcX fixes I've sent you previously (I've omitted the 3.13-rcX
> > fixes in the list below for the sake of clarity).  Of the five new
> > patches here, all but Richard's patch are fixes, and minor ones at that.
> > 
> > On a sorta related note, over the past month or two, I've learned that my
> > simplistic approach to managing the SELinux tree is just a wee bit too
> > simplistic.  After the 3.14 merge window closes I'm going to move to a
> > branch based approach which should make things a bit easier for everyone
> > (okay, mostly me) when it comes to -next and -stable.
> > 
> > Enjoy,
> > -Paul
> > 
> > ---
> > 
> > The following changes since commit 
5e01dc7b26d9f24f39abace5da98ccbd6a5ceb52:
> >   Linux 3.12 (2013-11-03 15:41:51 -0800)
> > 
> > are available in the git repository at:
> >   git://git.infradead.org/users/pcmoore/selinux master
> 
> Against my current next:
> 18952 files changed, 1930106 insertions(+), 883402 deletions(-)
> 
> Looks like you rebased your main branch for the mainline fixes -- usually
> these are done out of band.

No rebasing on my end, at least not an intentional one.  If I had to guess, I 
suspect the large difference is due to the fact that the SELinux tree is still 
based off 3.12 (see the git log and my pull request mail) while it looks like 
your next branch is 3.12-rc2 plus a bunch of security patches.

Regardless, I went ahead and grabbed your tree with the next branch, fetched 
the SELinux tree and cherry picked the five commits without major issue, here 
are the results:

# git cherry-pick a660bec1d84ad19a39e380af129e207b3b8f609e
[next a6b13e7] SELinux: Update policy version to support constraints info
 Author: Richard Haines <richard_c_haines@btinternet.com>
 4 files changed, 101 insertions(+), 10 deletions(-)

# git cherry-pick b5495b4217d3fa64deac479db83dbede149af7d8
[next fb3fe57] SELinux: security_load_policy: Silence frame-larger-than 
warning
 Author: Tim Gardner <tim.gardner@canonical.com>
 1 file changed, 32 insertions(+), 22 deletions(-)

# git cherry-pick 050d032b25e617cd738db8d6fd5aed24d87cbbcb
[next c33498f] selinux: ensure that the cached NetLabel secattr matches the 
desired SID
 1 file changed, 30 insertions(+), 1 deletion(-)

# git cherry-pick 0b1f24e6db9a60c1f68117ad158ea29faa7c3a7f
error: could not apply 0b1f24e... selinux: pull address family directly from 
the request_sock struct
{... this cherry-pick required a trivial conflict resolution in 
security/selinux/hooks.c:selinux_inet_conn_request(), it will be obvious when 
you see it ... }
# git cherry-pick --continue
[next 1844200] selinux: pull address family directly from the request_sock 
struct
 1 file changed, 2 insertions(+), 6 deletions(-)

# git cherry-pick a5e333d34037c64c5f667dee3c418b66874ba0b0
[next ca738ab] SELinux: remove duplicated include from hooks.c
 Author: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
 1 file changed, 1 deletion(-)

-- 
paul moore
security and virtualization @ redhat
