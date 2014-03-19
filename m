Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s2JKufaE017254
 for <selinux@tycho.nsa.gov>; Wed, 19 Mar 2014 16:56:41 -0400
From: Paul Moore <pmoore@redhat.com>
To: James Morris <jmorris@namei.org>
Subject: Re: [GIT PULL] SELinux patches for 3.15
Date: Wed, 19 Mar 2014 16:56:34 -0400
Message-ID: <1613579.G4CRZlKD1J@sifl>
In-Reply-To: <alpine.LRH.2.02.1403190843080.18776@tundra.namei.org>
References: <2794067.Wx0yCIiBrQ@sifl> <2065464.ftu8fijlua@sifl>
 <alpine.LRH.2.02.1403190843080.18776@tundra.namei.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: LSM List <linux-security-module@vger.kernel.org>,
 SE-Linux <selinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wednesday, March 19, 2014 08:50:03 AM James Morris wrote:
> On Tue, 18 Mar 2014, Paul Moore wrote:
> > On Tuesday, March 18, 2014 01:26:40 PM James Morris wrote:
> > > On Mon, 17 Mar 2014, Paul Moore wrote:
> > > > This issue with the linux-security tree keeps coming up and I stand by
> > > > my earlier statements that I would much prefer if the linux-security
> > > > is based off the latest kernel release, e.g. 3.13 as of today.  This
> > > > seems to be in keeping with Linus' comments, fits with what Eric was
> > > > doing back when he managed the SELinux tree, and strikes a nice
> > > > balance between stability and "newness".  I plan on continuing with
> > > > this approach for the SELinux tree.
> > > > 
> > > > However, I don't want the 3.15 patches to get lost due to these stupid
> > > > differences so I've created a new branch that has the SELinux 3.15
> > > > patches applied on top of linux-security#next.
> > > > 
> > > >  * git://git.infradead.org/users/pcmoore/selinux next
> > > 
> > > What's the new branch?  That seems to be the same.
> > 
> > My mistake, the new branch is "next-jmorris".
> 
> 195 files changed, 1348 insertions(+), 885 deletions(-)

It should be more to your liking now.

# git pull git://git.infradead.org/users/pcmoore/selinux next-jmorris
remote: Counting objects: 15, done.
remote: Compressing objects: 100% (11/11), done.
remote: Total 11 (delta 8), reused 0 (delta 0)
Unpacking objects: 100% (11/11), done.
>From git://git.infradead.org/users/pcmoore/selinux
 * branch            next-jmorris -> FETCH_HEAD
Updating 33b2533..f64410e
Fast-forward
 security/selinux/hooks.c | 56 
++++++++++++++++++++++++++++++------------------
 1 file changed, 35 insertions(+), 21 deletions(-)

-- 
paul moore
security and virtualization @ redhat
