Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id rBNMq9bn026395
 for <selinux@tycho.nsa.gov>; Mon, 23 Dec 2013 17:52:09 -0500
From: Paul Moore <pmoore@redhat.com>
To: James Morris <jmorris@namei.org>
Subject: Re: [GIT PULL] SELinux fixes for 3.13 (part three)
Date: Mon, 23 Dec 2013 17:51:46 -0500
Message-ID: <1950709.5nDMnn2W8Z@sifl>
In-Reply-To: <alpine.LRH.2.02.1312240933320.22187@tundra.namei.org>
References: <3917996.DVt9Qik8HG@sifl> <1678336.HYoZuQ9LME@sifl>
 <alpine.LRH.2.02.1312240933320.22187@tundra.namei.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tuesday, December 24, 2013 09:34:14 AM James Morris wrote:
> On Mon, 23 Dec 2013, Paul Moore wrote:
> > On Wednesday, December 18, 2013 05:04:26 PM Paul Moore wrote:
> > > Hi James,
> > > 
> > > Two more small patches for 3.13-rcX.  Both fix long standing issues, and
> > > both should be very uncontroversial.  FYI, I've left my previous sent
> > > 3.13-rcX fixes in the tree below, including the revert patch that Linus
> > > did himself before it could flow from the SELinux tree.
> 
> Can you make a new branch for me to pull from, based on current Linus?

Here ya go ...

---
The following changes since commit f5835372ebedf26847c2b9e193284075cc9c1f7f:

  Merge branch 'drm-fixes' of git://people.freedesktop.org/~airlied/linux 
(2013-12-23 11:49:16 -0800)

are available in the git repository at:

  git://git.infradead.org/users/pcmoore/selinux_fixes for_james

for you to fetch changes up to c0c1439541f5305b57a83d599af32b74182933fe:

  selinux: selinux_setprocattr()->ptrace_parent() needs rcu_read_lock() 
(2013-12-23 17:45:17 -0500)

----------------------------------------------------------------
Chad Hanson (1):
      selinux: fix broken peer recv check

Oleg Nesterov (1):
      selinux: selinux_setprocattr()->ptrace_parent() needs rcu_read_lock()

 security/selinux/hooks.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

-- 
paul moore
security and virtualization @ redhat
